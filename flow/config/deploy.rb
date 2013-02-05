
set :application, "gregfelice.com"
set :repository, "git@vostok.constantlabs.com:/opt/git/flow.git"

set :scm, :git

role :web, "gregfelice.com"

set :user, 'gregfeli'
set :user_sudo, false

# "/home3/gregfeli/flow"

task :hello_you do 
  run "ls"
end

# http://www.jayway.com/2012/01/10/remote-builds-with-capistrano/
task :hello_again do 
  run "ls > ~/hello_again"
end

task :hello_world do

  host = "gregfelice.com"
  user = "gregfeli"
  password = "_Kn1ves0ut"

  # this works.
  Net::SSH.start( host, user, password: password ) do |ssh|
    ssh.open_channel do |channel|
      channel.exec("ls > ~/foooo")
    end
  end
end
