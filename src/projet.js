const pte_projet = require('../config_projet')
const { Pool, Client } = require('pg')
/**
 * get the path projet qgis of a layer by key_couche
 * @param {string} projet_qgis 
 * @param {boolean} sous_thematiques 
 * @param {number} key_couche 
 * @param {Function} cb 
 */
var get_projet_qgis = function (projet_qgis, sous_thematiques, key_couche, cb) {
	var bd_access = pte_projet(projet_qgis).bd_access
	var destination = pte_projet(projet_qgis).destination
	const pool = new Pool(pte_projet(projet_qgis).bd_access)
	if (JSON.parse(sous_thematiques)) {
		var sql = 'select "id-thematique",cs.nom from "couche-sous-thematique" as cs,"sous-thematique" as st where cs.id =' + key_couche + ' and "id-sous-thematique" = st.id ';
	} else {
		var sql = 'select "id-thematique",nom from "couche-thematique" where id =' + key_couche;
	}
	// console.log(sql)
	pool.query(sql, (err, response) => {
		var query = response.rows

		if (query.length == 1) {
			// console.log(query[0]['nom'])
			var id_thematique = query[0]['id-thematique']
			var path_projet_qgis_projet = destination + '/../' + projet_qgis + id_thematique.toString() + '.qgs'
			var path_projet_qgis_projet_docker = projet_qgis + '/' + projet_qgis + id_thematique.toString() + '.qgs'

			cb({
				'error': false,
				path_projet_qgis_projet: path_projet_qgis_projet,
				id_thematique:id_thematique,
				path_projet_qgis_projet_docker:path_projet_qgis_projet_docker
			})
		} else {
			cb({
				'error': true,
				path_projet_qgis_projet: null
			})
		}
		pool.end()
	})
}

var get_all_projet_qgis = function (projet_qgis,cb) {
    var bd_access = pte_projet(projet_qgis).bd_access
	var destination = pte_projet(projet_qgis).destination
    const pool = new Pool(pte_projet(projet_qgis).bd_access)
    var sql ="select id,nom from thematique"

    pool.query(sql, (err, response) => {
        var query = response.rows
        var path_projet_qgis_projet = []
        for (let index = 0; index < query.length; index++) {
            var id_thematique = query[index]['id']
            path_projet_qgis_projet.push( destination + '/../' + projet_qgis + id_thematique.toString() + '.qgs')
        }
        cb({
            'error': false,
            path_projet_qgis_projet: path_projet_qgis_projet
        })
    })
}

module.exports = {
    get_projet_qgis: get_projet_qgis,
    get_all_projet_qgis: get_all_projet_qgis,
};