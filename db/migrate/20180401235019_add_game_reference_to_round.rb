class AddGameReferenceToRound < ActiveRecord::Migration[5.1]
  def change
    add_reference :games, :round, foreign_key: true
  end
end
