require "bundler/setup"
require "rubygems"

require_relative "lib/rebot"

namespace :rebot do
  task :your_weekly_task do
    if Time.now.monday?
      Rebot.perform_check
    end
  end
end
