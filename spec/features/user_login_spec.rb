# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User login', type: :feature, js: true do
  before { create(:user, email: 'test@paariline.ee', password: 'just4test') }

  it 'with correct credentials' do
    visit '/'
    click_link 'Login'
    expect(page).to have_css('h2', text: 'Log in')
    expect(page).to have_current_path(new_user_session_path)

    fill_in('Email', with: 'test@paariline.ee')
    fill_in('Password', with: 'just4test')

    click_button 'Log in'

    expect(page).to have_current_path '/'
    expect(page).to match(/home/)
    click_link 'Logout'
  end
end
