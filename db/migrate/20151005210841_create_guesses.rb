class CreateGuesses < ActiveRecord::Migration
  def change
    create_table :guesses do |t|
      t.string :letter
      t.integer :hangman_id

      t.timestamps null: false
    end
  end
end
