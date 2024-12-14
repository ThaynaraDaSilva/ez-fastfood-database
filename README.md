# Infraestrutura de Banco de Dados Gerenciável com Terraform

## Escolha do Banco de Dados: PostgreSQL

### Introdução
Na fase inicial do projeto, escolhemos o PostgreSQL devido à sua popularidade e forte adoção pela comunidade. Após estudar a disciplina de Engenharia de Dados, aprofundamos nossa análise e confirmamos que ele continua sendo a melhor solução para nossas necessidades, especialmente devido à sua capacidade de lidar com relacionamentos complexos entre as tabelas.

---

## Vantagens Técnicas do PostgreSQL

1. **Modelagem de Dados e Schemas:**
   - Suporte robusto a schemas, proporcionando organização clara e flexibilidade na estrutura de dados.

2. **Forte Relacionamento entre Tabelas:**
   - Ideal para modelagem de dados com relacionamentos complexos (por exemplo, Pedidos, Pagamento e Clinte).

3. **Integridade Transacional:**
   - Garantia de consistência e confiabilidade nas transações, fundamental para operações financeiras e logísticas.

4. **Flexibilidade de Consultas:**
   - SQL avançado, suporte a junções e consultas analíticas complexas.

5. **Comunidade Ativa:**
   - Documentação extensa, suporte técnico e uma ampla variedade de ferramentas compatíveis.

---

## Justificativa para Não Usar um Banco Não Relacional

1. **Foco em Relacionamentos:**
   - A estrutura do negócio exige fortes relacionamentos entre entidades, o que seria menos eficiente em um banco não relacional.

---

## Infraestrutura na Nuvem com Terraform

Para garantir alta disponibilidade e escalabilidade, utilizamos o Amazon RDS para PostgreSQL, configurado via Terraform, juntamente com uma VPC para isolamento e segurança da rede.

### Benefícios do Amazon RDS para PostgreSQL

- **Gerenciamento Simplificado:**
  - Backups automáticos, atualizações de versão e manutenção gerenciada pela AWS.

- **Alta Disponibilidade e Redundância:**
  - Configuração Multi-AZ para maior resiliência.

- **Segurança:**
  - Criptografia de dados em repouso e em trânsito, além de políticas de acesso configuráveis.

- **Monitoramento e Escalabilidade:**
  - Métricas detalhadas via Amazon CloudWatch e escalabilidade ajustável conforme a demanda.

---

## Organização do Repositório Terraform

O repositório está organizado com os seguintes diretórios principais:

```
/aws-vpc
  - Configuração da Virtual Private Cloud (VPC), subnets, security groups e rotas.

/aws-rds
  - Configuração do Amazon RDS para PostgreSQL, incluindo parâmetros de inicialização e integração com a VPC.
```

### Configuração da VPC (`aws-vpc`)
- **Objetivo:** Garantir isolamento da rede e controle de tráfego.
- Inclui:
  - Subnets públicas e privadas.
  - Tabelas de rotas e gateways de internet.
  - Security groups para controle de acesso ao banco de dados.

### Configuração do RDS (`aws-rds`)
- **Objetivo:** Criar o banco de dados PostgreSQL gerenciado.
- Inclui:
  - Configuração de instâncias, parâmetros de performance e backups automáticos.
  - Associação com as subnets privadas da VPC.

---

## Modelagem de Dados
O banco de dados foi modelado com base nos requisitos do negócio, priorizando o uso de relacionamentos fortes entre tabelas. O diagrama abaixo representa o modelo de dados, incluindo entidades como **Pedidos**, **Pagamentos** e **Clientes**.

![Diagrama ER](./diagrams/database-model.png)

---

## Arquitetura na Nuvem
A infraestrutura foi projetada para garantir alta segurança, escalabilidade e disponibilidade. O diagrama abaixo ilustra como os componentes da AWS interagem para suportar o banco de dados gerenciado.

![Diagrama de Arquitetura AWS](./diagrams/aws-architecture.png)

---

## Passos para Configuração e Deploy

1. Clone o repositório e navegue até o diretório raiz:
   ```bash
   git clone <url-repositorio>
   cd terraform
   ```

2. Configure suas credenciais da AWS.

3. Inicialize o Terraform e aplique a infraestrutura:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

4. Verifique se os recursos foram criados corretamente no console da AWS.

---

## Próximos Passos

1. Testar a conexão com o banco de dados utilizando a VPC configurada.
2. Implementar consultas otimizadas para o modelo de dados atual.
3. Garantir monitoramento contínuo utilizando Amazon CloudWatch.

Essa abordagem modular e gerenciada garante uma infraestrutura robusta, segura e escalável para suportar o crescimento do projeto.



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
