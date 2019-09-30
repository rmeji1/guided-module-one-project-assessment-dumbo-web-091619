class CreateResults < ActiveRecord::Migration[5.2]
  def change
    create_table :results do |t|
      t.boolean :did_win?
    end
  end
end
