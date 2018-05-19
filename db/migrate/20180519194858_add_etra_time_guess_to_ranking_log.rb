class AddEtraTimeGuessToRankingLog < ActiveRecord::Migration[5.1]
  def change
    add_column :ranking_logs, :extra_time_guess, :string
  end
end
