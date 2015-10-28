class CreateGamesWordsJoinTable < ActiveRecord::Migration
  def change
    create_join_table :games, :words do |t|
      # t.index [:game_id, :word_id]
      # t.index [:word_id, :game_id]
    end
  end
end
