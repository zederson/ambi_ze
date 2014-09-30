class TypeAction

  attr_accessor :name, :id

  def initialize(id, name)
    @id   = id
    @name = name
  end

  def self.find_by_id(id)
    values = get_setting
    result = values.select { |h| h[id] }
    return nil unless result.present?

    TypeAction.new(id, result.first[id])
  end

  def self.all
    @@types ||= load
  end

  def self.load
    values = get_setting
    values.map do |h|
      TypeAction.new(h.keys.first, h[h.keys.first])
    end
  end

  def self.get_setting
    AmbiZe.settings["types_action"]
  end

end
