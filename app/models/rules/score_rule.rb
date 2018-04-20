# frozen_string_literal: true

module Rules
  class ScoreRule < Base
    SCORE_POINTS = 3

    def calculate
      if guess.game.score == guess.score
        SCORE_POINTS
      else
        0
      end
    end

    def reason
      :score
    end
  end
end
