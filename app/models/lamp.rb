class Lamp
  include ActiveModel::Model

  attr_accessor :id, :name, :hex, :color

  class << self

    def mode
      "LCT001"
    end

    def endpoint
      "http://192.168.1.100/api/edersondelima/"
    end

    def build(colors = [])
      return Lamp.all if !colors.present?
      lamps = []

      colors.each do |color|
        lamps << build_lamp(color.lamp_id, color.lamp_name, color.code_hex, color)
      end
      lamps
    end

    def all
      find_all
    end

    def build_lamp(id, name, hex = "", color = Color.new)
      Lamp.new(id: id, name: name, hex: hex, color: color)
    end

    def find_all
      lights = get_resource("lights")
      lamps  = []

      lights.keys.each do |key|
        lamps << build_lamp(key.to_i, lights[key]["name"])
      end
      lamps
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
