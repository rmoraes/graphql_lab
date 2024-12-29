# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :title, length: { maximum: 100 }
  validates :description, length: { maximum: 255 }
  validates :completed, inclusion: { in: [true, false] }
end
