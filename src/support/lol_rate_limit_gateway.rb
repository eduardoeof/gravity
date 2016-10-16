#!/user/bin/env ruby

require 'json'
require 'net/http'

class LoLRateLimitGateway
  def initialize
    @sleep_period = 1.0
    @log = GLogger.new(LoLRateLimitGateway)
  end

  def get(uri)
    @log.warn('Process will sleep ' + @sleep_period.to_s + ' second to restore rate limit')
    
    wait_until_rate_limit_permits()
    
    response = Net::HTTP.get(uri)
    return response
  end

  # Private methods

  private def wait_until_rate_limit_permits
    sleep(@sleep_period)
  end
end

