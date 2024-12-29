# frozen_string_literal: true

module Mutations
  # Mutation to delete a user by ID.
  # Accepts the user ID as input and returns the result of the operation.
  class DeleteUser < BaseMutation
    argument :id, ID, required: true, description: 'ID of the user to delete'

    field :success, Boolean, null: false, description: 'Indicates if the user was successfully deleted'
    field :errors, [String], null: false, description: 'A list of errors encountered during deletion'

    def resolve(id:)
      user = User.find_by(id: id)

      if user.nil?
        { success: false, errors: ['User not found'] }
      elsif user.destroy
        { success: true, errors: [] }
      else
        { success: false, errors: user.errors.full_messages }
      end
    end
  end
end
