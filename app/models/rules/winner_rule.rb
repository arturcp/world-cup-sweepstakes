# frozen_string_literal: true

module Rules
  class WinnerRule < Base
    def calculate
      return 1 if game_result(guess.game) == game_result(guess)

      0
    end

    def reason
      :winner
    end

    private

    def game_result(game)
      if game.host_score > game.visitor_score
        :host_won
      elsif game.host_score < game.visitor_score
        :visitor_won
      else
        :draw
      end
    end
  end
end
