insert into public."couche-sous-thematique"("id-sous-thematique",nom, image_src,   geom, id_couche, remplir_couleur, contour_couleur, opacity, type_couche, url, identifiant, bbox, projection, zmax, zmin, wms_type, "number", vues, service_wms, logo_src)
select 95 ,nom, image_src,   geom, id_couche, remplir_couleur, contour_couleur, opacity, type_couche, url, identifiant, bbox, projection, zmax, zmin, wms_type, "number", vues, service_wms, logo_src from "couche-thematique" where id=74

update categorie set key_couche=655, sous_thematiques=true where key_couche=74

SELECT * FROM public.metadata_thematiques

55->647,58->646,57->648,75->649,76->650,73->651,77->652,72->653,56->654,74->655
58,55,
57,
75,
76,
73,
77,
72,
56,
74