const { Pool, Client } = require('pg')
var { PythonShell } = require('python-shell')
const promiseFinally = require('promise.prototype.finally');
promiseFinally.shim();
const config = require('../config')

const pte_projet = require('../config_projet')
const { get_projet_qgis, get_all_projet_qgis } = require('./projet')

const path_style_qml = config.path_style_qml + '/'
const path_style_qml_template = config.path_style_qml_template
const path_script_python = config.path_script_python


/**
 * Apply a cluster style on a layer using an icon [png,jpeg,svg...]
 * @param {Object} props {projet_qgis:path projet qgis,icon_png:path of icon,layername:layername,destination:directory to store temporarely files}
 * @param {string} projet_qgis 
 */
async function cluster_layer_point(props, projet_qgis) {

    let options = {
        mode: 'text',
        pythonPath: 'python3',
        pythonOptions: ['-u'], // get print results in real-time
        args: [props['projet_qgis'], props['icon_png'], props["layername"], props["destination"], path_style_qml_template + 'clusters.qml']
    };

    return await new Promise(resolve => {

        PythonShell.run(path_script_python + '/set_icon_on_lyer.py', options, function (err, results) {
            console.log(results)
            if (err) {
                console.error(err)
                resolve(false)
            } else {
                save_qml_layer_projet(props, props['projet_qgis'], props["destination"] + '/../style/')
                console.log('Clusterisation termine')
                resolve(true)
            }

        })
    })

}

/**
 * Save qml file of a layer
 * @param {Object} props {layername,id_couche}
 * @param {string} projet_qgis 
 */
async function save_qml_layer_projet(props, projet_qgis, destination_style) {

    var path_projet_qgis = projet_qgis

    let options = {
        mode: 'text',
        pythonPath: 'python3',
        pythonOptions: ['-u'], // get print results in real-time
        args: [path_projet_qgis, props["layername"], props["id_couche"], destination_style]
    };
    console.log(path_projet_qgis, props["layername"], destination_style)
    return await new Promise(resolve => {
        PythonShell.run(path_script_python + '/save_qml_layer_projet.py', options, function (err, results) {

            if (err) {
                console.error(err)
                resolve.log(false)
            }

            console.log('Fichier de Style sauvergardé avec succès')
            resolve(destination_style + '/' + props["id_couche"] + '.qml')
        })
    })

}

/**
 * Update style of a layer in QGIS project with his icones
 * @param {string} projet_qgis 
 * @param {string} identifiant 
 * @returns {Promise}
 */
var update_style_couche_qgis = async function (projet_qgis, identifiant) {
    var destination = pte_projet(projet_qgis).destination
    var destination_style = pte_projet(projet_qgis).destination_style
    var path_projet_qgis = null
    var path_backend = pte_projet(projet_qgis).path_backend

    const pool = new Pool(pte_projet(projet_qgis).bd_access)

    return await new Promise((resolve,reject) => {
        pool.query("SELECT identifiant,id_couche,geom,image_src, 'true' as sous_thematiques,id from public." + '"couche-sous-thematique"' + "where identifiant='" + identifiant + "' UNION SELECT identifiant,id_couche,geom,image_src, 'false' as sous_thematiques,id from public." + '"couche-thematique"' + "where identifiant='" + identifiant + "'", function (err, response) {
            pool.end()

            var rows = response.rows
            if (rows.length > 0) {
                var couche = rows[0]
                if (couche.geom == 'point') {
                    console.log('on est ici les gars')
                    get_projet_qgis(projet_qgis, couche.sous_thematiques, couche.id, function (response) {
                        if (response.error) {
                            console.log("Impossible d'ajouter, projet QGIS introuvable")
                            reject("Impossible d'ajouter, projet QGIS introuvable")
                        } else {
                            path_projet_qgis = response.path_projet_qgis_projet

                            var icon_path = path_backend + 'public/' + couche['image_src']
                            var layername = couche['identifiant']
                            var id_couche = couche['id_couche']
                            var pte = {
                                'projet_qgis': path_projet_qgis,
                                'icon_png': icon_path,
                                'layername': layername,
                                'id_couche': id_couche,
                                'destination': destination,
                            }
                            // console.log(pte)
                            return cluster_layer_point(pte, projet_qgis)
                                .finally(() => {

                                })
                                .then((data) => {
                                    console.log('Clusterisation termine !')
                                    resolve(data)
                                })
                                .catch((error)=>{
                                    console.log('hahah',error)
                                    reject(error)
                                   
                                }
                                 
                            )

                        }
                    })

                }
            }
        })

    })
}

/**
 * Apply style qml on a layer in QGIS
 * @param {string} projet_qgis 
 * @param {string} style_file_name 
 * @param {string} idndifiant 
 * @param {Function} cb 
 */
var set_style_qml = function (projet_qgis, style_file_name, idndifiant, cb) {
    var destination = pte_projet(projet_qgis).destination
    var destination_style = pte_projet(projet_qgis).destination_style
    var path_projet_qgis = null

    var style_file = path_style_qml + style_file_name

    var layername = idndifiant

    const pool = new Pool(pte_projet(projet_qgis).bd_access)

    pool.query("SELECT identifiant,id_couche, 'true' as sous_thematiques,id from public." + '"couche-sous-thematique"' + "where identifiant='" + layername + "' UNION SELECT identifiant,id_couche, 'false' as sous_thematiques,id from public." + '"couche-thematique"' + " where identifiant='" + layername + "'", function (err, response) {

        var rows = response.rows

        if (rows.length > 0) {
            var element = rows[0];
            get_projet_qgis(projet_qgis, element.sous_thematiques, element.id, function (response) {
                if (response.error) {
                    console.log("Impossible d'ajouter, projet QGIS introuvable")

                } else {
                    path_projet_qgis = response.path_projet_qgis_projet

                    let options = {
                        mode: 'text',
                        pythonPath: 'python3',
                        //pythonOptions: ['-u'], // get print results in real-time
                        //scriptPath: 'path/to/my/scripts',
                        args: [path_projet_qgis, style_file, layername]
                    };

                    PythonShell.run(path_script_python + '/set_style_on_layer.py', options, function (err, results) {

                        if (err || results == 'ko') {
                            console(err)
                            cb({
                                'status': 'ko'
                            })
                        } else if (results == 'ok') {
                            var layername = element['identifiant']
                            var id_couche = element['id_couche']
                            var pte = {
                                'id_couche': id_couche,
                                'layername': layername,
                            }

                            cb({
                                'status': 'ok'
                            })

                            save_qml_layer_projet(pte, path_projet_qgis, destination_style)

                        }
                    })
                }
            })

        }

        pool.end()
    })
}

/**
 * Apply style on 
 * @param {string} projet_qgis 
 */
var setStyleAllShapeFromOsmBuilderCreate = function (projet_qgis, id_thematique) {
    const pool = new Pool(pte_projet(projet_qgis).bd_access)
    var destination = pte_projet(projet_qgis).destination
    var destination_style = pte_projet(projet_qgis).destination_style
    var path_projet_qgis_projet = null

    pool.query("SELECT identifiant,id_couche, geom,'true' as sous_thematiques, id from public." + '"couche-sous-thematique"' + "where wms_type='osm' UNION SELECT identifiant,id_couche,geom,'false' as sous_thematiques, id from public." + '"couche-thematique"' + "where wms_type='osm'", function (err, response) {
        pool.end()

        var rows = response.rows
        var i = 0;

        function set_qml(props) {
            var style_file = destination_style + props["id_couche"] + '.qml'
            console.log('on continue ici mdrr',props['layername'] ,i)
                    i = i + 1
                    if (props['geom'] == 'point' && props['layername']) {
                        console.log('le salopard ',i)
                        update_style_couche_qgis(projet_qgis, props["layername"])
                            .finally(() => {
                                console.log('finally',i)
                                
                                // console.log(i, ' / ', rows.length, props["layername"], 'Style par defaut non trouvé')
                            })
                            .then((data) => {
                                // console.log('then',i)
                                
                                setTimeout(function(){
                                    console.log(data, 'update_style_couche_qgis termine, a t il marché ?')
                                    check_function(i)
                                },2000)
                                
                            })
                            .catch((err) => {
                                console.log('catch',err,i)
                                check_function(i)
                            })
                    } else {
                        console.log('ah ok ok ',i)
                        check_function(i)
                    }
           

        }

        var compteur = []

        var check_function = function (a) {

            if (compteur.length == rows.length) {
                console.log('termine')
                process.exit()
            } else {
                var element = rows[compteur.length];
                get_projet_qgis(projet_qgis, element.sous_thematiques, element.id, function (response) {
                    if (response.error) {
                        console.log("Impossible d'ajouter, projet QGIS introuvable")
                        check_function(455555)
                    } else {
                        path_projet_qgis_projet = response.path_projet_qgis_projet
                        var id_thematique_projet = response.id_thematique

                        if (id_thematique == null || id_thematique == id_thematique_projet) {
                            var layername = element['identifiant']
                            var id_couche = element['id_couche']
                            var pte = {
                                'projet_qgis': path_projet_qgis_projet,
                                'id_couche': id_couche,
                                'layername': layername,
                                'geom': element['geom'],
                            }
                            set_qml(pte)
                        } else {
                            console.log(i, ' sur pas à appliquer le style ')
                            check_function(i)
                        }

                    }
                })
            }

            compteur.push(a)
        }

        console.log('start', rows.length)

        if (rows.length > 0) {
            check_function(i)
        } else {
            console.log('finish')
            process.exit()
        }

    })
}

/**
 * sauvegarde et renvois le lien d'un qml
 * @param {string} projet_qgis 
 * @param {string} identifiant 
 * @returns {Promise}
 */
var saveAndDownloadStyleQgis = async function (projet_qgis, identifiant) {
    var destination = pte_projet(projet_qgis).destination
    var destination_style = pte_projet(projet_qgis).destination_style
    var path_projet_qgis = null
    var path_backend = pte_projet(projet_qgis).path_backend

    const pool = new Pool(pte_projet(projet_qgis).bd_access)

    return await new Promise(resolve => {
        pool.query("SELECT identifiant,id_couche,geom,image_src, 'true' as sous_thematiques,id from public." + '"couche-sous-thematique"' + "where identifiant='" + identifiant + "' UNION SELECT identifiant,id_couche,geom,image_src, 'false' as sous_thematiques,id from public." + '"couche-thematique"' + "where identifiant='" + identifiant + "'", function (err, response) {
            pool.end()

            var rows = response.rows
            if (rows.length > 0) {
                var couche = rows[0]
                if (couche.geom == 'point') {

                    get_projet_qgis(projet_qgis, couche.sous_thematiques, couche.id, function (response) {
                        if (response.error) {
                            console.log("Impossible d'ajouter, projet QGIS introuvable")

                        } else {
                            path_projet_qgis = response.path_projet_qgis_projet

                            var icon_path = path_backend + 'public/' + couche['image_src']
                            var layername = couche['identifiant']
                            var id_couche = couche['id_couche']
                            var pte = {
                                'projet_qgis': path_projet_qgis,
                                'icon_png': icon_path,
                                'layername': layername,
                                'id_couche': id_couche,
                                'destination': destination,
                            }
                            console.log(pte)
                            save_qml_layer_projet(pte, pte['projet_qgis'], pte["destination"] + '/../style/').finally(() => {

                            })
                                .then((url) => {
                                    resolve(url)
                                })

                        }
                    })

                }
            }
        })

    })
}

module.exports = {
    update_style_couche_qgis: update_style_couche_qgis,
    set_style_qml: set_style_qml,
    setStyleAllShapeFromOsmBuilderCreate: setStyleAllShapeFromOsmBuilderCreate,
    saveAndDownloadStyleQgis: saveAndDownloadStyleQgis
};