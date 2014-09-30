class RadioController < WebsocketRails::BaseController

  def index

    notifier = Music::GenericNotifier.new( lambda{ |music|
      send_message :message_success, music.source, :namespace => :radio if music
    } )

    lister = Music::Listener.instance

    lister.add_notifier(notifier)
    lister.start


    # LongPolling.start do |s|
    #   radio = ::RadioBuilder.build
    #   if radio
    #     enqueue(radio)
    #     send_message :message_success, radio.source, :namespace => :radio
    #   else
    #     send_message :message_fail, "No Music", :namespace => :radio
    #   end
    # end
  end

  def stop
    LongPolling.stop
  end

  def enqueue(radio)
    Music::Enqueuer.enqueue radio.source
  end
end
