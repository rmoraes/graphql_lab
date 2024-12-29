# frozen_string_literal: true

class User < ApplicationRecord
  include Queryable
  include Filterable

  has_one :address, dependent: :destroy
  accepts_nested_attributes_for :address

  has_many :tasks, dependent: :destroy

  scope :filter_by_name, ->(value) { where_matches_any name: value }
  scope :filter_by_email, ->(value) { where email: value }
  scope :filter_by_address_city, ->(value) { where_matches_any association: { address: { city: value } } }
end
