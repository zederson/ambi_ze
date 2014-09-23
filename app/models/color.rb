class Color < ActiveRecord::Base

  belongs_to :action_color

  validates_presence_of     :code_hex, :code_xy
  validates_numericality_of :saturation, :brightness, :saturation, :brightness

  scope :recents, -> {order('updated_at desc')}

  def color_screen
    result = code_hex
    result = "#" + result unless /^#/ =~ result
    result
  end

end
