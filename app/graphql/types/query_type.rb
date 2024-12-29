# frozen_string_literal: true

module Types
  # The QueryType class defines the root-level queries in the GraphQL schema.
  # It acts as the entry point for all queries, allowing clients to fetch data from the server.
  #
  # Each `field` defined in this class represents a query that clients can execute.
  # Queries are responsible for fetching data, and each field is associated with a resolver method
  # that contains the logic to retrieve the requested data.
  class QueryType < Types::BaseObject
    # Fetches an object given its global ID.
    #
    # This field follows the Relay specification for object identification,
    # allowing clients to fetch any object in the schema by its unique global ID.
    #
    # @param id [ID] The globally unique ID of the object to fetch.
    # @return [NodeType, nil] The object corresponding to the given ID, or nil if not found.
    field :node, Types::NodeType, null: true, description: 'Fetches an object given its ID.' do
      argument :id, ID, required: true, description: 'ID of the object.'
    end

    # Resolver method for the `node` field.
    # Uses the schema's `object_from_id` method to decode the global ID and fetch the object.
    #
    # @param id [String] The global ID of the object.
    # @return [Object, nil] The resolved object or nil if not found.
    def node(id:)
      context.schema.object_from_id(id, context)
    end

    # Fetches a list of objects given a list of global IDs.
    #
    # This field supports the Relay specification for fetching multiple objects
    # by their unique global IDs in a single query.
    #
    # @param ids [Array<ID>] A list of globally unique IDs of the objects to fetch.
    # @return [Array<NodeType, nil>] A list of objects corresponding to the given IDs, or nil for missing objects.
    field :nodes, [Types::NodeType, { null: true }], null: true,
                                                     description: 'Fetches a list of objects given a list of IDs.' do
      argument :ids, [ID], required: true, description: 'IDs of the objects.'
    end

    # Resolver method for the `nodes` field.
    # Uses the schema's `object_from_id` method to decode each global ID and fetch the corresponding objects.
    #
    # @param ids [Array<String>] The global IDs of the objects.
    # @return [Array<Object, nil>] The resolved objects, or nil for missing objects.
    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    # An example query field added by the Rails generator.
    #
    # This field serves as a placeholder to demonstrate how to define and resolve fields in GraphQL.
    # It always returns the string "Hello World!".
    #
    # @return [String] The string "Hello World!".
    field :test_field, String, null: false,
                               description: 'An example field added by the generator'

    # Resolver method for the `test_field` field.
    # Returns a static string to demonstrate a simple resolver.
    #
    # @return [String] The string "Hello World!".
    def test_field
      'Hello World!'
    end
  end
end
