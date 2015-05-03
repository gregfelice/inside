module ReleaseCalendarHelper

  def link_to_release(release)

    label = "#{release['summary']}"
    # label = "#{release['key']}: #{release['summary']}"
    url = "http://jira.xyz.com/browse/#{release['key']}"

    classes = {'Open' => 'upcoming', 'In Development' => 'in-progress', 'Verified In Production' => 'verified-in-production'}
    css_class = classes[release['status']]

    link_to label, url, :class => "verified-in-production", :target => '_blank', :class => css_class

  end

end
