# frozen_string_literal: true

require 'rails_helper'

module Mutations
  module Users
    RSpec.describe UpdateUser, type: :request do
      describe '.resolve' do
        let!(:user) { create(:user, name: 'John Doe', email: 'john.doe@example.com') }

        def mutation(id:, address:)
          <<~GQL
            mutation {
              updateUser(input: {
                id: "#{id}",
                address: {
                  street: "#{address[:street]}",
                  city: "#{address[:city]}",
                  state: "#{address[:state]}"
                }
              }) {
                user {
                  id
                  name
                  email
                  address {
                    street
                    city
                    state
                  }
                }
                errors
              }
            }
          GQL
        end

        it 'updates address an existing user' do
          post '/graphql', params: { query: mutation(
            id: user.id,
            address: {
              street: '456 Another St',
              city: 'San Francisco',
              state: 'CA'
            }
          ) }
          json = JSON.parse(response.body)

          updated_user = json.dig('data', 'updateUser', 'user')
          errors = json.dig('data', 'updateUser', 'errors')

          expect(updated_user).to include(
            'id' => user.id.to_s,
            'name' => 'John Doe',
            'email' => 'john.doe@example.com',
            'address' => {
              'street' => '456 Another St',
              'city' => 'San Francisco',
              'state' => 'CA'
            }
          )
          expect(errors).to be_empty
        end

        it 'returns validation error when Address state is invalid' do
          post '/graphql', params: { query: mutation(
            id: user.id,
            address: {
              street: '456 Another St',
              city: 'San Francisco',
              state: 'XPTO'
            }
          ) }
          json = JSON.parse(response.body)

          updated_user = json.dig('data', 'updateUser', 'user')
          errors = json.dig('data', 'updateUser', 'errors')

          expect(errors).to include('Address state is too long (maximum is 2 characters)')
          expect(updated_user).to be_nil
        end
      end
    end
  end
end
