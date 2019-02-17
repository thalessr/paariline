# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PictureInteraction, type: :model do
  describe 'db indexes' do
    it { is_expected.to have_db_index(:interaction_type) }
    it { is_expected.to have_db_index(:profile_picture_id) }
    it { is_expected.to have_db_index(:user_id) }
  end

  describe 'validations' do
    it { is_expected.to validate_inclusion_of(:interaction_type).in_array(PictureInteraction::InteractionTypes::ALL) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:profile_picture) }
  end
end
