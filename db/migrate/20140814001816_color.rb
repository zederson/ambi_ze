class Color < ActiveRecord::Migration

  def change
    create_table :colors do |t|

      t.integer :lamp_id
      t.string  :lamp_name
      t.string  :code_hex
      t.string  :code_xy
      t.integer :saturation
      t.integer :brightness
      t.boolean :on, default: true
      t.boolean :alert, default: false

      t.belongs_to :action_color

      t.timestamps
    end
  end
end
