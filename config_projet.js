const fs = require('fs');

let list_projet = JSON.parse(fs.readFileSync('projet.json'))['projet'];

const bd_access = {
	user: '',
	host: 'localhost',
	database: '',
	password: '',
	port: '',
}

let get_projet_pt = function(projet){
    if(list_projet[projet]){
		var destination =list_projet[projet].destination
		var destination_style =list_projet[projet].destination_style
		var database =list_projet[projet].database
		var password =list_projet[projet].password
		var port =list_projet[projet].port
		var user =list_projet[projet].user
		var path_backend = list_projet[projet].path_backend
	}
    
    bd_access.database = database
    bd_access.password = password
    bd_access.port = port
    bd_access.user = user
    
    return {
        bd_access:bd_access,
        destination:destination,
        destination_style:destination_style,
        path_backend:path_backend,
    }
}

module.exports = get_projet_pt
