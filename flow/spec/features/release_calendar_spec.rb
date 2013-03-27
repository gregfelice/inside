require 'spec_helper'
# require 'rest_client'
require 'JSON'
require 'date'

require 'httparty'

require "net/https"
require "uri"

feature "Release Calendar View" do

  scenario "i can retrieve JIRA release issue types", :js => false, :focus => false do
    releases = ReleaseCalendarRestClient.get_releases
  end

end
