class Music::GenericNotifier < Music::BaseNotifier

  def initialize(lamb, name, notify_change = false)
    @command       = lamb
    @name          = name
    @notify_change = notify_change
  end

  def notify_change?
    @notify_change
  end

  def execute(music)
    @command.call(music)
  end
end
