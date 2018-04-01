class RemoveRoundsIdFromGames < ActiveRecord::Migration[5.1]
  def change
    remove_column :games, :rounds_id, :bigint
  end
end
