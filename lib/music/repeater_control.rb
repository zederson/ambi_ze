module Music::RepeaterControl

  @current_tracker = nil

  def new_music?(music)
    return false unless music
    current_tracker != music
  end

  def current_tracker
    @current_tracker
  end

  def change_track!(music)
    if new_music?(music)
      @current_tracker = music
      return true
    end

    false
  end
end
