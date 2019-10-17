import base64
import xml.etree.ElementTree
from xml.etree import ElementTree as et
from xml.dom.minidom import Document
import sys
import os
from PyQt5.QtGui import *
from qgis.core import *
from qgis.PyQt.QtCore import QFileInfo

# pathqgisproject =  sys.argv[1] #"/var/www/smartworld/smartworld4.qgs"
# icon_png = sys.argv[2] #'/var/www/smartworld/style/styles_communes.qml'
# layername = sys.argv[3] #'communes'

# pathqgisproject =  "/var/www/smartworld/occitanie_icon.qgs"
# layername = 'Banque'
# id_couche = "finance_Banque"

pathqgisproject = sys.argv[1]
layername = sys.argv[2]
id_couche =sys.argv[3]
path_style =sys.argv[4]

def generate_qml(path_qml_file):
    os.environ["QT_QPA_PLATFORM"] = "offscreen"
    QgsApplication.setPrefixPath("/usr", True)
    qgs = QgsApplication([], False)
    qgs.initQgis()
    project = QgsProject()
    project.read(pathqgisproject)
    layer = project.mapLayersByName(layername)
    if len(layer) > 0:
        vlayer = layer[0]
        vlayer.saveNamedStyle(path_qml_file)

path_qml_file = path_style+'/'+id_couche+'.qml'
generate_qml(path_qml_file)
print('finish')