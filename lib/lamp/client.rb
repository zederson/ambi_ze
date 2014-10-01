module Lamp::Client

  class << self

    def mode
      AmbiZe.settings["lamp"]["mode"]
    end

    def endpoint
      AmbiZe.settings["lamp"]["endpoint"]
    end

    def get_resource(uri)
      url      = "#{endpoint}#{uri}"
      response = http_client_get url
      return {} unless response

      response = JSON.parse(response)
      return response
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
