module Rebot
  def perform_check
  end

  module_function(*%i[perform_check])
end

Rebot.perform_check
