# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'welcome_page/index.html.erb', type: :view do
  it 'renders the welcome_page' do
    render template: 'welcome_page/index.html.erb'

    expect(rendered).to match(/welcome/)
  end

  it 'the url should be equal the root path' do
    expect(controller.request.fullpath).to eq root_path
  end
end
