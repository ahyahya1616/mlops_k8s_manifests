#!/usr/bin/env bash
# ==============================================================================
# Install Kyverno Admission Controller via Helm
# ==============================================================================
set -euo pipefail

echo "==> Adding Kyverno Helm repository..."
helm repo add kyverno https://kyverno.github.io/kyverno/
helm repo update

echo "==> Installing Kyverno into 'kyverno' namespace..."
helm upgrade --install kyverno kyverno/kyverno \
  --namespace kyverno \
  --create-namespace \
  --set replicaCount=1 \
  --wait

echo "==> Verifying Kyverno pods..."
kubectl get pods -n kyverno
echo "==> Kyverno installation successful!"

