class AddGameIdToWords < ActiveRecord::Migration
  def change
    add_column :words, :game_id, :integer
  end
end
