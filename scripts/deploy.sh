#!/bin/bash

set -e

kubectl apply -f manifests --recursive

namespaces=("kubernetes-dashboard" "mmontes-dev")
for ns in "${namespaces[@]}"; do
    echo "☸️   $ns resources:"
    kubectl get all -o wide -n="$ns"
done
