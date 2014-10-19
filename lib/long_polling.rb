class LongPolling

  @@server = nil

  def self.stop
    server.cancel if server
  end

  def self.start
    return nil unless block_given?

    server.cancel if server

    EM.run do
      self.server = EM.add_periodic_timer(2) {
        yield
      }
    end
  end

  def self.server
    @@server
  end

  def self.server=(polling)
    @@server = polling
  end
end
