génération api typescript à partir du backend

- config pour donner un path pour le dossier d'écriture
- annotation typescript pour dire si générer @generated-by-boot64
- type basé sur le schema
- enum si dispo dans le modèle
- cli en rails, affiche les models à générer, coche ou sélectionne tout
- n'abime pas le code déjà écrit dans les fichiers, une fois la méthode écrite, faudrais forcer dans le cli pour dire qu'on réécrit la méthode
- générations des appels api rest mais sans type de retour (Promise<unkown> ?) (check du router, scope, resources, etc..)

[Documentation](https://chureimsdsn.github.io/Boot64-Rails/)
