C:\Users\Thaynara\.aws\credentials

1. Configurar terraform
2. Configurar AWS CLI
3. Instalar extensão no visual studio code
   1. Terraform
   2. AWS ToolKit
4. Condigurar Terraform Workspace no  VS CODE

# Comandos Terraform
```

terraform init      # Initializes the working directory and downloads the required providers
terraform plan      # Shows what will be created or modified
terraform plan -out=plan.out # Generate and save plan
terraform apply     # Applies the changes to your AWS account

terraform apply plan.out # Apply Saved plan


```

```
terraform -v
aws configure
aws sts get-caller-identity
```