# Environment setup for the testing framework
require 'capybara/cucumber'
require 'capybara/session'
require 'selenium-webdriver'

# Load the application
require_relative '../../app'

# Set up Capybara
Capybara.app = AppointmentScheduler::App
Capybara.default_driver = :selenium_chrome_headless