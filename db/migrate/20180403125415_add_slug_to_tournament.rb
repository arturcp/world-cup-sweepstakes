class AddSlugToTournament < ActiveRecord::Migration[5.1]
  def change
    add_column :tournaments, :slug, :string
  end
end
