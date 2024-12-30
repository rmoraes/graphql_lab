# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'db structure' do
    it { is_expected.to have_db_column(:name).of_type(:string).with_options(null: false, limit: 50) }
    it { is_expected.to have_db_column(:email).of_type(:string).with_options(null: false, limit: 50) }
  end

  describe 'associations' do
    it { is_expected.to have_one(:address).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }

    it { is_expected.to validate_length_of(:name).is_at_most(50) }
    it { is_expected.to validate_length_of(:email).is_at_most(50) }

    it { is_expected.to allow_value('test@example.com').for(:email) }
    it { is_expected.not_to allow_value('invalid_email').for(:email) }
  end
end
