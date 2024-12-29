# frozen_string_literal: true

module Mutations
  # Mutation to create a new user.
  # Accepts user attributes, including optional nested attributes for the address, through the `input` argument.
  # Returns the created user and a list of errors (if any).
  class CreateUser < BaseMutation
    argument :name, String, required: true, description: 'The name of the user'
    argument :email, String, required: true, description: 'The email of the user'
    argument :address, Types::Input::AddressInputType, required: false, description: 'The user address'

    field :user, Types::Models::UserType, null: true, description: 'The newly created user'
    field :errors, [String], null: false, description: 'A list of errors encountered during user creation'

    # Resolver
    def resolve(name:, email:, address: nil)
      address_hash = address.to_h if address

      user = User.new(name: name, email: email, address_attributes: address_hash)

      if user.save
        { user: user }
      else
        { user: nil, errors: user.errors.full_messages }
      end
    end
  end
end
