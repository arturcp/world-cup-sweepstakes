class CreateTournament < ActiveRecord::Migration[5.1]
  def change
    create_table :tournaments do |t|
      t.references :user
      t.string :name
      t.string :logo
    end
  end
end
