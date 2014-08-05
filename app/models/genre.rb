class Genre < ActiveRecord::Base

  def color_screen
    result = color
    result = "#" + result unless /^#/ =~ result
    result
  end
end
