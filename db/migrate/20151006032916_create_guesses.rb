class CreateGuesses < ActiveRecord::Migration
  def change
    create_table :guesses do |t|

      t.timestamps null: false
    end

    add_foreign_key :guesses, :games
  end
end
