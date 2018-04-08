class CreateRankingLog < ActiveRecord::Migration[5.1]
  def change
    create_table :ranking_logs do |t|
      t.references :user, foreign_key: true, index: true
      t.references :tournament, foreign_key: true, index: true
      t.references :game, foreign_key: true, index: true
      t.integer :points
      t.string :guess
      t.integer :reason

      t.timestamps
    end
  end
end
