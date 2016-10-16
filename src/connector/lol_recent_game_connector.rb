#!/user/bin/env ruby

require 'json'
require 'net/http'

class LoLRecentGameConnector
  def initialize
    @gateway = LoLRateLimitGateway.new
    @log = GLogger.new(LoLRecentGameConnector)
  end

  def fetch_games(summoner_id)
    @log.info('Start recent games request of summonerId ' + summoner_id)

    url = create_url(summoner_id)
    uri = URI(url)
    response = @gateway.get(uri)

    @log.info('Recent games request of summonerId ' + summoner_id + ' succeed')

    return parse_response_to_array(response)
  end

  # Private

  private def create_url(summoner_id)
    api_key = 'RGAPI-2BE249D7-0CB3-4685-A4E5-6BE9381FA129'
    return 'https://br.api.pvp.net/api/lol/br/v1.3/game/by-summoner/' + summoner_id + '/recent?api_key=' + api_key
  end
  
  private def convert_to_utf8(response)
    return response.force_encoding("iso-8859-1").encode("utf-8")  
  end

  private def parse_response_to_array(response)
    return JSON.parse(convert_to_utf8(response))['games']
  end
end

