# frozen_string_literal: true

class CreateTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.string :flag

      t.timestamps
    end
  end
end
