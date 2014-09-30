class Music::Listener
  include Singleton
  include Music::RepeaterControl

  def initialize
    @notifiers = []
  end

  def add_notifier(notifier)
    @notifiers << notifier
  end

  def start
    LongPolling.start do |s|
      radio = ::RadioBuilder.build

      if radio
        notifiers.each {|n| n.execute radio } if change_track!(radio.source)
      end
    end
  end

  def notifiers
    @notifiers
  end
end
