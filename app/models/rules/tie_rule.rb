# frozen_string_literal: true

module Rules
  class TieRule < Base
    SCORE_POINTS = 3

    def calculate
      if guessed_tie?(guess) && guess.game.tie?
        SCORE_POINTS
      else
        0
      end
    end

    def reason
      :draw
    end

    private

    def guessed_tie?(guess)
      guess.host_id.present? && guess.visitor_id.present? &&
        guess.host_score.present? && guess.host_score == guess.visitor_score
    end
  end
end
