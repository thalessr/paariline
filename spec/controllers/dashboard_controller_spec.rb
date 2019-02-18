# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  let(:user) { create(:user) }

  before { sign_in(user) }

  describe 'routes' do
    let(:dashbord_url) { '/welcome_page' }

    context 'with GET' do
      it { route(:get, dashbord_url).to(controller: :dashboard, action: :index) }
    end
  end

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
