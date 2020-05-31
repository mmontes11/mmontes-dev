#!/bin/bash

set -e

echo "🚀    Deploying duckdns ..."
kubectl apply -f duckdns

echo "🚀    Deploying kubernetes-dashboard ..."
kubectl apply -f kubernetes-dashboard

echo "🚀    Deploying monitoring ..."
kubectl apply -f monitoring/manifests --recursive
for i in monitoring/*; do
    if [ -d "$i" ]; then
        continue
    fi
    values="$i"
    name="$(basename -- $i)"
    name="${name%.*.*}"
    echo "$name $values"
    helm upgrade "$name" "stable/$name" -f "$values" -n monitoring --install
done

echo "🚀    Deploying traefik ..."
kubectl apply -f traefik/manifests
helm upgrade traefik stable/traefik -f traefik/values.yml -n kube-system --install
kubectl delete ingress traefik-dashboard
