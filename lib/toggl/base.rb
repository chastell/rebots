module Toggl
  class Base 
    SEVEN_DAYS_IN_SECONDS = (7*24*60*60).freeze
    WEEK_DAYS = %w[Monday Tuesday Wednesday Thursday Friday Saturday Sunday].freeze

    def start_day
      @start_day ||= WEEK_DAYS.rotate((Time.now - SEVEN_DAYS_IN_SECONDS).wday - 1)
    end
  end
end
