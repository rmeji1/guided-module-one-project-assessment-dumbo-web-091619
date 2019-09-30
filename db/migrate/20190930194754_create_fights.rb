class CreateFights < ActiveRecord::Migration[5.2]
  def change
    create_table :fights do |t|
      t.string :location
      t.integer :monster_id
      t.integer :choice_id
      t.boolean :fight
    end
  end
end
