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


  def to_source
    hash            = Hash.new
    hash[:on]       = on
    return hash unless on

    hash[:xy]       = code_xy.split(",").map(&:to_f) unless code_xy.blank?
    hash[:sat]      = saturation if saturation > 0
    hash[:bri]      = brightness if brightness > 0

    hash[:alert]    = 'none'
    hash[:effect]   = 'none'

    if alert
      hash[:alert]  = 'lselect'
      hash[:effect] = 'colorloop'
      hash[:on]       = true
    end

    hash
  end

end
