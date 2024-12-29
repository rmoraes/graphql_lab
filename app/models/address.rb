# frozen_string_literal: true

class Address < ApplicationRecord
  belongs_to :user

  validates :street, :city, :state, presence: true
  validates :street, :city, length: { maximum: 50 }
  validates :state, length: { maximum: 2 }
end
