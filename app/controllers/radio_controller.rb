class RadioController < WebsocketRails::BaseController

  def index
      radio = ::RadioBuilder.build

        if radio
          send_message :message_success, radio.source, :namespace => :radio
        else
          send_message :message_fail, "No Music", :namespace => :radio
        end

   #  EventMachine.run {
   #    EventMachine.add_periodic_timer(2) {

   #      radio = ::RadioBuilder.build

   #      if radio
   #        send_message :message_success, radio.source, :namespace => :radio
   #      else
   #        send_message :message_fail, "No Music", :namespace => :radio
   #      end
   #    }
   #  }
  end
end
