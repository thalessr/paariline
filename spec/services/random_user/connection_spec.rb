# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RandomUser::Connection do
  subject(:connection) { described_class.new(results: 2) }

  describe '#search_repositories' do
    it do
      VCR.use_cassette('randon_user_search', record: :once) do
        response = connection.request
        expect(response.body).not_to be_empty
      end
    end

    it do
      VCR.use_cassette('randon_user_search', record: :once) do
        response = connection.request
        expect(response.status).to eq(200)
      end
    end
  end
end
