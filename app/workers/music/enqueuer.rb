class Music::Enqueuer
  include Music::RepeaterControl

 #  @current_tracker = nil

 #  class << self

 #    def enqueue(music)
 #      if new_music?(music)
 #        @current_tracker = music
 #        send_resqueue current_tracker
 #      end
 #    end

 #    def new_music?(music)
 #      current_tracker != music
 #    end

 #    def send_resqueue(music)
 #      begin
 #        Resque.enqueue(Music::Processor, music)
 #      rescue => e
 #        Rails.logger.error("Erro ao enqueuar a musica - #{e}")
 #      end
 #    end

 #    def current_tracker
 #      @current_tracker
 #    end
 #  end
end
