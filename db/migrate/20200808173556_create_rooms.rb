class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.string :name
      t.references :category, foreign_key: true
      t.string :description
      t.timestamp :date_and_time
      t.string :url
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
