# frozen_string_literal: true

require 'rails_helper'

module Queries
  RSpec.describe UserQueries, type: :request do
    let!(:user1) { create(:user, name: 'Paul Doe', email: 'paul.doe@example.com') }
    let!(:user2) { create(:user, name: 'Bill Doe', email: 'bill.doe@example.com') }
    let!(:user3) { create(:user, name: 'Dan Doe', email: 'dan.doe@example.com') }

    it 'returns users whose names partially match the provided list' do
      query = <<~GQL
        query {
           users(name: ["paul", "bill"]) {
            id
            name
            email
          }
        }
      GQL

      post '/graphql', params: { query: query }
      json = JSON.parse(response.body)
      users = json['data']['users']

      expect(users.length).to eq(2)
      expect(users[0]['name']).to eq('Paul Doe')
      expect(users[1]['name']).to eq('Bill Doe')
    end
  end
end
