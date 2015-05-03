# capybara docs https://gist.github.com/428105

require 'rubygems' # spork
require 'spork'    # spork
require 'capybara/selenium/driver' # native selenium for low level work

include Warden::Test::Helpers
Warden.test_mode!

ENV["RAILS_ENV"] ||= 'test' # this will automatically require the test section of Gemfile

require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

# require 'capybara/poltergeist'
# Capybara.javascript_driver = :poltergeist
Capybara.javascript_driver = :selenium
Capybara.default_wait_time = 5

#uncomment the following line to use spork with the debugger
#require 'spork/ext/ruby-debug'

Spork.prefork do # spork
  RSpec.configure do |config|
    #
    # config.filter_run :focus => true
    #
    config.use_transactional_fixtures = true
    config.infer_base_class_for_anonymous_controllers = false
    config.order = "random"
    config.treat_symbols_as_metadata_keys_with_true_values = true
    config.run_all_when_everything_filtered = true
    config.include FactoryGirl::Syntax::Methods
  end
end

Spork.each_run do
  print "loading seeds.rb..."
  require "#{Rails.root}/db/seeds.rb"
  puts "done."

  # as per railscasts recommendations
  FactoryGirl.reload # spork related

  # placed in each_run as per recommendation http://stackoverflow.com/questions/8409286/spork-error-undefined-method-split-for-nilnilclass-nomethoderror
  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
end

def login
  begin
    user = User.find_by_email('super_admin@xyz.com')
    login_as(user, :scope => :user)
  rescue Exception => e
    puts e.inspect
  end
end

def logout
  logout(:user)
end


def retry_on_timeout(n = 3, &block)
  block.call
rescue Capybara::TimeoutError, Capybara::ElementNotFound => e
  if n > 0
    puts "Caught error: #{e.message}. #{n-1} more attempts."
    retry_on_timeout(n - 1, &block)
  else
    raise
  end
end

# http://artsy.github.com/blog/2012/02/03/reliably-testing-asynchronous-ui-w-slash-rspec-and-capybara/
# http://pivotallabs.com/waiting-for-jquery-ajax-calls-to-finish-in-cucumber/
# brilliant.
def wait_for_ajax(timeout = Capybara.default_wait_time)
  page.wait_until(timeout) do
    page.evaluate_script 'jQuery.active == 0'
  end
end

# http://artsy.github.com/blog/2012/02/03/reliably-testing-asynchronous-ui-w-slash-rspec-and-capybara/
def wait_for_dom(timeout = Capybara.default_wait_time)
  uuid = SecureRandom.uuid
  page.find("body")
  page.evaluate_script <<-EOS
    _.defer(function() {
      $('body').append("<div id='#{uuid}'></div>");
    });
  EOS
  page.find("##{uuid}")
end

# see: https://github.com/aivaturi/Selenium-Remote-Driver/issues/28
def fill_in_token_input(id, value)
  field = page.find_by_id(id).native
  field.send_keys value
  sleep 2
  field.send_keys "\t\n"
  sleep 2
end
