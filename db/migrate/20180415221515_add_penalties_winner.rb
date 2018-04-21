class AddPenaltiesWinner < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :penalties_winner_id, :integer
    add_column :user_guesses, :penalties_winner_id, :integer
  end
end
