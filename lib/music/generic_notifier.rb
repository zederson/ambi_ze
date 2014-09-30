class Music::GenericNotifier

  attr_reader :name

  def initialize(lamb, name)
    @command = lamb
    @name    = name
  end

  def execute(music)
    @command.call(music)
  end
end
