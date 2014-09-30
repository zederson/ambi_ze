class ActionColor < ActiveRecord::Migration

  def change
    create_table :action_colors do |t|
      t.string :name
      t.string :description
      t.string :type_action

      t.timestamps
    end
  end
end
