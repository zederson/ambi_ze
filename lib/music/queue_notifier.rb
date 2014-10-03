class Music::QueueNotifier < Music::BaseNotifier

  def initialize
    @name = :resque
  end

  def notify_change?
    true
  end

  def execute(music)
    begin
      Resque.enqueue(Music::Processor, music.source)
    rescue => e
      Rails.logger.error("Erro ao enqueuar a musica - #{e}")
    end
    true
  end
end
