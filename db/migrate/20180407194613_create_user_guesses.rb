class CreateUserGuesses < ActiveRecord::Migration[5.1]
  def change
    create_table :user_guesses do |t|
      t.references :game, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :host_score, default: 0
      t.integer :visitor_score, default: 0
    end
  end
end
