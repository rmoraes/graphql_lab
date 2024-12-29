# frozen_string_literal: true

module Types
  # The MutationType class defines the root mutation type for the GraphQL schema.
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::CreateUser
    field :update_user, mutation: Mutations::UpdateUser
  end
end
