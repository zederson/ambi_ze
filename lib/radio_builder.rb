class RadioBuilder

  APPLICATIONS= %w(Itunes Spotify)

  def self.build

    APPLICATIONS.each do |app|
      radio = "Radio::#{app}".constantize.new
      return radio if radio.playing?
    end
    nil
  end
end
