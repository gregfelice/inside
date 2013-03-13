require 'spec_helper'
# require 'rest_client'
require 'JSON'
require 'date'

require 'httparty'

require "net/https"
require "uri"

feature "Release Calendar View" do

  scenario "I can do a basic post", :js => false, :focus => true do
    r = ReleaseCalendarRestClient.get_releases
  end

=begin
  scenario "I can do a basic post", :js => false, :focus => true do

    resource =  "https://greg.felice:scene24@jira.em.nytimes.com:443/rest/api/latest/search/"
    jql = "issuetype = Release AND status != closed"
    fields = ["summary", "status", "customfield_10122"]
    max_results = 25

    response = RestClient.post resource, { "jql" => jql, "maxResults" => max_results, "fields" => fields }.to_json, :content_type => "application/json", :accept => "application/json"

    releases = []
    nodes = JSON.parse(response)
    nodes['issues'].each {|n|
      releases << { 'key' => n['key'],  'release_date' => Date.parse(n['fields']['customfield_10122']), 'status' => n['fields']['status']['name'], 'summary' => n['fields']['summary'] } if !(n['fields']['customfield_10122']).nil?
    }
    puts "releases: #{releases.inspect}"

  end
=end

  scenario "i can retrieve JIRA release issue types", :js => false, :focus => false do
    releases = ReleaseCalendarRestClient.get_releases
  end

end
