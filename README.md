# Reusable GCP Terraform Modules

Reusable Compute Engine VM module with separate dev and UAT environments, plus Jenkins and GitHub Actions examples.

## Layout
- `modules/vm`: reusable VM module
- `environments/dev`: dev root module and tfvars
- `environments/uat`: UAT root module and tfvars
- `Jenkinsfile`: format/init/validate/plan/approval/apply example
- `.github/workflows/terraform.yml`: format/init/validate checks

## Before running
1. Install Terraform and Google Cloud CLI.
2. Enable the Compute Engine API in your target project.
3. Authenticate locally with `gcloud auth application-default login`, or use an attached service account on a GCP VM.
4. Replace `YOUR_GCP_PROJECT_ID` in the environment tfvars files.
5. Review the plan carefully. This can create billable resources.

The sample VM uses the existing `default` VPC and does not get an external IP by default. For production, use a dedicated network, least-privilege IAM, restricted ingress and your organization's security standards.

## Run dev
```bash
cd environments/dev
terraform fmt -recursive
terraform init
terraform validate
terraform plan -var-file=terraform-dev.tfvars
terraform apply -var-file=terraform-dev.tfvars
```

## Run UAT
```bash
cd environments/uat
terraform fmt -recursive
terraform init
terraform validate
terraform plan -var-file=terraform-uat.tfvars
terraform apply -var-file=terraform-uat.tfvars
```

Each environment is a separate Terraform root and therefore has its own state. For team use, configure a GCS backend with a different prefix per environment. The bucket must exist before `terraform init`. Do not commit state or plan files to Git. If migrating local state, carefully use `terraform init -migrate-state`.

## Jenkins
The Jenkinsfile assumes Terraform is installed on the agent and GCP ADC is configured. Configure a multibranch Pipeline job pointing at this repository. The sample allows plan runs and gates apply behind a manual approval on `main` when `RUN_APPLY` is enabled. Restrict apply permissions and approval rights in production. The plan file is sensitive and must be handled as a protected artifact.

## GitHub Actions
The included workflow runs formatting and validation without authenticating to GCP. It intentionally does not apply infrastructure. For authenticated plan/apply, configure Workload Identity Federation or another approved short-lived authentication mechanism.

## Cleanup
Review the destroy plan before deleting resources:
```bash
cd environments/dev
terraform destroy -var-file=terraform-dev.tfvars
```
