# frozen_string_literal: true

module Rules
  class ScoreRule < Base
    def calculate
      return 3 if guess.game.score == guess.score

      0
    end

    def reason
      :score
    end
  end
end
