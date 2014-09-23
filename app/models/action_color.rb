class ActionColor < ActiveRecord::Base

  has_many :colors
  validates :name ,presence: true, uniqueness: true

  scope :recents, -> {order('updated_at desc')}

  def lamps
    Lamp.build(self.colors)
  end
end
