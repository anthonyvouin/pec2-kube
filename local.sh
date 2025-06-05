#!/bin/bash
kubectl apply -f kube/back-pec-2-config-secret.yaml
kubectl apply -f kube/back-pec-2-configmap.yaml
kubectl apply -f kube/back-pec-2-service.yaml
kubectl apply -f kube/back-pec-2-deployment.yaml
kubectl apply -f kube/front-pec-2.configmap.yaml
kubectl apply -f kube/front-pec-2-service.yaml
kubectl apply -f kube/front-pec-2-deployment.yaml