# frozen_string_literal: true

# This class defines the GraphQL schema for the application.
# It connects the root `query` and `mutation` types to the GraphQL execution engine
# and configures features like batch loading, error handling, and Relay-style object identification.
class GraphqlLabSchema < GraphQL::Schema
  # Specifies the root mutation type of the schema.
  # All mutations are defined in the `Types::MutationType` class.
  mutation(Types::MutationType)

  # Specifies the root query type of the schema.
  # All queries are defined in the `Types::QueryType` class.
  query(Types::QueryType)

  # Enables batch-loading functionality for efficient data fetching.
  # This is especially useful for optimizing N+1 query problems.
  # For more details, see: https://graphql-ruby.org/dataloader/overview.html
  use GraphQL::Dataloader

  # Handles type resolution for union types and interfaces.
  # This method determines which specific GraphQL type corresponds to a given object.
  # It must be implemented to support unions and interfaces.
  #
  # @param _abstract_type [GraphQL::BaseType] The abstract type being resolved (e.g., a union or interface).
  # @param _obj [Object] The object being resolved.
  # @param _ctx [GraphQL::Query::Context] The query context.
  # @raise [GraphQL::RequiredImplementationMissingError] If not implemented.
  def self.resolve_type(_abstract_type, _obj, _ctx)
    # TODO: Implement this method to map objects to their GraphQL types.
    raise(GraphQL::RequiredImplementationMissingError)
  end

  # Limits the size of incoming queries to prevent excessively large or malicious queries.
  #
  # @param max_query_string_tokens [Integer] The maximum number of tokens allowed in a query string.
  max_query_string_tokens(5000)

  # Specifies the maximum number of validation errors allowed before stopping validation.
  # This prevents the execution engine from spending too much time processing invalid queries.
  #
  # @param max_errors [Integer] The maximum number of validation errors.
  validate_max_errors(100)

  # Implements Relay-style object identification for resolving and encoding object IDs.

  # Encodes an object into a globally unique ID.
  #
  # @param object [Object] The object to be encoded.
  # @param _type_definition [GraphQL::BaseType] The GraphQL type of the object.
  # @param _query_ctx [GraphQL::Query::Context] The query context.
  # @return [String] A globally unique identifier for the object.
  def self.id_from_object(object, _type_definition, _query_ctx)
    # Uses Rails' GlobalID to generate a globally unique ID.
    object.to_gid_param
  end

  # Decodes a globally unique ID into an object.
  #
  # @param global_id [String] The globally unique identifier.
  # @param _query_ctx [GraphQL::Query::Context] The query context.
  # @return [Object] The object corresponding to the given ID.
  def self.object_from_id(global_id, _query_ctx)
    # Uses Rails' GlobalID to find the object from its global ID.
    GlobalID.find(global_id)
  end
end
