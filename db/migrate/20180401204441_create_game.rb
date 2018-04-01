class CreateGame < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.references :rounds
      t.references :host, foreign_key: { to_table: :teams }
      t.references :visitor, foreign_key: { to_table: :teams }
      t.boolean :allows_tie, default: true
      t.datetime :date
      t.string :place, default: ''
    end
  end
end
