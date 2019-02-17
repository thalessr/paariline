# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChatRoom, type: :model do
  describe 'db indexes' do
    it { is_expected.to have_db_index(:participant_id) }
    it { is_expected.to have_db_index(:created_by_id) }
    it { is_expected.to have_db_index(%i[participant_id created_by_id]).unique }
  end

  describe 'validations' do
    before { create(:chat_room) }

    it { is_expected.to validate_uniqueness_of(:participant_id).scoped_to(:created_by_id) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:participant).class_name('User') }
    it { is_expected.to belong_to(:created_by).class_name('User') }
  end
end
