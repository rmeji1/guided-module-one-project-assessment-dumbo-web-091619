class CreateCharacters < ActiveRecord::Migration[5.2]
  def change
    create_table :characters do |t|
      t.string :name
      t.integer :user_id
      t.integer :max_health #total hitpoints
      t.string :class_type #Warrior or mage or whatever
      t.integer :strength #How hard each character hits
      t.integer :current_health
    end
  end
end
