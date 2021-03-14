#!/bin/bash

set -e

echo "☸️  Adding helm repos ..."
helm repo add traefik https://helm.traefik.io/traefik
helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

echo "🚀 Deploying duckdns ..."
kubectl apply -f duckdns

echo "🚀 Deploying monitoring ..."
kubectl apply -f monitoring/manifests/

echo "🚀 Deploying kubernetes-dashboard ..."
helm upgrade kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard -n monitoring --install

echo "🚀 Deploying kube-prometheus-stack ..."
helm upgrade kube-prometheus-stack prometheus-community/kube-prometheus-stack \
  -f monitoring/kube-prometheus-stack.values.yml -n monitoring --install

echo "🚀 Deploying traefik ..."
helm upgrade traefik traefik/traefik -f traefik/values.yml --install
kubectl apply -f traefik/manifests
