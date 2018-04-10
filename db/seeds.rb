puts 'Creating users...'
john = User.create!(email: 'john.doe@youse.com.br', name: 'John Doe', password: '123123', confirmed_at: Time.now)
jane = User.create!(email: 'jane.roe@youse.com.br', name: 'Jane Roe', password: '123123', confirmed_at: Time.now)
richard = User.create!(email: 'richard.roe@youse.com.br', name: 'Richard Roe', password: '123123', confirmed_at: Time.now)

games = Game.all
UserGuess.create!(user: john, game: games[0], host_score: 3, visitor_score: 2)
UserGuess.create!(user: john, game: games[1], host_score: 2, visitor_score: 0)
UserGuess.create!(user: john, game: games[2], host_score: 3, visitor_score: 4)
UserGuess.create!(user: john, game: games[3], host_score: 0, visitor_score: 2)
UserGuess.create!(user: john, game: games[4], host_score: 1, visitor_score: 0)
UserGuess.create!(user: john, game: games[5], host_score: 2, visitor_score: 2)
UserGuess.create!(user: john, game: games[6], host_score: 2, visitor_score: 3)

UserGuess.create!(user: jane, game: games[0], host_score: 4, visitor_score: 2)
UserGuess.create!(user: jane, game: games[1], host_score: 1, visitor_score: 0)
UserGuess.create!(user: jane, game: games[2], host_score: 1, visitor_score: 2)
UserGuess.create!(user: jane, game: games[3], host_score: 0, visitor_score: 3)
UserGuess.create!(user: jane, game: games[4], host_score: 0, visitor_score: 3)
UserGuess.create!(user: jane, game: games[5], host_score: 1, visitor_score: 1)
UserGuess.create!(user: jane, game: games[6], host_score: 2, visitor_score: 4)

UserGuess.create!(user: richard, game: games[0], host_score: 1, visitor_score: 1)
UserGuess.create!(user: richard, game: games[1], host_score: 1, visitor_score: 0)
UserGuess.create!(user: richard, game: games[2], host_score: 1, visitor_score: 1)
UserGuess.create!(user: richard, game: games[3], host_score: 2, visitor_score: 2)
UserGuess.create!(user: richard, game: games[4], host_score: 0, visitor_score: 0)
UserGuess.create!(user: richard, game: games[5], host_score: 1, visitor_score: 1)
UserGuess.create!(user: richard, game: games[6], host_score: 2, visitor_score: 2)
