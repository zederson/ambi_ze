class Radio::Spotify < Radio::Base

  def application_name
    "Spotify"
  end

  def rating
    execute_current "popularity"
  end

  def genre
    "NOT_IMPLEMENTED"
  end

end
