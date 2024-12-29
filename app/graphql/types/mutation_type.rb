# frozen_string_literal: true

module Types
  # The MutationType class defines the root mutation type for the GraphQL schema.
  # Mutations represent actions that can change the server-side data, such as creating,
  # updating, or deleting resources.
  #
  # This class is generated as a starting point for adding mutations to the application.
  # Each field in this class represents a mutation that the client can execute.
  #
  # Example:
  # - `field :create_user` might represent a mutation to create a new user in the database.
  #
  # Currently, this class includes a placeholder mutation field `test_field` as an example.
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::CreateUser
  end
end
