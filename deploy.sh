#!/bin/bash

set -e

echo "🚀    Deploying duckdns ..."
kubectl apply -f duckdns

echo "🚀    Deploying Traefik ..."
helm repo add traefik https://helm.traefik.io/traefik
helm upgrade traefik traefik/traefik -f traefik/values.yml -n kube-system --install
kubectl apply -f traefik/manifests

kubectl delete ingress traefik-dashboard
echo "🚀    Deploying kubernetes-dashboard ..."
kubectl apply -f kubernetes-dashboard

echo "🚀    Deploying monitoring manifests ..."
kubectl apply -f monitoring/manifests --recursive

echo "🚀    Deploying monitoring stable charts ..."
helm repo add stable https://charts.helm.sh/stable --force-update
for i in monitoring/stable-charts/*; do
    if [ -d "$i" ]; then
        continue
    fi
    values="$i"
    name="$(basename -- $i)"
    name="${name%.*.*}"
    echo "$name $values"
    helm upgrade "$name" "stable/$name" -f "$values" -n monitoring --install
done

echo "🚀    Deploying Grafana ..."
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
helm upgrade grafana grafana/grafana -f monitoring/grafana.values.yml -n monitoring --install
