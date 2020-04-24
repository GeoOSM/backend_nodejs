import os
import glob
from os.path import join, basename, exists, dirname
import os, shutil, typing, csv
from pathlib import Path
from datetime import date,datetime


backup_dir = "/var/www/geosm/france/backup/"
projet = "france"
file_projet = "/var/www/geosm/france/"

now = datetime.now()
today = date.today().strftime("%d%m%Y")
time = now.strftime("%H%M%S")

backup_dir_of_today = backup_dir+today
Path(backup_dir_of_today).mkdir(parents=True, exist_ok=True)

item_path = file_projet+projet+'.qgs'
to_dir = backup_dir_of_today+'/'+projet+'_'+time+'.qgs'
shutil.copy(item_path, to_dir)
