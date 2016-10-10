#!/user/bin/env ruby

require 'date'

class LoLRateLimitValidator
  def initialize
    @requests_timestamp = []
    @requests_rate_limit = 10
    @log = GLogger.new(LoLRateLimitValidator)
  end

  def register_request
    timestamp = get_now_in_seconds()
    @requests_timestamp << timestamp
  end
 
  def should_send_request
    return @requests_timestamp.size < @requests_rate_limit
  end

  def wait_until_rate_limit_permits
    requests_interval = @requests_timestamp.last - @requests_timestamp.first
    
    if requests_interval < 1.0
      period = 1.0 - requests_interval 
      
      @log.warn('Process will sleep ' + period.to_s + ' seconds to restore rate limit')
      
      sleep(period)
    end
    
    erase_requests_timestamp()
  end

  # Private
 
  private def get_now_in_seconds
    return DateTime.now.to_time.to_f
  end

  private def erase_requests_timestamp
    @requests_timestamp = []
  end
end

