# frozen_string_literal: true

module Mutations
  # Mutation to update an existing user.
  # Accepts user attributes, including optional nested attributes for the address, through the `input` argument.
  # Returns the updated user and a list of errors (if any).
  class UpdateUser < BaseMutation
    argument :id, ID, required: true, description: 'The ID of the user to update'
    argument :name, String, required: false, description: 'The new name of the user'
    argument :email, String, required: false, description: 'The new email of the user'
    argument :address, Types::Input::AddressInputType, required: false, description: 'The new address of the user'

    field :user, Types::Models::UserType, null: true, description: 'The updated user'
    field :errors, [String], null: false, description: 'A list of errors encountered during user update'

    def resolve(id:, name: nil, email: nil, address: nil)
      user = User.find_by(id: id)

      raise GraphQL::ExecutionError, 'User not found' unless user

      attributes = { name: name, email: email }.compact
      address_hash = address.to_h if address
      attributes[:address_attributes] = address_hash if address_hash

      if user.update(attributes)
        { user: user, errors: [] }
      else
        { user: nil, errors: user.errors.full_messages }
      end
    end
  end
end
