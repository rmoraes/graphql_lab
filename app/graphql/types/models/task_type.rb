# frozen_string_literal: true

module Types
  module Models
    class TaskType < Types::BaseObject
      description 'A task associated with a user'

      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

      field :id, ID, null: false
      field :title, String, null: false, description: 'Title of the task'
      field :description, String, null: true, description: 'Description of the task'
      field :completed, Boolean, null: false, description: 'Whether the task is completed'
    end
  end
end
