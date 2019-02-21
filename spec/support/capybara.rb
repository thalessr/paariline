# frozen_string_literal: true

require 'capybara/rails'
require 'capybara/rspec'
require 'selenium/webdriver'

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.register_driver :headless_chrome do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: { args: %w[headless disable-gpu no-sandbox] }
  )

  Capybara::Selenium::Driver.new(app, browser: :chrome, desired_capabilities: capabilities)
end

Capybara.configure do |config|
  config.default_max_wait_time = 10
  config.default_driver = :chrome
  config.raise_server_errors = true
end

Capybara.javascript_driver = :headless_chrome
Capybara.server = :puma, { Silent: true }
Capybara.ignore_hidden_elements = false
# Capybara.app_host = 'http://localhost:3000'
Capybara.server_port = 3038
Capybara.server_host = '0.0.0.0'

RSpec.configure do |config|
  config.after(type: :feature) do
    errors = page.driver.browser.manage.logs.get(:browser)
    next if errors.blank?

    aggregate_failures 'js errors' do
      errors.each do |error|
        next unless error.level == 'WARNING'

        expect(error.level).not_to eq('SEVERE'), error.message
        STDERR.puts error.message
      end
    end
  end
end
