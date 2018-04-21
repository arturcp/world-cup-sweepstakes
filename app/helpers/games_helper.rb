module GamesHelper
  # Public: Decides if the match will be represented by the `Game` instance or
  # by the `UserGuess` instance. If the logged user is administrator of the
  # tournament, the Game will work: it contains the final scores of the game. On
  # the other hand, if the logged user is a regular player, the values must be
  # read from the UserGuess, displaying the user's guess of each game.
  #
  # Parameters:
  #
  #   - user: the logged user
  #   - game: the current game
  #   - user_guesses: the list of guesses of the current_user
  #
  # Returns either a Game instance (if the user is admin) or an UserGuess
  # instance. In the last case, the UserGuess instance will respond to the same
  # methods as the Game.
  def current_match(user, game, user_guesses)
    if user.tournament_admin?(game.tournament)
      game
    else
      user_guess = user_guesses.find do |guess|
        guess.game_id == game.id && guess.user_id == user.id
      end

      user_guess || game.clone
    end
  end
end
