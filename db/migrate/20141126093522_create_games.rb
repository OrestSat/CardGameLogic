class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :state
      t.integer :attacker
      t.integer :defender

      t.timestamps
    end
  end
end