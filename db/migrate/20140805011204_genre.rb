class Genre < ActiveRecord::Migration
  def change
    create_table :genres do |t|
      t.string :name
      t.string :color

      t.timestamps
    end
  end
end
