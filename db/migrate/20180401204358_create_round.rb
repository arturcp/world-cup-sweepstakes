class CreateRound < ActiveRecord::Migration[5.1]
  def change
    create_table :rounds do |t|
      t.string :name
      t.references :tournaments
    end
  end
end
