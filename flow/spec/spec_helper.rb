
require 'rubygems' # spork
require 'spork'    # spork

ENV["RAILS_ENV"] ||= 'test' # this will automatically require the test section of Gemfile

require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist

#uncomment the following line to use spork with the debugger
#require 'spork/ext/ruby-debug'

Spork.prefork do # spork
  RSpec.configure do |config|
    config.use_transactional_fixtures = true
    config.infer_base_class_for_anonymous_controllers = false
    config.order = "random"
    config.treat_symbols_as_metadata_keys_with_true_values = true
    config.filter_run :focus => true
    config.run_all_when_everything_filtered = true
    config.include FactoryGirl::Syntax::Methods
  end
end

Spork.each_run do
  # as per railscasts recommendations
  FactoryGirl.reload # spork related
  
  # placed in each_run as per recommendation http://stackoverflow.com/questions/8409286/spork-error-undefined-method-split-for-nilnilclass-nomethoderror
  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
end

