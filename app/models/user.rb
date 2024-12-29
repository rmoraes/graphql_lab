# frozen_string_literal: true

class User < ApplicationRecord
  has_one :address, dependent: :destroy
  has_many :tasks, dependent: :destroy

  accepts_nested_attributes_for :address
end
