class Lamp
  include ActiveModel::Model

  attr_accessor :id, :name, :hex, :color

  class << self

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
      lights = Lamp::Client.get_resource("lights")
      lamps  = []

      lights.keys.each do |key|
        lamps << build_lamp(key.to_i, lights[key]["name"])
      end
      lamps
    end
  end
end
