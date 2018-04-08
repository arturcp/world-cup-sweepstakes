# frozen_string_literal: true

module Rules
  class Base
    attr_reader :guess

    def initialize(guess)
      @guess = guess
    end

    def calculate
      0
    end
  end
end
