# frozen_string_literal: true

module Types
  module Models
    class UserType < Types::BaseObject
      description 'A user in the system'

      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

      field :id, ID, null: false
      field :name, String, null: false
      field :email, String, null: false

      # Associations
      field :address, Types::Models::AddressType, null: true, description: 'The address of the user'
      field :tasks, [Types::Models::TaskType], null: true, description: 'List of tasks assigned to the user'
    end
  end
end
