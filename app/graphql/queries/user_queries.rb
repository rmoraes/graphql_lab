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

      field :users, [Types::Models::UserType], null: true, description: 'List all users or filter by email' do
        argument :email, String, required: false, description: 'Filter users by email'
      end
    end

    # Resolver for user by ID
    def user(id:)
      User.find_by(id: id)
    end

    # Resolver for users with optional email filtering
    def users(email: nil)
      if email.present?
        User.where(email: email)
      else
        User.all
      end
    end
  end
end
