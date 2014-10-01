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
      notify_with_change.each { |n| n.execute radio } if radio and change_track!(radio.source)
      notify_everyone.each    { |n| n.execute radio } if radio
    end
  end

  def notify_with_change
    notifiers.select { |n| n.notify_change? }
  end

  def notify_everyone
    notifiers.select { |n| !n.notify_change? }
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
