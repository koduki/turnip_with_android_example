require 'bundler/setup'
require 'selenium-webdriver'

Dir.glob("spec/steps/**/*steps.rb") { |f| load f, true }
