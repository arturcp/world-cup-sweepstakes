class RemoveTournamentsIdFromRounds < ActiveRecord::Migration[5.1]
  def change
    remove_column :rounds, :tournaments_id, :bigint
  end
end
