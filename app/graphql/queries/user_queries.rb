# frozen_string_literal: true

module Queries
  # This module defines GraphQL queries for interacting with the User model.
  # It allows retrieving a specific user by their ID or listing all users in the system.
  module UserQueries
    extend ActiveSupport::Concern

    included do
      field :user, Types::Models::UserType, null: true do
        description 'Find a user by ID'
        argument :id, GraphQL::Types::ID, required: true
      end

      field :users, [Types::Models::UserType], null: true, description: 'List all users or filter' do
        argument :name, [String], required: false, description: 'Filter users by a list of partial names, allowing matches based on any substring.' # rubocop:disable Layout/LineLength
        argument :email, String, required: false, description: 'Filter users by email'
        argument :address_city, [String], required: false, description: 'Filter users by city in their address'
      end
    end

    # Resolver for user by ID
    def user(id:)
      User.find_by(id: id)
    end

    # Resolver for users with optional filtering
    def users(**args)
      User.filter_by(args.compact).includes(:address)
    end
  end
end
