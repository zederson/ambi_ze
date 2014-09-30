class Music::Listener
  include Singleton
  include Music::RepeaterControl

  attr_reader :notifiers

  def initialize
    @notifiers = []
    add_notifier(Music::QueueNotifier.new)
  end

  def start
    raise "Notifiers not available" unless notifiers.present?

    LongPolling.start do |s|
      radio = ::RadioBuilder.build
      notifiers.each {|n| n.execute radio } if radio and change_track!(radio.source)
    end
  end

  def stop
    LongPolling.stop
  end

  def add_notifier(notifier)
    @notifiers << notifier if valid_notifier?(notifier)
  end

  def valid_notifier?(notifier)
    !notifiers.any? { |n| n.name == notifier.name }
  end
end
