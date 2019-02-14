# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'db indexes' do
    it { is_expected.to have_db_index(:email).unique }
    it { is_expected.to have_db_index(:reset_password_token).unique }
    it { is_expected.to have_db_index(:unlock_token).unique }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_presence_of(:first_name).on(:update) }
    it { is_expected.to validate_presence_of(:last_name).on(:update) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:profile_pictures) }
  end

  describe '#full_name' do
    context 'when both first_name and last_name are provided' do
      let(:user) { build(:user, first_name: 'Mario', last_name: 'Bros') }

      it { expect(user.full_name).to eq('Mario Bros') }
    end

    context 'when only first_name is provided' do
      let(:user) { build(:user, first_name: 'Mario', last_name: nil) }

      it { expect(user.full_name).to eq('Mario') }
    end
  end
end
