module Scouter
  class Twitter < Scouter::Base::ParallelApi
    END_POINT = 'http://urls.api.twitter.com'.freeze

    private

    # Build Twitter API URL
    # @param [Array] url
    # @return [Array] API url
    def self.api_url(url)
      urls = url.map{ |u|
        escaped_url = URI.escape(u)
        "#{END_POINT}/1/urls/count.json?url=#{escaped_url}"
      }
      puts urls
      urls
    end

    # Parse JSON data of response
    # @param [String] response
    # @return [Hash] url & count
    def self.parse_response(response)
      parse_response_item(response)
    end

    # Parse JSON list data of response
    # @param [Array] response
    # @return [Hash] url & count
    def self.parse_response_item(response)
      results = {}
      response.each do |url, json|
        url = url.gsub("#{END_POINT}/1/urls/count.json?url=","")
        res = JSON.parse(json)
        results[url] = { self.service_name => res['count'] }
      end
      results
    end

  end
end
