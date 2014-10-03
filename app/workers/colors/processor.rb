class Colors::Processor
  @queue = :colors

  def self.perform(ids)
    Rails.logger = Logger.new(STDOUT)
    return false if ids.blank?

    ids.each do |id|
      color = Color.find(id)
      Lamp.send(color)
    end

  end
end
