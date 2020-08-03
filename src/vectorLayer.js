const { Pool, Client } = require('pg')
var ogr2ogr = require('ogr2ogr');
var { PythonShell } = require('python-shell')
const config = require('../config')
const promiseFinally = require('promise.prototype.finally');
promiseFinally.shim();

const pte_projet = require('../config_projet')
const { get_projet_qgis, get_all_projet_qgis } = require('./projet')
const path_script_python = config.path_script_python
const {
    update_style_couche_qgis
} = require('./style')

/**
 * Reload all qgis projects
 * @param {string} projet_qgis 
 * @param {Function} cb 
 */
var reload_all_qgis = function (projet_qgis, cb) {

    get_all_projet_qgis(projet_qgis, function (response) {
        if (response.error) {
            console.log("Impossible de trouver les projets QGIS ")

        } else {
            all_projet_qgis = response.path_projet_qgis_projet

            var compteur = []
            var check_function = function (a) {
                if (compteur.length == all_projet_qgis.length) {
                    console.log('mise à jour terminé avec succès')
                    cb({
                        error: false,
                        msg: ''
                    })
                } else {
                    reload_projet_qgis(all_projet_qgis[compteur.length], function (response) {
                        check_function(a)
                    })
                }
                compteur.push(a)
            }

            if (all_projet_qgis.length > 0) {
                check_function(2)
            } else {
                console.log('finish')
            }

        }
    })



}

/**
 * execute une requète sql avec ogr2ogr pour ecrirer un gpkg en 4326
 * @param {number} i iteration
 * @param {string} path_shp chemin ou il devra ecrire le gpkg
 * @param {Object} bd_access parametre de connexion à la BD
 * @param {string | Array<string>} sql la requète
 * @param {Funtion} cb callback
 */
function executeOgr2ogrFun(i, path_shp, bd_access, sql, cb) {

    var type = 'GPKG'

    var shapefile = ogr2ogr('PG:host=' + bd_access.host + ' port=5432 user=' + bd_access.user + ' dbname=' + bd_access.database + ' password=' + bd_access.password)
        .format(type)
        .options(["--config", "CPL_DEBUG", "ON", "-sql", sql])
        .project('EPSG:4326')
        .timeout(1800000)
        .onStderr(function (data) {
            //console.log('azerty',data);
        })
        .skipfailures()
        .destination(path_shp);

    shapefile.exec(function (er, data) {
        cb(i)
    })

    console.log(i, path_shp)

}

/**
 * reload one projet qgis
 * @param {string} path_projet_qgis_projet 
 * @param {Funtion} cb callback
 */
function reload_projet_qgis(path_projet_qgis_projet, cb) {
    let options = {
        mode: 'text',
        pythonPath: 'python3',
        args: [path_projet_qgis_projet]
    };
    PythonShell.run(path_script_python + '/reload_qgis_project.py', options, function (err, results) {

        if (err) {
            console.log(err)
            cb({
                error: true,
                msg: err
            })
        } else {
            console.log(results, path_projet_qgis_projet, ' a bien été rechargée')
            cb({
                error: false,
                msg: results
            })
        }

    });
}

/**
 * @typedef {Object} tableProperties
 * @property {string} table - la table
 * @property {string} shema - le shema
 */
/**
 * Recuperer le nom de la table et du shema d'une couche, qu'elle sois dans une sous ou non-sous thematique
 * @param {string} projet_qgis
 * @param {number} id_couche id de la couche dans couche-sous-thematique ou couche-thematique
 * @param {Function} cb callback
 * @return {tableProperties|false} false si il trouve pas 
 */
var getTableOfLayer = function (projet_qgis, id_couche, cb) {
    var bd_access = pte_projet(projet_qgis).bd_access
    var destination = pte_projet(projet_qgis).destination
    const pool = new Pool(bd_access)

    var getShema = function (id_thematique, cb2) {
        var pool_shema = new Pool(bd_access)
        pool_shema.query('SELECT * from public.thematique where id=' + id_thematique, (err, response) => {
            pool_shema.end()
            var query = response.rows

            if (query.length > 0) {
                var shema = query[0]['shema']
                cb2(shema)
            } else {
                cb2(false)
            }
        })
    }

    pool.query('SELECT cst.id_couche,st."id-thematique" from public."couche-sous-thematique" as cst, public."sous-thematique" as st where cst.id=' + id_couche + ' and st.id=cst."id-sous-thematique"', (err, response) => {
        pool.end()
        var query = response.rows
        if (query.length > 0) {
            var table = query[0]['id_couche']
            getShema(query[0]['id-thematique'], function (res) {
                var shema = res
                console.log(table, shema, '4545')
                if (shema) {
                    cb({
                        table: table,
                        shema: shema
                    })
                } else {
                    cb(false)
                }
            })

        } else {
            var pool_ct = new Pool(bd_access)
            pool_ct.query('SELECT ct.id_couche,t.shema from public."couche-thematique" as ct, public.thematique as t where ct.id=' + id_couche + ' and t.id=ct."id-thematique"', (err, response) => {
                pool_ct.end()
                var query = response.rows
                if (query.length > 0) {
                    var table = query[0]['id_couche']
                    var shema = query[0]['shema']
                    if (shema) {
                        cb({
                            table: table,
                            shema: table
                        })
                    } else {
                        cb(false)
                    }
                } else {
                    cb(false)
                }
            })
        }
    })
}

/**
 * Regenerate all GPKG files of a geosm project and reload all his QGIS projects at the end
 * @param {string} projet_qgis 
 */
var generateAllShapeFromOsmBuilder = function (projet_qgis) {

    var bd_access = pte_projet(projet_qgis).bd_access
    var destination = pte_projet(projet_qgis).destination
    var path_projet_qgis_projet = null
    const pool = new Pool(bd_access)

    pool.query('SELECT * from public.categorie where sql is not null', (err, response) => {
        pool.end()

        var query = response.rows
        var i = 0

        console.log(query.length)

        var executeOgr2ogr = function (i) {
            get_projet_qgis(projet_qgis, query[i].sous_thematiques, query[i].key_couche, function (response) {
                if (response.error) {
                    console.log(query[i].nom_cat, "Impossible de produire le fichier, projet QGIS introuvable")
                    check_function(i)
                } else {
                    path_projet_qgis_projet = response.path_projet_qgis_projet

                    var nom_shp = query[i].nom_cat.replace(/[^a-zA-Z0-9]/g, '_') + '_' + query[i].sous_thematiques + '_' + query[i].key_couche + '_' + query[i].id_cat

                    executeOgr2ogrFun(i, destination + nom_shp + '.gpkg', bd_access, query[i].sql, function () {
                        check_function(i)
                    })


                }
            })
        }

        if (query.length > 0) {
            executeOgr2ogr(i)
        } else {
            console.log('finish')
        }
        var compteur = []
        var check_function = function (a) {
            compteur.push(a)
            if (compteur.length == query.length) {
                reload_all_qgis(projet_qgis, function (results) {
                    console.log(results, 'Reset terminé')
                    process.exit()
                })
            } else {
                executeOgr2ogr(compteur.length)
            }

        }

    })
}

/**
 * Add Layer to a QGIS projetc
 * @param {string} path_projet_qgis_projet 
 * @param {string} nom_shp 
 * @param {string} name_layer 
 * @returns {Promise} Boolean
 */
var addGpkgLayerToProjet = async function (path_projet_qgis_projet, nom_shp, name_layer) {

    let options = {
        mode: 'text',
        pythonPath: 'python3',
        //pythonOptions: ['-u'], // get print results in real-time 
        //scriptPath: 'path/to/my/scripts',
        args: [path_projet_qgis_projet, nom_shp, name_layer]
    };
    return await new Promise(resolve => {
        PythonShell.run(path_script_python + '/add_vector_layer.py', options, function (err, results) {
            if (err) throw err;
            if (Array.isArray(results) && results[0] == 'ok') {
                resolve(true)

            } else {
                console.log('un problème est survenu lors de l ajout d une couche :  ', nom_shp, err, results)
                resolve(false)
            }

        })
    })

}
/**
 * Reset all QGIS project of a GEOSM project.
 * NB: doesn't regenerate GPKG files ! Only recreate all QGIS projects
 * @param {string} projet_qgis 
 */
var resetProjet = function (projet_qgis, id_thematique) {
    var bd_access = pte_projet(projet_qgis).bd_access
    var destination = pte_projet(projet_qgis).destination
    var path_projet_qgis_projet = null
    const pool = new Pool(bd_access)

    pool.query('SELECT * from public.categorie where sql is not null', (err, response) => {
        pool.end()
        var query = response.rows
        var i = 0
        console.log(query.length, ' Couche à ajouter')

        var executeOgr2ogr = function (i) {
            get_projet_qgis(projet_qgis, query[i].sous_thematiques, query[i].key_couche, function (response) {
                if (response.error) {
                    console.log(i, 'Impossible de trouver son projet ', query[i].sous_thematiques, query[i].key_couche)
                    check_function(i)
                } else {
                    path_projet_qgis_projet = response.path_projet_qgis_projet
                    var id_thematique_projet = response.id_thematique

                    if (id_thematique == null || id_thematique == id_thematique_projet) {
                        var nom_shp = query[i].nom_cat.replace(/[^a-zA-Z0-9]/g, '_') + '_' + query[i].sous_thematiques + '_' + query[i].key_couche + '_' + query[i].id_cat + '.gpkg'
                        addGpkgLayerToProjet(path_projet_qgis_projet, destination + nom_shp, query[i].nom_cat.replace(/[^a-zA-Z0-9]/g, '_'))
                            .finally(() => {
                            })
                            .then((response_whrite_gpkg) => {
                                console.log(i, "couche ajoutée", response_whrite_gpkg)
                                i++
                                if (query.length - 1 == i) {
                                    console.log('reset du projet terminé')
                                    process.exit()
                                } else {
                                    check_function(i)
                                }

                            })
                    } else {
                        console.log(i, ' sur pas à ajouter ', query.length, nom_shp)
                        check_function(i)
                    }
                }
            })
        }

        if (query.length > 0) {
            executeOgr2ogr(i)
        } else {
            console.log('finish')
        }
        var compteur = []
        var check_function = function (a) {
            compteur.push(a)
            if (compteur.length == query.length) {
                reload_projet_qgis(projet_qgis, function (results) {
                    console.log(results, 'Reset terminé')
                    process.exit()
                })
            } else {
                executeOgr2ogr(compteur.length)
            }

        }

    })

}

/**
 * Regenerate all GPKG files of a geosm project and update url + identifiant of QGIS server in database
 * reload all his QGIS projects at the end
 * @param {string} projet_qgis 
 */
var generateAllShapeFromOsmBuilderCreate = function (projet_qgis, id_thematique) {
    var bd_access = pte_projet(projet_qgis).bd_access
    var destination = pte_projet(projet_qgis).destination
    var path_projet_qgis_projet = null
    var path_projet_qgis_projet_docker = null
    const pool = new Pool(bd_access)

    pool.query('SELECT * from public.categorie where sql is not null', (err, response) => {
        pool.end()

        var query = response.rows
        var i = 0

        console.log(query.length, ' Opérations')


        var executeOgr2ogr = function (i) {

            get_projet_qgis(projet_qgis, query[i].sous_thematiques, query[i].key_couche, function (response) {
                if (response.error) {
                    console.log("Impossible d'ajouter, projet QGIS introuvable")
                    check_function(i)
                } else {
                    path_projet_qgis_projet = response.path_projet_qgis_projet
                    path_projet_qgis_projet_docker = response.path_projet_qgis_projet_docker
                    var id_thematique_projet = response.id_thematique
                    if (id_thematique == null || id_thematique == id_thematique_projet) {


                        var nom_shp = query[i].nom_cat.replace(/[^a-zA-Z0-9]/g, '_') + '_' + query[i].sous_thematiques + '_' + query[i].key_couche + '_' + query[i].id_cat + '.gpkg'
                        var name_layer = query[i].nom_cat.replace(/[^a-zA-Z0-9]/g, '_')
                        var key_couche = query[i].key_couche

                        getTableOfLayer(projet_qgis, key_couche, function (result) {
                            var sql = 'SELECT * FROM ' + result.shema + '."' + result.table + '"'
                            console.log(sql, 'ici')

                            executeOgr2ogrFun(i, destination + nom_shp, bd_access, sql, function () {
                                addGpkgLayerToProjet(path_projet_qgis_projet, destination + nom_shp, name_layer).finally(() => {

                                })
                                    .then((response_whrite_gpkg) => {
                                        if (response_whrite_gpkg) {
                                            var pool1 = new Pool(pte_projet(projet_qgis).bd_access)

                                            var url = config.url_qgis_server + path_projet_qgis_projet_docker

                                            if (query[i].sous_thematiques) {
                                                var query_update = 'UPDATE public."couche-sous-thematique" SET url= \' ' + url + '\', identifiant= \'' + name_layer + '\' WHERE id =' + key_couche
                                            } else {
                                                var query_update = 'UPDATE public."couche-thematique" SET url= \' ' + url + ' \', identifiant= \'' + name_layer + '\' WHERE id =' + key_couche
                                            }

                                            pool1.query(query_update, (err, response) => {
                                                pool1.end()

                                                check_function(i)
                                            })
                                        } else {
                                            check_function(i)
                                        }
                                        console.log(i, ' sur ', query.length, nom_shp)
                                    })
                            })
                        })
                    } else {
                        console.log(i, ' sur pas à modifier ', query.length, nom_shp)
                        check_function(i)
                    }


                }
            })
        }

        if (query.length > 0) {
            executeOgr2ogr(i)
        } else {
            console.log('finish')
        }
        var compteur = []
        var check_function = function (a) {
            compteur.push(a)

            if (compteur.length == query.length) {
                reload_projet_qgis(projet_qgis, function (results) {
                    console.log(results, 'initialisation terminé')
                    process.exit()
                })
            } else {
                executeOgr2ogr(compteur.length)
            }

        }


    })
}

/**
 * Generate one GPKG, add it to his QGIS Project. Style layer at the end
 * @param {string} projet_qgis 
 * @param {number} id_cat 
 * @param {boolean} addtowms add it to QGIS Project or it is a update ?
 * @param {function} cb callbck
 */
var generateOneShapeFromOsmBuilder = function (projet_qgis, id_cat, addtowms, cb) {
    var destination = pte_projet(projet_qgis).destination
    var bd_access = pte_projet(projet_qgis).bd_access
    var path_projet_qgis_projet = null
    var path_projet_qgis_projet_docker = null
    const pool = new Pool(pte_projet(projet_qgis).bd_access)

    pool.query('SELECT * from public.categorie where id_cat = ' + id_cat, (err, response) => {
        pool.end()
        var query = response.rows[0]

        get_projet_qgis(projet_qgis, query.sous_thematiques, query.key_couche, function (response) {
            if (response.error) {
                res.send({
                    'status': false,
                    'message': "Impossible d'ajouter, projet QGIS introuvable"
                })
            } else {
                path_projet_qgis_projet = response.path_projet_qgis_projet
                path_projet_qgis_projet_docker = response.path_projet_qgis_projet_docker

                var type = "GPKG"
                var nom_shp = query.nom_cat.replace(/[^a-zA-Z0-9]/g, '_') + '_' + query.sous_thematiques + '_' + query.key_couche + '_' + query.id_cat + '.gpkg'

                var add_to_qgis = function () {

                    if (addtowms == 'false') {

                        reload_projet_qgis(path_projet_qgis_projet, function (params) {
                            cb({
                                'status': 'ok',
                                'addtowms': false
                            })
                        })

                    } else if (addtowms == 'true') {
                        addGpkgLayerToProjet(path_projet_qgis_projet, destination + nom_shp, query.nom_cat.replace(/[^a-zA-Z0-9]/g, '_'))
                            .finally(() => {
                            })
                            .then(
                                (response_whrite_gpkg) => {
                                    if (response_whrite_gpkg) {

                                        console.log("couche ajoutée", response_whrite_gpkg)
                                        const pool1 = new Pool(pte_projet(projet_qgis).bd_access)

                                        var url = config.url_qgis_server + path_projet_qgis_projet_docker

                                        if (query.sous_thematiques) {
                                            var query_update = 'UPDATE public."couche-sous-thematique" SET url= \' ' + url + '\', identifiant= \'' + query.nom_cat.replace(/[^a-zA-Z0-9]/g, '_') + '\' WHERE id =' + query.key_couche
                                        } else {
                                            var query_update = 'UPDATE public."couche-thematique" SET url= \' ' + url + ' \', identifiant= \'' + query.nom_cat.replace(/[^a-zA-Z0-9]/g, '_') + '\' WHERE id =' + query.key_couche
                                        }

                                        pool1.query(query_update, (err, response) => {
                                            pool1.end()
                                            //console.log('sql =',response, 'results: ', results,query_update)
                                            update_style_couche_qgis(projet_qgis, query.nom_cat.replace(/[^a-zA-Z0-9]/g, '_'))
                                            cb({
                                                'status': 'ok',
                                                'addtowms': true,
                                                'identifiant': query.nom_cat.replace(/[^a-zA-Z0-9]/g, '_'),
                                                'projet_qgis': url
                                            })
                                        })

                                    } else {
                                        cb({
                                            'status': 'ko',
                                        })
                                    }

                                },
                                (error) => {
                                    cb({
                                        'status': false,
                                        'message': error
                                    })
                                }
                            )

                    }
                }

                //console.log(query.sql.split(';').length, "sql")
                getTableOfLayer(projet_qgis, query.key_couche, function (result) {
                    var sql = 'SELECT * FROM ' + result.shema + '."' + result.table + '"'
                    // console.log(sql, result)
                    var shapefile = ogr2ogr('PG:host=' + bd_access.host + ' port=5432 user=' + bd_access.user + ' dbname=' + bd_access.database + ' password=' + bd_access.password)
                        .format(type)
                        .options(["--config", "CPL_DEBUG", "ON", "-sql", sql])
                        .project('EPSG:4326')
                        .timeout(1800000)
                        .onStderr(function (data) {
                            // console.log('azerty', data);
                        })
                        .skipfailures()
                        .destination(destination + nom_shp);

                    shapefile.exec(function (er, data) {
                        add_to_qgis()
                    })
                })

            }
        })
    })
}

module.exports = {
    generateAllShapeFromOsmBuilder: generateAllShapeFromOsmBuilder,
    addGpkgLayerToProjet: addGpkgLayerToProjet,
    resetProjet: resetProjet,
    reload_all_qgis: reload_all_qgis,
    generateAllShapeFromOsmBuilderCreate: generateAllShapeFromOsmBuilderCreate,
    generateOneShapeFromOsmBuilder: generateOneShapeFromOsmBuilder,
};