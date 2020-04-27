#! /usr/bin/env node
var http = require('http');
var https = require('https');
const getPort = require('get-port');
var fs = require("fs");
var timeout = require('connect-timeout');
const promiseFinally = require('promise.prototype.finally');
promiseFinally.shim();
// https://stackoverflow.com/questions/30782693/run-function-in-script-from-command-line-node-js
var unrar = require("node-unrar-js");
var express = require('express');
var ogr2ogr = require('ogr2ogr');
var BodyParser = require('body-parser');
var zip = new require('node-zip')();
var cors = require('cors');
var xhr = require('request');
var { PythonShell } = require('python-shell')
// #https://www.npmjs.com/package/python-shell
var app = express();
var MBTiles = require('@mapbox/mbtiles');
var turf = require('@turf/turf')
const { Pool, Client } = require('pg')

const pte_projet = require('./config_projet')
const config = require('./config')
const {get_projet_qgis} = require('./src/projet')
const {
	generateAllShapeFromOsmBuilder,
	addGpkgLayerToProjet,
	resetProjet,
	generateAllShapeFromOsmBuilderCreate,
	generateOneShapeFromOsmBuilder,
} = require('./src/vectorLayer')

const{
	upload,
	upload_raster,
	upload_style
}= require('./src/storage')


const{
	update_style_couche_qgis,
	set_style_qml,
	setStyleAllShapeFromOsmBuilderCreate
}=require('./src/style')

const path_nodejs = config.path_nodejs
const path_script_python = config.path_script_python
const path_projet_qgis = config.path_projet_qgis




app.use(cors());
// app.use(BodyParser.json());

// app.use(BodyParser.urlencoded({ extended: true }));

app.use(express.json({ limit: '50mb' }))
//app.use(express.urlencoded({limit:'50mb'}))

var corsOptions = {
	origin: '*',
	optionsSuccessStatus: 200
}

app.use(express.static('/'));

//toujours comme dernier des middleware
app.use(timeout(900000));
app.use(haltOnTimedout);

function haltOnTimedout(req, res, next) {
	if (!req.timedout) next();
}


app.get('/generateAllShapeFromOsmBuilder/:projet_qgis', cors(corsOptions), function (req, res) {
	generateAllShapeFromOsmBuilder(req.params["projet_qgis"])
	res.send("ok")
})


app.use('/generateShapeFromOsmBuilder/:projet_qgis/:id_cat/:addtowms', function (req, res, next) {
	req.clearTimeout(); // clear request timeout
	req.setTimeout(900000); //set a 20s timeout for this request
	next();
})
app.get('/generateShapeFromOsmBuilder/:projet_qgis/:id_cat/:addtowms', cors(corsOptions), function (req, res) {
	var projet_qgis = req.params["projet_qgis"]
	var id_cat = req.params["id_cat"]
	var addtowms = req.params["addtowms"]
	generateOneShapeFromOsmBuilder(projet_qgis,id_cat,addtowms,function(result){
		res.send(result)
	})
})



app.get('/update_style_couche_qgis/:projet_qgis/:identifiant', cors(corsOptions), function (req, res) {
	update_style_couche_qgis(req.params["projet_qgis"], req.params["identifiant"])
		.finally(() => {

		})
		.then((data) => {
			res.send({ 'status': 'ok' })
			console.log(data, 'update_style_couche_qgis termine, a t il marché ?')
		})
		.catch((err) => {
			console.log(err)
			res.send({ 'status': 'ko' })
		})

})


app.post('/download_style_qgs', cors(corsOptions), upload_style.single('file'), function (req, res) {


	var file = req.file
	var extension = file.filename.split('.')[file.filename.split('.').length - 1]
	var nom = file.filename
	var style_file = nom
	console.log(style_file)
	res.send({ 'status': 'ok', 'style_file': style_file })


})

app.get('/set_style_qgs/:projet_qgis/:style_file/:idndifiant', cors(corsOptions), function (req, res) {

	var projet_qgis = req.params["projet_qgis"]
	var style_file = req.params["style_file"]
	var identifiant = req.params["idndifiant"]

	set_style_qml(projet_qgis,style_file,identifiant,function (response) {
		res.send(response)
	})

})


module.exports.reset_projet = function (projet) {
	console.log('projet :', projet);
	resetProjet(projet)
}

module.exports.initialiser_projet = function (projet) {
	console.log('projet :', projet);
	generateAllShapeFromOsmBuilderCreate(projet)
}

module.exports.apply_style_projet = function (projet) {
	console.log('projet :', projet);
	setStyleAllShapeFromOsmBuilderCreate(projet)
}

var httpServer = http.createServer(app);

async function getRandomPort(preferredPort = 3000) {
	const port = await getPort({ port: preferredPort });
	return port;
}
getRandomPort(3000).then(port => {
	console.log(port)
	httpServer.listen(port);
});