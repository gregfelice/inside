require 'restclient'
require 'restclient/components'
require 'rack/cache'
require 'JSON'

module ReleaseCalendarRestHelper

class ReleaseCalendarRestHelper

  def get_releases
    # RestClient.enable Rack::Cache, :metastore => 'file:/tmp/cache/meta', :entitystore => 'file:/tmp/cache/body'
    # resource = RestClient::Resource.new('http://some/cacheable/resource')
    resource =  RestClient::Resource.new 'https://jira.em.nytimes.com:443/rest/api/latest/search/', 'greg.felice', 'scene24'
    jql = "project = ZR AND issuetype = Release AND status != closed ORDER BY CREATED ASC"
    fields = "summary", "status", "customfield_10122"
    begin
      response = resource.get(:content_type => :json, :jql => jql, :fields => fields)
      releases = []
      nodes = JSON.parse(response)
      nodes['issues'].each {|n|
        releases << { :key => n['key'],  :release_date => n['fields']['customfield_10122'], :status => n['fields']['status']['name'], :summary => n['fields']['summary'] }
      }
      releases
    rescue => e
      logger.fatal e.response
      nil
    end
  end

end

end
