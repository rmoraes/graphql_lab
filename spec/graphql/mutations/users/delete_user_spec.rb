# frozen_string_literal: true

require 'rails_helper'

module Mutations
  module Users
    RSpec.describe DeleteUser, type: :request do
      describe '.resolve' do
        let!(:user) { create(:user) }

        def mutation(id:)
          <<~GQL
            mutation {
              deleteUser(input: { id: "#{id}" }) {
                success
                errors
              }
            }
          GQL
        end

        it 'deletes an existing user' do
          post '/graphql', params: { query: mutation(id: user.id) }
          json = JSON.parse(response.body)

          success = json.dig('data', 'deleteUser', 'success')
          errors = json.dig('data', 'deleteUser', 'errors')

          expect(success).to be_truthy
          expect(errors).to be_empty
          expect(User.exists?(id: user.id)).to be_falsey
        end

        it 'returns an error when the user does not exist' do
          post '/graphql', params: { query: mutation(id: -1) }
          json = JSON.parse(response.body)

          success = json.dig('data', 'deleteUser', 'success')
          errors = json.dig('data', 'deleteUser', 'errors')

          expect(success).to be_falsey
          expect(errors).to include('User not found')
        end
      end
    end
  end
end
