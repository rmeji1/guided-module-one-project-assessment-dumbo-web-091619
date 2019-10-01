class CreateChoices < ActiveRecord::Migration[5.2]
  def change
    create_table :choices do |t|
      t.integer :character_id
      t.integer :result_id
      t.string :option
      t.string :choice_made
    end
  end
end
