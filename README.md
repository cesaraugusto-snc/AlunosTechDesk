# AlunosTechDesk 🚀

Plataforma integrada de help desk e gestão de chamados de suporte técnico, desenvolvida com uma arquitetura moderna baseada em microsserviços e APIs RESTful. O projeto engloba um back-end robusto em C# (.NET), um banco de dados relacional normalizado em Microsoft SQL Server, um painel Web responsivo e um aplicativo móvel multiplataforma em Flutter.

---

## 🛠️ Tecnologias Utilizadas

O ecossistema do projeto foi construído utilizando as seguintes tecnologias e ferramentas de mercado:

* **Back-end & API:** C# .NET, ASP.NET Core, Entity Framework Core (EF Core), LINQ, BCrypt (Segurança/Hash de senhas).
* **Banco de Dados:** Microsoft SQL Server (Transact-SQL, Migrations, Relacionamentos 1:N).
* **Front-end Web:** HTML5, CSS3, JavaScript puro (Fetch API assíncrona).
* **Mobile:** Flutter / Dart (Widgets reativos, pacotes HTTP, ListViews dinâmicas).
* **Infraestrutura & DevOps:** Docker (Conteinerização e multi-stage builds).
* **Ferramentas de Apoio:** Swagger UI (OpenAPI), Git / GitHub, Visual Studio / VS Code.

---

## 🏗️ Arquitetura do Sistema

O sistema segue os princípios da Engenharia de Software moderna, utilizando uma arquitetura em camadas para garantir o desacoplamento:
1. **Camada de Apresentação (Client-side):** Painel Web responsivo e App Mobile em Flutter.
2. **Camada de Serviço (Server-side API):** Endpoints RESTful mapeados para gerenciar Usuários, Chamados e Histórico.
3. **Camada de Persistência (Database Layer):** Gerenciamento relacional via Entity Framework Core e SQL Server.
4. **Camada de Infraestrutura:** Empacotamento e portabilidade via Docker.

---

## 📸 Demonstração do Sistema

* **Documentação da API via Swagger UI**
<img width="800" alt="Swagger UI" src="https://github.com/user-attachments/assets/fe92a420-ada1-458a-9e98-3ef2049cd9ce" />

* **Painel de Autenticação / Login**
<img width="800" alt="Tela de Login" src="https://github.com/user-attachments/assets/0e1e2902-1ba4-4852-b89d-ec770ece4cdd" />

* **Painel de Chamados Web**
<img width="800" alt="Painel Web" src="https://github.com/user-attachments/assets/c2fc9f16-ca61-4c9b-b9eb-4d3c6f94ab9e" />

---

## ⚙️ Como Executar o Projeto Localmente

### Pré-requisitos
* .NET SDK instalado
* SQL Server (ou LocalDB) configurado
* Flutter SDK (caso queira rodar o mobile)

### 1. Clonar o repositório
```bash
git clone [https://github.com/cesaraugusto-snc/AlunosTechDesk.git](https://github.com/cesaraugusto-snc/AlunosTechDesk.git)
