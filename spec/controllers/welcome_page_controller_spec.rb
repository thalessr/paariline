# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WelcomePageController, type: :controller do
  describe 'routes' do
    let(:welcome_url) { '/welcome_page' }

    context 'with GET' do
      it { route(:get, welcome_url).to(controller: :welcome_page, action: :index) }
    end
  end

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
