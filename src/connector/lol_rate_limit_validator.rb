#!/user/bin/env ruby

require 'date'

class LoLRateLimitValidator
  def initialize
    @requests_timestamp = []
    @requests_rate_limit = 10
    #@log = GLogger.new(LoLRateLimitValidator)
  end

  def register_request
    timestamp = get_now_in_milliseconds()
    @requests_timestamp << timestamp
  end
 
  def should_send_request
    return @requests_timestamp.size < @requests_rate_limit
  end

  # Private
 
  private def get_now_in_milliseconds
    return DateTime.now.to_time.to_i
  end
end

