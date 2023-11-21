.DEFAULT_GOAL := help

# Colors
GREEN  := \033[0;32m
RED    := \033[0;31m
NC     := \033[0m

help:
	@echo "$(GREEN)Available options:$(NC)"
	@echo "$(GREEN)  init$(NC)                 Initialize Terraform modules"
	@echo "$(GREEN)  plan$(NC)                 Generate and show Terraform execution plan"
	@echo "$(GREEN)  apply$(NC)                Create infrastructure using Terraform "
	@echo "$(GREEN)  destroy$(NC)              Destroy Terraform-managed infrastructure"
	@echo ""
	@echo "$(GREEN)Usage: make <option>$(NC)"

%:
	@echo "$(RED)Error: Invalid target. Run 'make help' for available options.$(NC)"

TARGET_FILE_PATH := "modules/vpc/backend.tf" "modules/eks-cluster/backend.tf" "modules/eks-cluster/remote_data.tf"
BUCKET_NAME := $(shell echo $$TF_BUCKET_NAME)
CLUSTER_NAME := $(or $(TF_VAR_cluster_name), development)

init:
	sed -i '' 's/your-bucket/$(BUCKET_NAME)/g' $(TARGET_FILE_PATH)
	terraform -chdir=modules/vpc init
	terraform -chdir=modules/eks-cluster init

plan:
	terraform -chdir=modules/vpc plan
	terraform -chdir=modules/eks-cluster plan

apply:
	terraform -chdir=modules/vpc apply --auto-approve
	terraform -chdir=modules/eks-cluster apply --auto-approve

deploy-application:
	aws eks update-kubeconfig --name $(CLUSTER_NAME) --region us-east-1
	helm install hello-world-application hello-world-application

destroy:
	helm uninstall hello-world-application
	terraform -chdir=modules/eks-cluster destroy  --auto-approve
	terraform -chdir=modules/vpc destroy  --auto-approve
