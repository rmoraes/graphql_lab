# frozen_string_literal: true

module Types
  module Models
    class AddressType < Types::BaseObject
      description 'An address associated with a user'

      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

      field :id, ID, null: false
      field :street, String, null: false, description: 'Street of the address'
      field :city, String, null: false, description: 'City of the address'
      field :state, String, null: false, description: 'State of the address'
    end
  end
end
