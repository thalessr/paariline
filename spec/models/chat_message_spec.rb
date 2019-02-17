# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChatMessage, type: :model do
  describe 'db indexes' do
    it { is_expected.to have_db_index(:chat_room_id) }
    it { is_expected.to have_db_index(:seen_by_id) }
    it { is_expected.to have_db_index(:sent_by_id) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:chat_room) }
    it { is_expected.to belong_to(:sent_by).class_name('User') }
    it { is_expected.to belong_to(:seen_by).class_name('User') }
  end
end
