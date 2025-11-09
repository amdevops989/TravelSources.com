Ah — now it’s clear. You’re using an **AWS SSO user** with Administrator access, you can create the EKS cluster, but **Terraform can’t create Kubernetes resources** like namespaces or service accounts.

This is a **common EKS + AWS SSO situation**, and here’s exactly why it happens and how to fix it:

---

## **Why this happens**

1. **SSO user can create AWS resources**, including EKS clusters, because it has **AWS IAM permissions**. ✅

2. **Kubernetes API in EKS is separate** — it uses **RBAC**, not IAM directly.

3. When you try to create a namespace or service account via Terraform, you’re authenticating to **the Kubernetes API using a token**.

   * If you passed the token from `aws sts get-token` (or `dependency.eks.outputs.cluster_token`), it’s **not automatically mapped in the cluster RBAC**.
   * Even though your SSO user is Administrator in AWS, it **doesn’t automatically become a Kubernetes admin**.

4. By default, only users/roles listed in the **`aws-auth` ConfigMap** in the EKS cluster can act as Kubernetes admins (`system:masters` group).

---

## **How to fix it**

You have **two main options**:

---

### **Option 1 — Map your SSO user to `system:masters`**

1. Get your **SSO role ARN** (e.g., `arn:aws:iam::<ACCOUNT_ID>:role/AWSReservedSSO_AdministratorAccess_<ID>`).
2. Edit the EKS `aws-auth` ConfigMap to add your SSO user/role:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapRoles: |
    - rolearn: arn:aws:iam::<ACCOUNT_ID>:role/AWSReservedSSO_AdministratorAccess_<ID>
      username: admin
      groups:
        - system:masters
```

* Then your SSO user has **full admin RBAC** inside Kubernetes.

---

### **Option 2 — Use `aws-iam-authenticator` / `exec` provider**

Instead of passing a static token from Terragrunt, let the Kubernetes provider **dynamically generate a valid token** using your SSO credentials:

```hcl
provider "kubernetes" {
  host                   = var.k8s_host
  cluster_ca_certificate = base64decode(var.k8s_ca)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", var.cluster_name, "--region", var.region]
  }
}
```

* This works **with your SSO login** (`aws sso login`)
* No need to manually generate tokens or worry about expiry.
* Ensures Terraform uses **your SSO user identity** to authenticate with EKS.

> **Important:** Even with `exec`, your SSO user **still needs to be mapped in `aws-auth` ConfigMap** if you want to create resources like namespaces or service accounts.

---

### **Recommended workflow**

1. `aws sso login` ✅
2. Deploy the EKS cluster. ✅
3. **Map your SSO user / role in `aws-auth` ConfigMap** for `system:masters`.
4. Use the **dynamic token `exec` provider** in Terraform for Kubernetes. ✅
5. Then you can create namespaces, service accounts, etc. without `Unauthorized`.

---

I can rewrite your **namespace module** to be **SSO-friendly**, using the `exec` provider, fully Terragrunt-ready, so that once your SSO user is mapped in `aws-auth`, it will work immediately.

Do you want me to do that?


provider "kubernetes" {
  host                   = var.k8s_host
  cluster_ca_certificate = base64decode(var.k8s_ca)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = [
      "eks", "get-token",
      "--cluster-name", var.cluster_name,
      "--region", var.region
    ]
  }
}

provider "helm" {
  kubernetes {
    host                   = var.k8s_host
    cluster_ca_certificate = base64decode(var.k8s_ca)

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args        = [
        "eks", "get-token",
        "--cluster-name", var.cluster_name,
        "--region", var.region
      ]
    }
  }
}
