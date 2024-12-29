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
    # A placeholder field added by the Rails generator to demonstrate how mutations work.
    #
    # @return [String] Always returns "Hello World".
    field :test_field, String, null: false,
                               description: 'An example field added by the generator'

    # Resolver method for the `test_field` mutation.
    # When this mutation is executed, it always returns the string "Hello World".
    #
    # @return [String] The string "Hello World".
    def test_field
      'Hello World'
    end
  end
end
