module Lamp::Client

  class << self

    def mode
      AmbiZe.settings["lamp"]["mode"]
    end

    def endpoint
      AmbiZe.settings["lamp"]["endpoint"]
    end

    def headers
      {
        "Accept"         => "application/json",
        "Content-Type"   => "application/json"
      }
    end

    def put(id, source)
      uri    = "#{endpoint}lights/#{id}/state"

      Rails.logger.info "put http to: #{uri}"
      response = HTTPClient.put(uri, source, headers)
      return {} unless response

      response = JSON.parse(response.content)
      Rails.logger.info "response: #{response}"
      return response
    end

    def get_resource(uri)
      url      = "#{endpoint}#{uri}"
      response = http_client_get url
      return {} unless response

      JSON.parse(response)
    end

    def http_client_get(url)
      begin
        http   = HTTPClient.new
        result = http.get_content(url)
        Rails.logger.debug "get http from url: #{url}"
        result
      rescue
        Rails.logger.error "can't be get http from url: #{url}"
        nil
      end
    end
  end
end
