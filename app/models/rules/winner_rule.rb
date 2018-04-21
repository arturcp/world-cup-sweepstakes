# frozen_string_literal: true

module Rules
  class WinnerRule < Base
    SCORE_POINTS = 1

    def calculate
      official_result = game_result(guess)
      if official_result != :draw && game_result(guess.game) == official_result
        SCORE_POINTS
      else
        0
      end
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
