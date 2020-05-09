
const config = require('../config')
var multer = require('multer')

const path_style_qml = config.path_style_qml+'/'

// https://github.com/expressjs/multer#memorystorage npm install --save multer
var storage = multer.diskStorage({
	destination: function (req, file, cb) {
		cb(null, '/var/www/geocameroun_admin/public/assets/pdf/')
	},
	filename: function (req, file, cb) {
		var extension = file.originalname.split('.')[file.originalname.split('.').length - 1]
		var name = file.originalname.replace(/[^\w\s]/gi, '').toLowerCase() + '_' + Date.now() + '.' + extension
		var nom = name.replace(/ /g, '_')

		cb(null, name)
	}
})

var storage_mbtiles = multer.diskStorage({
	destination: function (req, file, cb) {
		cb(null, '/var/www/smartworld/raster/')
	},
	filename: function (req, file, cb) {
		var extension = file.originalname.split('.')[file.originalname.split('.').length - 1]
		var name = file.originalname.replace(/[^\w\s]/gi, '').toLowerCase() + '_' + Date.now() + '.' + extension
		var nom = name.replace(/ /g, '_')

		cb(null, name)
	}
})

var storage_style = multer.diskStorage({
	destination: function (req, file, cb) {
		cb(null, path_style_qml)
	},
	filename: function (req, file, cb) {
		var extension = file.originalname.split('.')[file.originalname.split('.').length - 1]
		var name = file.originalname.replace(/[^\w\s]/gi, '').toLowerCase() + '_' + Date.now() + '.' + extension
		var nom = name.replace(/ /g, '_')

		cb(null, name)
	}
})
var upload = multer({ storage: storage })
var upload_raster = multer({ storage: storage_mbtiles })
var upload_style = multer({ storage: storage_style })

module.exports = {
    upload: upload,
    upload_raster: upload_raster,
    upload_style: upload_style,
};