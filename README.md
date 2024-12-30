# GraphQL + Ruby on Rails Test Project

Este projeto é uma aplicação criada para explorar e testar integrações entre **GraphQL** e **Ruby on Rails**. Ele serve como um ambiente para aprender, experimentar e validar implementações de APIs GraphQL com as melhores práticas em Rails.

---

## 🚀 Objetivo

O objetivo deste projeto é:
- Demonstrar como configurar e usar GraphQL em um projeto Ruby on Rails.
- Servir como base para testar novas funcionalidades ou conceitos relacionados a GraphQL.
- Proporcionar um ambiente para experimentação segura e iterativa.

---

## 🛠️ Tecnologias Utilizadas

- **Ruby on Rails**: Framework backend para construção da API.
- **GraphQL-Ruby**: Biblioteca para criar schemas e APIs GraphQL.
- **RSpec**: Ferramenta de teste para garantir a qualidade do código.
- **PostgreSQL**: Banco de dados para desenvolvimento.
- **GraphiQL**: Interface para explorar e testar a API GraphQL.

---

## 📚 Funcionalidades Incluídas

1. **Configuração Inicial de GraphQL com Rails**:
   - Schema configurado com `graphql-ruby`.
   - Queries e Mutations básicas implementadas.

2. **Exemplo de Queries e Mutations**:
   - Exemplo de `Query` para listar usuários e filtros opcionais.
   - Exemplo de `Mutation` para criar, atualizar e deletar recursos.

3. **Integração com GraphiQL**:
   - Ferramenta de playground para explorar e testar a API.

4. **Suporte a Testes Automatizados**:
   - Testes de queries e mutations usando RSpec.

---

## 📋 Estrutura do Projeto

- **`app/graphql`**:
  - **`types/`**: Definições de tipos para GraphQL.
  - **`mutations/`**: Mutations do GraphQL.
  - **`queries/`**: Queries do GraphQL.
  - **`schema.rb`**: Arquivo principal que conecta queries e mutations.

- **`spec/`**:
  - Testes para validar queries e mutations.

---

## 📝 Exemplos de Uso

### **🔄 Exemplo de Mutation**

Abaixo está um exemplo de mutation para criar um usuário com informações básicas e endereço associado:

```graphql
mutation {
  createUser(input: {
    name: "John Doe",
    email: "john.doe@example.com",
    address: {
      street: "123 Main St",
      city: "New York",
      state: "NY"
    }
  }) {
    user {
      id
      name
      email
      address {
        street
        city
        state
      }
    }
    errors
  }
}
```

---

### **🔍 Exemplo de Query**

Este exemplo de query retorna usuários cujos nomes parcialmente correspondem a uma lista de termos fornecidos:

```graphql
query {
  users(name: ["paul", "bill"]) {
    id
    name
    email
  }
}
