class RadioController < WebsocketRails::BaseController

  def index

    notifier = Music::GenericNotifier.new( lambda{ |music|
      send_message :message_success, music.source, :namespace => :radio if music
    }, :radio_controller )

    listener = Music::Listener.instance

    listener.add_notifier(notifier)
    listener.start
  end

  def stop
    Music::Listener.instance.stop
  end

  def enqueue(radio)
    Music::Enqueuer.enqueue radio.source
  end
end
