var createDefaultStyle = function (projet_qgis) {
    var destination = pte_projet(projet_qgis).destination

	const pool = new Pool(pte_projet(projet_qgis).bd_access)

	var pte = []
	var i = 0

	function export_qml(props) {
		// console.log(props)
		let options = {
			mode: 'text',
			pythonPath: 'python3',
			pythonOptions: ['-u'], // get print results in real-time
			args: [props['projet_qgis'], props["layername"], props["id_couche"]]
		};

		PythonShell.run(path_script_python + '/production_style_by_default.py', options, function (err, results) {

			if (err) {
				console.error(err)
			}

			i = i + 1
			console.log(i, ' / ', pte.length, props["layername"])

			if (pte.length != i) {
				export_qml(pte[i])
			} else {
				console.log('termine')
			}
		})
	}

	pool.query("SELECT identifiant,id_couche from public." + '"couche-sous-thematique"' + "where wms_type='osm' UNION SELECT identifiant,id_couche from public." + '"couche-thematique"' + "where wms_type='osm'", function (err, response) {
		pool.end()

		var rows = response.rows

		for (var index = 0; index < rows.length; index++) {
			var element = rows[index];
			var layername = element['identifiant']
			var id_couche = element['id_couche']
			pte.push({
				'projet_qgis': projet_qgis,
				'id_couche': id_couche,
				'layername': layername,
			})

			// console.log('start',pte.length)
		}
		console.log('start', pte.length)
		export_qml(pte[i])
		res.send('Processus de generation des fichiers de styles lancée')

	})    
}
app.post('/analyse_spatiale', cors(corsOptions), function (req, res) {
	var donne = req.body
	if (donne['geometry'] != 'tout') {
		var polygon = turf.polygon(donne['geometry']);
	} else {
		var polygon = 'tout'
	}

	if (donne['geometry'] != 'tout') {

		var format_data = function (k) {
			console.log('k_0', k)
			var url = donne['querry'][k]['url']
			var methode = donne['querry'][k]['methode']
			var typeGestion = donne['querry'][k]['type']

			if (methode == 'get') {

				xhr(url, function (error, response, body) {
					if (!error && response.statusCode == 200) {
						//console.log(body) 
						var data = JSON.parse(body)
						var all_coordinates = []
						for (var index = 0; index < data.length; index++) {
							if (typeGestion == 'api' || typeGestion == 'couche') {
								var property = {}
								for (var i = 0; i < data[index].length; i++) {
									if (data[index][i]['index'] == 'geometry') {
										var geometry = JSON.parse(data[index][i]['val']);
									} else {
										property[data[index][i]['index']] = data[index][i]['val']
									}
								}
							} else if (typeGestion == 'requete') {
								var geometry = JSON.parse(data[index].geometry);

								var property = {}
								var property_old = data[index]
								delete property_old.geometry;

								property['name'] = property_old['name']
								property['osm_id'] = property_old['osm_id']

								var hstore_to_json = JSON.parse(property_old['hstore_to_json'])

								for (var champ in hstore_to_json) {

									property[champ] = hstore_to_json[champ]
								}
							}

							if (geometry.coordinates.length == 1) {
								var coord = geometry.coordinates[0]
							} else {
								var coord = geometry.coordinates
							}

							all_coordinates.push({
								'coord': coord,
								'property': property
							})
						}

						var features = []

						for (var jj = 0; jj < all_coordinates.length; jj++) {

							features.push(turf.point(all_coordinates[jj]['coord'], all_coordinates[jj]['property']))
						}

						var turf_points = turf.featureCollection(features);
						contains(turf_points, k)
					}
				})

			} else if (methode == 'post') {
				var options = { url: url, method: "POST", form: donne['querry'][k]['data'], strictSSL: false }
				//console.log(options,typeGestion)
				xhr(options, function (error, response, body) {
					//console.log(body) 
					if (!error && response.statusCode == 200) {

						var data = JSON.parse(body)
						var all_coordinates = []
						//console.log('data_lenght_1',data.length,data[0])
						for (var index = 0; index < data.length; index++) {
							if (typeGestion == 'api' || typeGestion == 'couche') {
								var property = {}
								for (var i = 0; i < data[index].length; i++) {
									if (data[index][i]['index'] == 'geometry') {
										var geometry = JSON.parse(data[index][i]['val']);;
									} else {
										property[data[index][i]['index']] = data[index][i]['val']
									}
								}
							} else if (typeGestion == 'requete') {
								var geometry = JSON.parse(data[index].geometry)
								var property = {}
								var property_old = data[index]
								delete property_old.geometry;

								property['name'] = property_old['name']
								property['osm_id'] = property_old['osm_id']

								var hstore_to_json = JSON.parse(property_old['hstore_to_json'])

								for (var champ in hstore_to_json) {

									property[champ] = hstore_to_json[champ]
								}


							}

							if (geometry.coordinates.length == 1) {
								var coord = geometry.coordinates[0]
							} else {
								var coord = geometry.coordinates
							}

							all_coordinates.push({
								'coord': coord,
								'property': property
							})
						}
						//console.log('data_lenght_2',data.length)
						//var turf_points = turf.points(all_coordinates)
						//console.log(turf.point( all_coordinates[0]['coord'], all_coordinates[0]['property']))

						var features = []

						for (var jj = 0; jj < all_coordinates.length; jj++) {

							features.push(turf.point(all_coordinates[jj]['coord'], all_coordinates[jj]['property']))
						}

						var turf_points = turf.featureCollection(features);

						contains(turf_points, k)
					}
				})
			} else if (methode == 'qgis') {
				var destination = pte_projet(donne['querry'][k]['projet_qgis']).destination
				var projet_qgis = destination + '/../' + donne['querry'][k]['projet_qgis'] + '.qgs'
				var layername = donne['querry'][k]['identifiant']
				let options = {
					mode: 'text',
					pythonPath: 'python3',
					//pythonOptions: ['-u'], // get print results in real-time
					//scriptPath: 'path/to/my/scripts',
					args: [projet_qgis, layername, path_projet_qgis + '/roi.geojson', config.path_for_download_result]
				};
				// console.log(options)
				PythonShell.run(path_script_python + '/download_data.py', options, function (err, results) {
					if (err) throw err;
					console.log(results)
					compeur.push(1)
					if (results != null) {
						donne['querry'][compeur.length - 1]['number'] = results[0]
						donne['querry'][compeur.length - 1]['nom_file'] = config.path_for_download_result + layername + '.gpkg'
					} else {
						donne['querry'][compeur.length - 1]['number'] = 0
						donne['querry'][compeur.length - 1]['nom_file'] = false
					}

					if (compeur.length == donne['querry'].length) {
						res.send(donne['querry'])
					} else {
						format_data(compeur.length)
					}
				});
			}
		}

		if (donne['querry'].length > 0) {
			var methode_qgis = []
			for (var index = 0; index < donne['querry'].length; index++) {
				if (donne['querry'][index]['methode'] == 'qgis') {
					methode_qgis.push(1)
				};
			}
			if (methode_qgis.length > 0) {
				fs.writeFile(path_projet_qgis + '/roi.geojson', JSON.stringify(polygon), function (err) {
					if (err) throw err;
					format_data(0)
				}
				);
			} else {
				format_data(0)
			}

		} else {
			res.send('Aucune donnée à traiter ')
		}
		// fontion de traitement
		var compeur = []
		var contains = function (turf_points) {

			var ptsWithin = turf.pointsWithinPolygon(turf_points, polygon);
			compeur.push(ptsWithin.features.length)
			donne['querry'][compeur.length - 1]['number'] = ptsWithin.features.length
			var nom_file = donne['querry'][compeur.length - 1]['nom'].replace(/[^\w\s]/gi, '').toLowerCase() + '_' + Date.now() + '.zip'
			donne['querry'][compeur.length - 1]['nom_file'] = config.url_node_js + config.path_for_download_result + nom_file
			//console.log('contains',compeur.length,donne['querry'].length)

			var type = 'ESRI Shapefile'
			var shapefile = ogr2ogr(ptsWithin)
				.format(type)
				.skipfailures()
				.stream()

			shapefile.pipe(fs.createWriteStream(config.path_for_download_result + nom_file).on('finish', function () {
				if (compeur.length == donne['querry'].length) {
					res.send(donne['querry'])
				} else {
					format_data(compeur.length)
				}
			}))
		}

	} else {
		var compeur = []

		var format_data = function (k) {
			console.log('k_0', k)
			var url = donne['querry'][k]['url']
			var methode = donne['querry'][k]['methode']
			var typeGestion = donne['querry'][k]['type']

			if (methode == 'qgis') {

				// var projet_qgis = destination +donne['querry'][k]['projet_qgis'] + ".qgs"
				var destination = pte_projet(donne['querry'][k]['projet_qgis']).destination
				var projet_qgis = destination + '/../' + donne['querry'][k]['projet_qgis'] + '.qgs'

				var layername = donne['querry'][k]['identifiant']
				let options = {
					mode: 'text',
					pythonPath: 'python3',
					//pythonOptions: ['-u'], // get print results in real-time
					//scriptPath: 'path/to/my/scripts',
					args: [projet_qgis, layername]
				};
				// console.log(options)
				PythonShell.run(path_script_python + '/telchargement_tout.py', options, function (err, results) {
					if (err) throw err;
					console.log(results)
					compeur.push(1)
					if (results != null) {
						donne['querry'][compeur.length - 1]['number'] = results[1]
						donne['querry'][compeur.length - 1]['nom_file'] = results[0]
					} else {
						donne['querry'][compeur.length - 1]['number'] = 0
						donne['querry'][compeur.length - 1]['nom_file'] = false
					}

					if (compeur.length == donne['querry'].length) {
						res.send(donne['querry'])
					} else {
						format_data(compeur.length)
					}
				});
			}
		}

		if (donne['querry'].length > 0) {
			format_data(0)
		}
		else {
			res.send('Aucune donnée à traiter ')
		}


	}
})

app.get('/remove_layer_by_name/:projet_qgis/:idndifiant', cors(corsOptions), function (req, res) {
	var projet_qgis = path_projet_qgis + req.params["projet_qgis"] + ".qgs"
	var layername = req.params["idndifiant"]
	console.log(layername)
	let options = {
		mode: 'text',
		pythonPath: 'python3',
		//pythonOptions: ['-u'], // get print results in real-time
		//scriptPath: 'path/to/my/scripts',
		args: [projet_qgis, layername]
	};

	PythonShell.run(path_script_python + '/remove_layer_by_name.py', options, function (err, results) {

		if (err) throw err;

		if (results == 'ok') {

			res.send({
				'status': 'ok'
			})

		} else {

			res.send(results)
		}

	});

})

//https://cuy.sogefi.cm:8443/addRasterToWMS/madagascar/carte_ocsol_2018_Itasy.tif
app.get('/addRasterToWMS/:projet_qgis/:nom/', cors(corsOptions), function (req, res, next) {
	var projet_qgis = path_projet_qgis + req.params["projet_qgis"] + ".qgs"
	var destination = pte_projet(req.params["projet_qgis"]).destination

	var nom = req.params["nom"]
	var file = '/var/www/smartworld/raster/' + nom
	console.log(nom)
	let options = {
		mode: 'text',
		pythonPath: 'python3',
		pythonOptions: ['-u'], // get print results in real-time
		args: [projet_qgis, file, nom.replace(/[^a-zA-Z0-9]/g, '_')]
	};

	PythonShell.run(path_script_python + '/add_raster_layer.py', options, function (err, results) {

		//	python "/var/www/smartworld/add_raster_layer.py" "/var/www/smartworld/smartworld4.qgs" "/var/www/smartworld/raster/drone_limbe.mbtiles" "drone_limbe_2018"

		if (err) throw err;
		//console.log( results,3)
		if (Array.isArray(results) && results[0] == 'ok') {
			var url = config.url_qgis_server + projet_qgis

			res.send({
				'status': 'ok',
				'identifiant': nom.replace(/[^a-zA-Z0-9]/g, '_'),
				'projet_qgis': url,
				'url_raster': file
			})

		} else {

			res.send(results)
		}
	})



})

app.get('/downloadVectorToWMS/:projet_qgis/:file/', cors(corsOptions), function (req, res) {

	var destination = pte_projet(req.params["projet_qgis"]).destination
	var projet_qgis = path_projet_qgis + req.params["projet_qgis"] + ".qgs"
	var nom_shp = req.params["file"]


	let options = {
		mode: 'text',
		pythonPath: 'python3',
		//pythonOptions: ['-u'], // get print results in real-time
		//scriptPath: 'path/to/my/scripts',
		args: [projet_qgis, destination + nom_shp, nom_shp.replace(/[^a-zA-Z0-9]/g, '_')]
	};

	PythonShell.run(path_script_python + '/add_vector_layer.py', options, function (err, results) {
		// python3 /var/www/smartworld/add_vector_layer.py /var/www/smartworld/occitanie.qgs /var/www/smartworld/occitanie_gpkg/Association_false_54_198.gpkg hhhh
		if (err) throw err;

		console.log(results)
		if (Array.isArray(results) && results[0] == 'ok') {

			var url = config.url_qgis_server + projet_qgis
			console.log('oui ou non')

			res.send({
				'status': 'ok',
				'identifiant': nom_shp.replace(/[^a-zA-Z0-9]/g, '_'),
				'projet_qgis': url
			})

		} else {

			res.send(results)
		}

	});


})

app.get('/get_source_file/:projet_qgis/:idndifiant', cors(corsOptions), function (req, res) {
	var destination = pte_projet(req.params["projet_qgis"]).destination
	var projet_qgis = destination + '/../' + req.params["projet_qgis"] + '.qgs'

	var layername = req.params["idndifiant"]
	console.log(layername)
	let options = {
		mode: 'text',
		pythonPath: 'python3',
		//pythonOptions: ['-u'], // get print results in real-time
		//scriptPath: 'path/to/my/scripts',
		args: [projet_qgis, layername]
	};

	PythonShell.run(path_script_python + '/get_source_file.py', options, function (err, results) {

		if (err) throw err;
		console.log(results[0])
		var file = config.url_node_js + results[0].replace('/vsizip/', '')

		res.send({
			'status': 'ok',
			'url': file
		})


	});

})

app.post('/download', cors(corsOptions), upload.single('file'), function (req, res, next) {
	var file = req.file
	var extension = file.filename.split('.')[file.filename.split('.').length - 1]
	var nom = file.filename

	res.send({ 'status': 'ok', 'file': 'assets/pdf/' + nom })
	// req.file is the `avatar` file
	// req.body will hold the text fields, if there were any
})

app.post('/downloadRaster', cors(corsOptions), upload_raster.single('file'), function (req, res, next) {
	/// a cause du fait qu'on ne peut rien envoyer avec le post, c'est le projet smartword qui va porter tous les rasters
	var file = req.file
	var extension = file.filename.split('.')[file.filename.split('.').length - 1]
	var name = file.filename
	var nom = name
	var file = '/var/www/smartworld/raster/' + nom
	console.log(1, name)
	let options = {
		mode: 'text',
		pythonPath: 'python3',
		pythonOptions: ['-u'], // get print results in real-time
		args: ["/var/www/smartworld/smartworld4.qgs", file, nom.replace(/[^a-zA-Z0-9]/g, '_')]
	};

	PythonShell.run(path_script_python + '/add_raster_layer.py', options, function (err, results) {

		//	python "/var/www/smartworld/add_raster_layer.py" "/var/www/smartworld/smartworld4.qgs" "/var/www/smartworld/raster/drone_limbe.mbtiles" "drone_limbe_2018"

		if (err) throw err;
		//console.log( results,3)
		if (Array.isArray(results) && results[0] == 'ok') {
			var url = 'http://tiles.geocameroun.xyz/cgi-bin/qgis_mapserv.fcgi?map=/var/www/smartworld/smartworld4.qgs'

			res.send({
				'status': 'ok',
				'identifiant': nom.replace(/[^a-zA-Z0-9]/g, '_'),
				'projet_qgis': url,
				'url_raster': file
			})

		} else {

			res.send(results)
		}
	})



})