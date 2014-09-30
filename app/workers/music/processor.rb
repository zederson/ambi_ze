class Music::Processor
  @queue = :music

  def self.perform(music)
    TypeAction.all.each do |type|
      return true if find(music[type.id], type.id)
    end
  end

  def self.find(name, type)
    action = ActionColor.find_by_type(name, type).last
    enqueue(action.colors) and return true if action
    false
  end

  def self.enqueue(colors)
    begin
      Resque.enqueue(Colors::Processor, colors.map{|c| c.id} )
    rescue => e
      Rails.logger.error("Erro ao enqueuar a cor - #{e}")
    end
  end
end
