# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Activity, type: :model do
  describe 'db indexes' do
    it { is_expected.to have_db_index(:source_id) }
    it { is_expected.to have_db_index(:source_name) }
    it { is_expected.to have_db_index(:owner_id) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:source_id) }
    it { is_expected.to validate_presence_of(:source_name) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:happened_at) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:owner).class_name('User') }
  end
end
