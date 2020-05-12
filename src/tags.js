const { Pool, Client } = require('pg')
const fs = require('fs');
var { PythonShell } = require('python-shell')
const config = require('../config')
const promiseFinally = require('promise.prototype.finally');
promiseFinally.shim();

const pte_projet = require('../config_projet')
const { get_projet_qgis, get_all_projet_qgis } = require('./projet')

var all_tags = []

function generateTags(projet_qgis) {

    var bd_access = pte_projet(projet_qgis).bd_access
    var destination = pte_projet(projet_qgis).destination
    var path_projet_qgis_projet = null
    const pool = new Pool(bd_access)

    all_tags = []

    pool.query('SELECT * from public.categorie where sql is not null', (err, response) => {
        pool.end()

        var query = response.rows
        var i = 0

        console.log(query.length)

        function execute(i) {
            var sql = query[i].sql
            getTags(bd_access, sql, function (data) {

                for (let index = 0; index < data.length; index++) {
                    const element = data[index];
                    addTagToJson(element.json_object_keys, all_tags)
                }
                console.log(i, ' sur ', query.length)
                i++
                if (i < query.length) {
                    execute(i)
                } else {
                    fs.writeFileSync('all_tags.json', JSON.stringify(all_tags));
                    process.exit(0)
                }
            })
        }

        if (query.length > 0) {
            execute(i)
        }

    })
}

function getTags(bd_access, sql, cb) {
    var sql_tags = "select distinct(json_object_keys(subquerry.hstore_to_json)) from (" + sql + ") as subquerry;"
    const pool = new Pool(bd_access)
    pool.query(sql_tags, (err, response) => {
        pool.end()
        if (err) {
            console.log("Erreur dans la requète : ", sql_tags)
            cb([])
        } else {
            var query = response.rows
            cb(query)
        }



    })

}

function addTagToJson(tag, all_tags) {
    var bool = false
    for (let index = 0; index < all_tags.length; index++) {
        const element = all_tags[index];
        if (element.tag == tag) {
            bool = true
            element.occurence = element.occurence + 1
        }
    }

    if (!bool) {
        all_tags.push({
            tag: tag,
            occurence: 1
        })
    }
}

function getMostOccurenceTags() {
    let rawdata = fs.readFileSync('all_tags.json');
    let all_tags_data = JSON.parse(rawdata);
    var mostOccurenceTags_30 = []
    var mostOccurenceTags_60 = []
    var mostOccurenceTags_120 = []
    var mostOccurenceTags_150 = []
    var mostOccurenceTags_180 = []

    var fr = {}

    for (let index = 0; index < all_tags_data.length; index++) {
        const element = all_tags_data[index];
        var tag = element.tag
        var donne = {
            tag: tag
        }

        if (element.occurence >= 180) {
            mostOccurenceTags_180.push(donne)
        }

        if (element.occurence >= 150) {
            mostOccurenceTags_150.push(donne)
        }

        if (element.occurence >= 120) {
            mostOccurenceTags_120.push(donne)
        }

        if (element.occurence >= 60) {
            mostOccurenceTags_60.push(donne)
        }

        if (element.occurence >= 30) {
            mostOccurenceTags_30.push(donne)
            fr[tag]=tag
        }

    }

    fs.writeFileSync('fr.json', JSON.stringify(fr));

    console.log(mostOccurenceTags_180.length, mostOccurenceTags_150.length, mostOccurenceTags_120.length, mostOccurenceTags_60.length,mostOccurenceTags_30.length)

    process.exit(0)
}

module.exports = {
    generateTags: generateTags,
    getMostOccurenceTags: getMostOccurenceTags
};