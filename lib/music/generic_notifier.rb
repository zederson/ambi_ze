class Music::GenericNotifier

  def initialize(l = nil)
    @command = l
  end

  def execute(music)
    @command.call(music)
  end
end
