class AddTournamentIdToTeam < ActiveRecord::Migration[5.1]
  def change
    add_reference :teams, :tournament, foreign_key: true
  end
end
