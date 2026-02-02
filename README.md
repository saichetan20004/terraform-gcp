# terraform-gcp

This repo consists of Terraform scripts to create infrastructure in GCP like Artifact Registry, Compute Engine, Cloud Storage, Filestore and GKE.

Each infrastructure component is maintained in a **separate folder** and Terraform is executed inside each folder independently.

This setup is performed on macOS and all required dependencies are installed using the Homebrew package manager.

---

# Step 1: Install Homebrew (if not installed)

Check if brew exists:

```bash
brew --version
```

If not installed:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Verify:

```bash
brew doctor
```

---

# Step 2: Install Terraform

Install HashiCorp tap:

```bash
brew tap hashicorp/tap
```

Install Terraform:

```bash
brew install hashicorp/tap/terraform
```

Verify:

```bash
terraform -version
```

For other OS:

```bash
https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
```

---

# Step 3: Install Google Cloud CLI (gcloud)

Install:

```bash
brew update && brew install --cask google-cloud-sdk
```

Verify:

```bash
gcloud version
```

For os gcloud installation:

```bash
https://docs.cloud.google.com/sdk/docs/install-sdk
```

Initialize:

```bash
gcloud init
```

Login:

```bash
gcloud auth login
```

Enable Application Default Credentials for Terraform:

```bash
gcloud auth application-default login
```

```bash
gcloud auth application-default set-quota-project <project-id>
```

Set project:

```bash
gcloud config set project <PROJECT_ID>
```

# Step 4: Generate Public & Private PEM Key for VM Login (User: saichetan) — macOS

macOS already includes ssh-keygen, so no additional installation is required.

These steps generate a private key in **.pem format**, create the public key, and configure it for VM login with username **saichetan**.

---

## Generate Public and Private Key in PEM Format

Run:

```bash
ssh-keygen -t rsa -b 4096 -m PEM -f saichetan.pem -C saichetan
```

This creates:

- Private key → `saichetan.pem`
- Public key → `saichetan.pem.pub`

If prompted for passphrase:
- Press Enter for lab usage
- Or set a passphrase if required

---

## Set Required Permission on PEM File

```bash
chmod 400 saichetan.pem
```

---

## Verify PEM Format

```bash
head -n 1 saichetan.pem
```

Expected output:

```
-----BEGIN RSA PRIVATE KEY-----
```

---

## Prepare Public Key Entry for GCP

Print the public key:

```bash
cat saichetan.pem.pub
```

Copy the output and ensure it ends with the username:

```
saichetan
```

If not, edit and append a space + username at the end.

Example final format:

```
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQ... saichetan
```

---

## Add Public Key to terraform.tfvars (ssh_public_key)

Print your generated public key:

```bash
cat saichetan.pem.pub
```

Copy the full output line.

---

Open `terraform.tfvars` and add it under the variable **ssh_public_key**:

```hcl
ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQ... saichetan"
```

---

## How This Works

When Terraform creates the Compute Engine VM, it automatically injects this public key into the VM metadata.

Because of this:

- User **saichetan** is created on the VM
- Public key is pre-configured
- SSH login works immediately after VM creation
- No manual key paste in GCP Console required

---

## SSH into VM After Creation

```bash
ssh -i saichetan.pem saichetan@<ip-addr>
```

Get external IP:

```bash
gcloud compute instances list
```


---

# Step 5: Enable Required GCP APIs

Run once per project:

```bash
gcloud services enable \
compute.googleapis.com \
artifactregistry.googleapis.com \
container.googleapis.com \
file.googleapis.com \
storage.googleapis.com
```

---

# Step 6: Clone Repository

```bash
git clone <repo-url>
cd <module-folder>
```

Example:

```bash
cd terraform-gcp-compute
```

---

# Step 7: Configure Variables

Edit `terraform.tfvars`:

```hcl
project_id = "your-project-id"
region     = "us-central1"
zone       = "us-central1-a"
```

---

# Step 8: Run Terraform

Since each infrastructure component is in a separate folder, run Terraform inside that folder.

Initialize:

```bash
terraform init
```

Validate:

```bash
terraform validate
```

Plan:

```bash
terraform plan
```

Apply:

```bash
terraform apply
```

Type `yes` when prompted.

---

# Step 9: Example Execution Per service

## Compute Engine

```bash
cd terraform-gcp-compute
terraform init
terraform validate
terraform plan
terraform apply
```

---

## Artifact Registry

```bash
cd terraform-gcp-artifact-registry
terraform init
terraform validate
terraform plan
terraform apply
```

---

## Cloud Storage

```bash
cd terraform-gcp-storage
terraform init
terraform validate
terraform plan
terraform apply
```

---

## Filestore (Chargeable Service)

```bash
cd terraform-gcp-filestore
terraform init
terraform validate
terraform plan
terraform apply
```

---

## GKE (Chargeable Service)

```bash
cd terraform-gcp-gke
terraform init
terraform validate
terraform plan
terraform apply
```

---

# Step 10: # Install Docker inside the Compute Engine VM (For Artifact Registry testing)

SSH into the VM:

```bash
gcloud compute ssh <vm-name>
```


# SSH into the VM using terminal with PEM key

Make sure your PEM key file has correct permissions:

```bash
chmod 400 mykey.pem
```

Connect to the VM:

```bash
ssh -i mykey.pem <username>@<ip-addr>
```

Update packages:

```bash
sudo apt-get update
```

Install Docker:

```bash
sudo apt-get install -y docker.io
```

Start Docker service:

```bash
sudo systemctl enable docker
sudo systemctl start docker
```

Add current user to docker group (so sudo is not required):

```bash
sudo usermod -aG docker $USER
```

Log out and log back in to apply group changes.

Verify installation:

```bash
docker --version
```

Configure docker auth for GCP:

```bash
gcloud auth configure-docker <artifact registry with repository's location>
```


---

# Step 11: Verify Resources

Compute:

```bash
gcloud compute instances list
```

Artifact Registry:

```bash
gcloud artifacts repositories list
```

---

# Step 12: Install kubectl (Required for GKE)

```bash
snap install kubectl --classic
```

Verify:

```bash
kubectl version --client
```



Connect to cluster after logging into VM:

```bash
gcloud container clusters get-credentials <cluster-name> --region <region>
kubectl get nodes
```


GKE:

```bash
kubectl get nodes
```

Storage / Filestore:
Check in GCP Console.

---

# Step 13: Cleanup (Important — Avoid Charges)

Run destroy inside each module folder after testing.

```bash
terraform destroy
```

Verify deletion in GCP Console.

---

# Cost Note

- Compute Engine micro instances may be free tier eligible (region dependent)
- Artifact Registry & Storage low usage is low cost
- GKE and Filestore are NOT free tier
- Recommended: create → test → destroy quickly

---

# Purpose of Repo

- Terraform modular infrastructure
- GCP automation practice
- DevOps portfolio demonstration
- Infrastructure as Code lifecycle
