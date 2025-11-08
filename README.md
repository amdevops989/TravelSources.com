

# **TravelSources.com**

**Mission:**
E-commerce platform where travelers find everything they need for traveling with ease.

---

## 🧱 **Infrastructure Stack**

* **Core:** EKS (Kubernetes)
* **Messaging:** Kafka
* **Database:** PostgreSQL
* **CDC:** Debezium

**Microservices:**

* Auth
* Catalog
* Cart
* Orders
* Payments
* Notifications
* Frontend (React/Vite)

---

## ⚙️ **CI/CD Pipeline**

**CI (GitHub Actions):**

* Build → Test → Scan → Tag → Push
* Auto-update GitOps repo (multi-branch: `dev`, `stg`, `prod`)

**CD (ArgoCD + Argo Rollouts):**

* Each microservice has its own **ApplicationSet**
* Bound to each environment (`dev`, `stg`, `prod`)

---

## 🏗️ **Infrastructure as Code**

* **Tools:** Terragrunt + Terraform
* **Structure:** Multi-environment (`dev`, `stg`, `prod`)

---

## 🌐 **Ingress & TLS**

* **Service Mesh:** Istio
* **Certificates:** Cert-Manager + Let’s Encrypt
* **Domains:**

  * `travelsources.com` → Frontend
  * `api.travelsources.com` → Backend
* **DNS:** Route53 + ExternalDNS
* **Security:** mTLS between services

---

## 📊 **Monitoring & Logging**

* **Monitoring:** Prometheus Stack (Prometheus + Grafana + Alertmanager)
* **Logging:** Loki

---

## ⚖️ **Autoscaling**

* **Pod Scaling:** HPA (Horizontal Pod Autoscaler)
* **Node Scaling:** Karpenter
* **Permissions:** IRSA (IAM Roles for Service Accounts)

---

## 🔐 **Secrets Management**

* **Tool:** External Secrets Operator
* **Integration:** IRSA for AWS Secrets Manager access

---

## 💾 **Storage & Backup**

* **Storage:** EBS CSI Driver + PVCs for StatefulSets (Kafka, PostgreSQL)
* **Backup:** EBS Snapshots + Cross-region Copy for DR

---

## 🌍 **Networking**

* **VPC Design:**

  * Public + Private Subnets
  * NAT Gateways
  * VPC Endpoints
* **Traffic Flow:** Secure and isolated for workloads

---

## 🔁 **Disaster Recovery**

* **Strategy:** Pilot Light Configuration
* **DR Region:** Secondary AWS region
* **Replication:** EBS Snapshots copied to DR region

---

## ⚡ **Event Response**

* **AWS EventBridge + Lambda** for reactive automation and event-driven actions

---

## 👥 **Users & Groups**

* **AWS Organization** with multiple accounts
* **Access:** AWS SSO
* **Governance:** RBAC + SCPs

---

