class AddScoresToGame < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :host_score, :integer
    add_column :games, :visitor_score, :integer
  end
end
