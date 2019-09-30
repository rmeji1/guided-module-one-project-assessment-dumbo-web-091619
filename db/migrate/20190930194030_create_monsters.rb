class CreateMonsters < ActiveRecord::Migration[5.2]
  def change
    create_table :monsters do |t|
      t.string :name
      t.integer :health
      t.integer :fight_damage #how much damage monster does if you're fighting them
      t.integer :run_damage #how much damage monster does if you run away
    end
  end
end
