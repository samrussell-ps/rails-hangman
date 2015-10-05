class CreateHangmen < ActiveRecord::Migration
  def change
    create_table :hangmen do |t|
      t.string :word

      t.timestamps null: false
    end
  end
end
