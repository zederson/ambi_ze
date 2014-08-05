class Radio::Base

  def application_name
    raise "Not Implementation"
  end

  def playing?
    status = execute "(get player state as string)"
    status == "playing"
  end

  def track
    execute_current "name"
  end

  def album
    execute_current "album"
  end

  def artist
    artist = execute_current "artist"
    artist = execute_current "album artist" if artist.blank?
    artist
  end

  def rating
    execute_current "rating"
  end

  def genre
    execute_current "genre"
  end

  def to_json
    source.to_json
  end

  def source
    hash               = {}
    hash[:application] = application_name
    hash[:track]       = track
    hash[:artist]      = artist
    hash[:album]       = album
    hash[:genre]       = genre
    hash[:rating]      = rating
    hash
  end

  def execute_current(operation)
    execute("#{operation} of current track as string")
  end

  def execute(operation)
    begin
      result = %x[osascript -e 'tell app "#{application_name}" to #{operation} ']
    rescue => e
      log_error "Erro ao acessar o ${application_name} #{e.message}"
      result = ""
    end

    result.gsub(/[\n]*/, '')
  end

  def eq?(music)
    return false unless music

    current = self.source
    last    = music.source
    compare = begin
       current[:application] == last[:application] and
       current[:artist]      == last[:artist] and
       current[:track]       == last[:track]
    end

    compare
  end
end
