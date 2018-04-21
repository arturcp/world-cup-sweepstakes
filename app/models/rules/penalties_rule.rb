# frozen_string_literal: true

module Rules
  class PenaltiesRule < Base
    SCORE_POINTS = 1

    def calculate
      return 0 if guess.game.allows_tie? || !guess.game.tie?

      if guess.game.penalties_winner_id == guess.penalties_winner_id
        SCORE_POINTS
      else
        0
      end
    end

    def reason
      :penalties_winner
    end
  end
end
