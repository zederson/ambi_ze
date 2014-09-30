require 'resque/tasks'

task "resque:setup" => :environment

# bundle exec rake resque:work QUEUE='*'
