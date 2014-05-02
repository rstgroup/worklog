module TimeFormattable
  extend ActiveSupport::Concern

  def present_as_time(duration)
    minutes = duration % 60
    hours = (duration / 60).floor.to_i
    hours = "0#{hours}" if hours < 10
    minutes = "0#{minutes}" if minutes < 10
    "#{hours}:#{minutes}"
  end
end