class Music::BaseNotifier

  attr_reader :name

  def execute(music)
    raise "Notifier not implemented"
  end

  def notify_change?
    false
  end
end
