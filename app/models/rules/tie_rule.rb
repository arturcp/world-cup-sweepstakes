# frozen_string_literal: true

module Rules
  class TieRule < Base
    SCORE_POINTS = 1

    def calculate
      if wrong_score? && guess.tie? && guess.game.tie?
        SCORE_POINTS
      else
        0
      end
    end

    def reason
      :draw
    end

    private

    def wrong_score?
      guess.game.score != guess.score
    end
  end
end
