class RadioListener

  def initialize
    @stop = false
  end

  def stop?
    @stop
  end

  def on_track
    EventMachine.run {
      EventMachine.add_periodic_timer(time_loop) {
        EventMachine.stop if stop?

        yield get_current_track
      }
    }
  end

  def time_loop
    2
  end

  def get_current_track
    RadioBuilder.build
  end

end
