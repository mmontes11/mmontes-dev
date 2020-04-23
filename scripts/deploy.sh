#!/bin/sh

set -e

kubectl apply -f manifests --recursive
kubectl get ns,svc,deploy,po,cm,secrets,pvc -o wide -n=mmontes-dev
