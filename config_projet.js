const fs = require('fs');

let list_projet = JSON.parse(fs.readFileSync('projet.json'))['projet'];

const bd_access = {
	user: 'postgres',
	host: 'localhost',
	database: '',
	password: 'postgres',
	port: 5432,
}

let get_projet_pt = function(projet){
    if(list_projet[projet]){
		var destination =list_projet[projet].destination
		var destination_style =list_projet[projet].destination_style
		var database =list_projet[projet].database
	}
    
    bd_access.database = database
    
    return {
        bd_access:bd_access,
        destination:destination,
        destination_style:destination_style,
    }
}

module.exports = get_projet_pt
