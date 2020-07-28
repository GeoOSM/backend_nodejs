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