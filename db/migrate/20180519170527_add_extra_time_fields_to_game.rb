class AddExtraTimeFieldsToGame < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :extra_time_host_score, :integer
    add_column :games, :extra_time_visitor_score, :integer
  end
end
