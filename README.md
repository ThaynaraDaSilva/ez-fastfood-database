# Infraestrutura de Banco de Dados

## Escolha do Banco de Dados: RDS PostgreSQL

A solução ez-fastfood-api, desenvolvida para uma lanchonete, foi inicialmente estruturada utilizando o banco de dados PostgreSQL devido à sua robustez, ampla adoção no mercado e suporte nativo para modelagem relacional de dados. A escolha de um banco relacional foi motivada pela necessidade de estabelecer relações entre entidades fundamentais da API, como pedidos, clientes e pagamentos, garantindo integridade, consistência e eficiência no gerenciamento dos dados.

Com a evolução do projeto e a necessidade de migração para um ambiente em nuvem, o Amazon RDS (Relational Database Service) com PostgreSQL foi a opção mais adequada por diversas razões:

1. **Facilidade de Migração**:
Por já utilizarmos o PostgreSQL no ambiente local, o Amazon RDS PostgreSQL permitiu uma transição transparente e eficiente para a nuvem. Não houve necessidade de refatoração da aplicação ou reestruturação do banco de dados, preservando a lógica relacional já estabelecida e minimizando o tempo e o esforço envolvidos no processo de migração.

2. **Escalabilidade Vertical e Horizontal**:
O Amazon RDS PostgreSQL oferece escalabilidade vertical e horizontal, permitindo o ajuste de recursos computacionais, como CPU, memória e armazenamento, de forma prática e sob demanda. Isso garante que a API possa lidar com o aumento de requisições sem impacto significativo no desempenho. Se a lanchonete expandir futuramente, o RDS PostgreSQL proporcionará um crescimento sustentável, suportando um maior volume de dados e transações simultâneas.

3. **Desempenho e Confiabilidade**:
O Amazon RDS PostgreSQL é uma solução gerenciada que oferece alta disponibilidade e redundância automática, garantindo que o banco de dados permaneça acessível mesmo em cenários de falhas ou interrupções. Recursos como réplicas de leitura e backups automatizados contribuem para um desempenho otimizado e uma operação segura, essenciais para APIs que exigem resposta rápida e alta confiabilidade.

4. **Gestão simplificada**:
Ao adotar o Amazon RDS, a equipe evita tarefas complexas de gerenciamento, como configuração, aplicação de patches, backups e monitoramento. Com o serviço gerenciado da AWS, o foco pode permanecer no desenvolvimento e na otimização da API, permitindo maior agilidade na entrega de melhorias e novas funcionalidades.

**Considerações Futuras**
Caso a lanchonete venha a expandir, o Amazon RDS PostgreSQL continuará sendo uma solução robusta e escalável. Ele poderá suportar tanto o crescimento do volume de dados quanto o aumento das transações simultâneas, mantendo a integridade e desempenho do sistema sem necessidade de migrações ou mudanças significativas na arquitetura.

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
