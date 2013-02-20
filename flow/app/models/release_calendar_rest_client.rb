require 'JSON'
require 'date'
require 'rubygems'
require 'httparty'
require "net/https"
require "uri"

# http://www.railstips.org/blog/archives/2008/07/29/it-s-an-httparty-and-everyone-is-invited/
class ReleaseCalendarRestClient
  include HTTParty
  format :json
  default_params :output => 'json'
  base_uri 'jira.em.nytimes.com'
  basic_auth 'greg.felice', 'scene24'

  def self.get_releases
    from_cache = true
    releases = Rails.cache.fetch(:releases, :race_condition_ttl => 30, :expires_in => 5.minutes) do
      from_cache = false
      releases = rebuild_releases
    end
    Rails.logger.info "releases from cache?: #{from_cache}"
    releases
  end

  private

  def self.rebuild_releases
    jql = "project = ZR AND issuetype = Release AND status != closed ORDER BY CREATED ASC"
    fields = ["summary", "status", "customfield_10122"]
    max_results = 300
    data = { 'jql' => jql, 'fields' => fields, 'maxResults' => max_results }
    resource = "/rest/api/latest/search/"
    response = get(resource, :query => data)
    Rails.logger.info response.code
    Rails.logger.info response.headers.inspect
    Rails.logger.info response.body.class.name
    releases = []
    nodes = JSON.parse(response.body)
    nodes['issues'].each {|n|
      releases << {
        'key' => n['key'],
        'release_date' => Date.parse(n['fields']['customfield_10122']),
        'status' => n['fields']['status']['name'],
        'summary' => n['fields']['summary']
      } if !(n['fields']['customfield_10122']).nil?
    }
    Rails.logger.info "releases size: #{releases.size}"
    releases
  end

end
