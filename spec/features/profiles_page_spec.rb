# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Profiles Page', type: :feature, js: true do
  let(:user) { create(:user) }

  before { login_as(user, scope: :user) }

  describe 'when profile list is empty' do
    it do
      visit '/#/profiles'
      expect(page).to have_selector('div.ant-card-body', count: 0)
    end
  end

  describe 'when there are 16 profiles' do
    before { create_list(:profile_picture, 16) }

    it do
      visit '/#/profiles'
      expect(page).to have_selector('div.ant-card-body', count: 16)
    end
  end
end
