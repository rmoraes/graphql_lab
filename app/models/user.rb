# frozen_string_literal: true

class User < ApplicationRecord
  include Queryable
  include Filterable

  has_one :address, dependent: :destroy
  accepts_nested_attributes_for :address

  has_many :tasks, dependent: :destroy

  validates :name, :email, presence: true
  validates :name, :email, length: { maximum: 50 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  scope :filter_by_name, ->(value) { where_matches_any name: value }
  scope :filter_by_email, ->(value) { where email: value }
  scope :filter_by_address_city, ->(value) { where_matches_any association: { address: { city: value } } }
end
