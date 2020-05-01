#!/bin/bash

set -e

kubectl apply -f manifests/kubernetes-dashboard

kubectl apply -f manifests/monitoring --recursive
helm install mongodb-exporter stable/prometheus-mongodb-exporter -f config/helm/mongodb-exporter.values.yml -n monitoring
helm install prometheus stable/prometheus -f config/helm/prometheus.values.yml -n monitoring
helm install grafana stable/grafana -f config/helm/grafana.values.yml -n monitoring

kubectl apply -f manifests/mmontes-dev --recursive
