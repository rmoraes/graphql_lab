# frozen_string_literal: true

module Types
  # The QueryType class defines the root-level queries in the GraphQL schema.
  # It acts as the entry point for all queries, allowing clients to fetch data from the server.
  #
  # Each `field` defined in this class represents a query that clients can execute.
  # Queries are responsible for fetching data, and each field is associated with a resolver method
  # that contains the logic to retrieve the requested data.
  class QueryType < Types::BaseObject
    # Automatically include node and nodes fields
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    include Queries::UserQueries
  end
end
