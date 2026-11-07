# Zero-Trust MLOps Kubernetes Manifests (GitOps)

Declarative Kubernetes manifests for policy governance, micro-segmentation, and workflow orchestration on Amazon EKS.

---

## Directory Layout

```
mlops_k8s_manifests/
├── 01-security-policies/               # DevSecOps Admission & Network Governance
│   ├── kyverno/                        # Kyverno Admission Webhook & Policies
│   │   ├── install.sh                  # Helm installer
│   │   ├── disallow-latest-tag.yaml    # Policy: Block :latest tag
│   │   └── restrict-ecr-registry.yaml  # Policy: Whitelist only private ECR
│   └── network-policies/               # eBPF Micro-Segmentation
│       ├── default-deny-all.yaml       # Drop all ingress/egress in kubeflow
│       └── allow-pipeline-egress.yaml  # Whitelist DNS, S3, ECR, Yahoo Finance
├── 02-kubeflow-pipelines/              # Standalone Kubeflow Pipelines Platform
├── 03-workloads/                       # Batch Jobs & Pipeline Manifests
└── 04-exploit-tests/                   # Empirical Proof & Penetration Testing Suite
```

---

## Security Policy Principles

1. **Supply-Chain Verification (Kyverno):**
   * Only images from `240797212774.dkr.ecr.us-east-1.amazonaws.com` are admitted. Public Docker Hub is denied at the API boundary.
   * Mutable `:latest` tags are prohibited. All pods must declare an immutable Git SHA tag.

2. **Zero-Trust Micro-Segmentation (eBPF NetworkPolicy):**
   * Baseline default-deny dropped at kernel veth interface.
   * Workloads are permitted outbound traffic only to CoreDNS, Amazon S3, Amazon ECR, and the Yahoo Finance API.
   * AWS Metadata Service (`169.254.169.254`) and internal subnets are blocked.
