#!/usr/bin/env bash

kubectl apply -f manifests
kubectl get ns,svc,deploy,po,cm,secrets -o wide -n=mmontes-dev
