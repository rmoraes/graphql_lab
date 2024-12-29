# frozen_string_literal: true

module Types
  module Input
    class AddressInputType < Types::BaseInputObject
      description 'Input type for address'

      argument :street, String, required: true, description: 'Street of the address'
      argument :city, String, required: true, description: 'City of the address'
      argument :state, String, required: true, description: 'State of the address'
    end
  end
end
