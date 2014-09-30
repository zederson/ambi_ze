class Music::QueueNotifier

  attr_reader :name

  def initialize
    @name = :resque
  end

  def execute(music)
    begin
      Resque.enqueue(Music::Processor, music.source)
    rescue => e
      Rails.logger.error("Erro ao enqueuar a musica - #{e}")
    end
  end
end
