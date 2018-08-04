ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/autorun'
require 'minitest/pride'
require "shoulda-matchers"

class ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    sign_in FactoryGirl.create :usuario
  end
end

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  # fixtures :all

  # Add more helper methods to be used by all tests here...
end

::Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    # Choose a test framework:
    with.test_framework :minitest

    # Choose one or more libraries:
    with.library :active_record
    with.library :active_model
  end
end
