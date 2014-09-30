class ActionColor < ActiveRecord::Base

  has_many :colors

  validates :name ,presence: true, uniqueness: true
  validates :type_action, presence: true

  scope :recents, -> {order('updated_at desc')}

  def lamps
    Lamp.build(self.colors)
  end

  def type
    TypeAction.find_by_id self.type_action
  end

  def type_name
    t = type
    return t.name if t
  end

  class << self

    def find_by_type(name, type)
      ActionColor.includes(:colors).where(name: name, type_action: type)
    end
  end
end
