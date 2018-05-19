# frozen_string_literal: true

module Rules
  class ExtraTimeRule < Base
    SCORE_POINTS = 1

    def calculate
      if guess.tie? && guess.game.tie? && right_extra_time_score?
        SCORE_POINTS
      else
        0
      end
    end

    def reason
      :extra_time_score
    end

    private

    def wrong_score?
      guess.game.score != guess.score
    end

    def right_extra_time_score?
      guess.has_extra_time_score? &&
        guess.game.extra_time_score == guess.extra_time_score
    end
  end
end
