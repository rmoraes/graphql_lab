# frozen_string_literal: true

require 'rails_helper'

module Mutations
  module Users
    RSpec.describe CreateUser, type: :request do
      describe '#resolve' do
        def mutation(name:)
          <<~GQL
            mutation {
              createUser(input: {
                name: "#{name}",
                email: "john.doe@example.com",
                address: {
                  street: "123 Main St",
                  city: "New York",
                  state: "NY"
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

        it 'creates a new user' do
          post '/graphql', params: { query: mutation(name: 'John Doe') }
          json = JSON.parse(response.body)

          user = json.dig('data', 'createUser', 'user')
          errors = json.dig('data', 'createUser', 'errors')

          expect(user).to include(
            'id' => be_present,
            'name' => 'John Doe',
            'email' => 'john.doe@example.com',
            'address' => {
              'street' => '123 Main St',
              'city' => 'New York',
              'state' => 'NY'
            }
          )
          expect(errors).to be_empty
        end

        it 'returns validation error when name is empty' do
          post '/graphql', params: { query: mutation(name: '') }
          json = JSON.parse(response.body)

          user = json.dig('data', 'createUser', 'user')
          errors = json.dig('data', 'createUser', 'errors')

          expect(errors).to include("Name can't be blank")
          expect(user).to be_nil
        end
      end
    end
  end
end
