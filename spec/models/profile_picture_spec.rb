# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProfilePicture, type: :model do
  describe 'db indexes' do
    it { is_expected.to have_db_index(:user_id) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_one(:picture_attachment) }
  end
end
