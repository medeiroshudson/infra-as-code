# Variáveis
TERRAFORM_DIR := ./terraform
VARIABLES_FILE := terraform.tfvars

# Targets principais
all: init validate plan apply

init:
	@echo "Inicializando o Terraform..."
	@cd $(TERRAFORM_DIR) && terraform init

validate:
	@echo "Validando a configuração do Terraform..."
	@cd $(TERRAFORM_DIR) && terraform validate

plan:
	@echo "Gerando o plano de execução do Terraform..."
	@cd $(TERRAFORM_DIR) && terraform plan -var-file=$(VARIABLES_FILE)

apply:
	@echo "Aplicando a configuração do Terraform..."
	@cd $(TERRAFORM_DIR) && terraform apply -var-file=$(VARIABLES_FILE) -auto-approve

destroy:
	@echo "Destruindo a infraestrutura provisionada pelo Terraform..."
	@cd $(TERRAFORM_DIR) && terraform destroy -var-file=$(VARIABLES_FILE) -auto-approve

clean:
	@echo "Limpando arquivos temporários do Terraform..."
	@cd $(TERRAFORM_DIR) && rm -rf .terraform .terraform.lock.hcl terraform.tfstate terraform.tfstate.backup

# Ajuda
help:
	@echo "Comandos disponíveis:"
	@echo "  make init      - Inicializa o Terraform"
	@echo "  make validate  - Valida a configuração do Terraform"
	@echo "  make plan      - Gera o plano de execução do Terraform"
	@echo "  make apply     - Aplica a configuração do Terraform"
	@echo "  make destroy   - Destroi a infraestrutura provisionada pelo Terraform"
	@echo "  make clean     - Remove arquivos temporários do Terraform"
	@echo "  make help      - Mostra esta ajuda"