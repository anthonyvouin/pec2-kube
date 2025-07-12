## Url du projet
https://onlyflick.akiagaming.fr

# Composition

Le depot se compose de 2 parties
le dossier prod et les fichiers sans dossiers.

Si un fichier se trouve dans prod c'est qu'il diffère du local.

## Remplir le fichier back-pec-2-config-secret.yaml
   Pour ce fichier il faut les encoder en base64
   exemple: la valeur d'une clé est "chat", dans le fichier secret elle sera alors inscrite comme Y2hhdA==
   
   ## Commande pour encoder
   ```bash
    [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("chat"))
```




## Créer un cluster
1. Aller sur https://console.cloud.google.com/ déplier le burger menu à gauche et cliquer sur Kubernetes Engine
2. Faire créer
3. Donner un nom, sélectionner la zone europe-west-9 (ca correspond à paris)
4. Dans la zone réseau : cocher Access using DNS
5. Dans paramètres Avancés-> sécurité -> cocher Activer Secret Manager si vous compter l'utiliser
6. Créer

## Mettre en ligne avec du HTTPS
### Se connecter à google cloud console
1. Tout d'abord il faut le CLI https://cloud.google.com/sdk/docs/install?hl=fr
   ensuite faire la commande :
```bash 
  gcloud auth login
```

2. Choisir le projet
```bash
gcloud config set project [ID_DU_PROJET]
```

3. Se connecter au cluster GKE
```bash
gcloud container clusters get-credentials pec2  --region europe-west9 --project basic-tube-461312-r9
```
On peut repasser en local en affichant la liste de tous les contexts puis en prennant celui de docker
```bash
kubectl config get-contexts
kubectl config use-context docker-desktop
```

### Appliquer les configurations
Commencer par appliquer les commandes qui sont dans .prod/sh
- le config secret
- La configMap
- Le deployment
- Le service

faire la commande 
```bash
kubectl get pod
```

Une fois que les pods sont à 1/1 continuer à appliquer les confs du managed-cert et ingress

Attendre d'avoir une url dans adresse avec la commande suivante
```bash
kubectl get ingress
```

Reporter l'adresse dans le DNS que vous avez sous OVH ou n'importe 
pour que votre nom de domaine pointe sur l'ip de votre LoadBalancer chez console.cloud
Cela peut prendre jusqu'a 10-15 min

Si l'adresse ne vient pas regarder les logs avec la commande suivante dans la partie EVENT
```bash
kubectl describe ingress <nom de l'ingresse>
```


pour regarder ou en est le certificat faire les commandes suivante. 
Il doit être en actif pour avoir du HTTPS
```bash
kubectl get managedcertificate
kubectl describe managedcertificate <nom du managedcertificate>
```

Bravo vous avez mit votre site en ligne avec de l'HTTPS

## Mettre à jour une image
Il faut d'abord que le deployment soit à 0 car sinon pas assez de ressources (un deuxieme pod va être créer)
```bash
kubectl scale deployment front-pec-2-deployment --replicas=0
```

Changer dans le deployment la valeur de l'image
appliquer la nouvelle configurations.



## Les commandes importantes
```bash
kubectl apply -f <chemin du fichier de configuration>
kubectl scale deployment <nom du deploiement> --replicas=0
kubectl get deployment
kubectl get service
kubectl get pod
kubectl get ingress
kubectl get managedcertificate
kubectl delete deployment/service/pod/managedcertificate <nom de ce que vous voulez delete>
kubectl describe <deployment/service/pod/managedcertificate/ingress> <nom de ce que vous voulez voir>
```
