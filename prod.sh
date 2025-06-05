#!/bin/bash
kubectl apply -f kube/back-pec-2-config-secret.yaml
kubectl apply -f kube/back-pec-2-configmap.yaml
kubectl apply -f kube/back-pec-2-deployment.yaml
kubectl apply -f kube/prod/back/service.yaml

kubectl apply -f kube/prod/back/managed-cert.yaml
kubectl apply -f kube/prod/back/ingress.yaml


kubectl apply -f kube/prod/front/configmap.yaml
kubectl apply -f kube/prod/front/deployment.yaml
kubectl apply -f kube/prod/front/service.yaml

kubectl apply -f kube/prod/front/managed-cert.yaml
kubectl apply -f kube/prod/front/ingress.yaml