class RemoveWordFromGame < ActiveRecord::Migration
  def change
    remove_column :games, :word, :string
  end
end
