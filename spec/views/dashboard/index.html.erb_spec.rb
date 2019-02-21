# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'dashboard/index.html.erb', type: :view do
  it 'renders the dashboard page' do
    render template: 'dashboard/index.html.erb'

    expect(rendered).to match(/dashboard/)
  end
  it 'the url should be equal the root path' do
    expect(controller.request.fullpath).to eq root_path
  end
end
