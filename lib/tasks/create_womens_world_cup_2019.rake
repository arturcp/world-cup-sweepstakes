desc 'Create a tournament for the women\'s world cup 2019 data'
task create_womens_world_cup_2019: :environment do
  User.delete_all
  Game.delete_all
  Round.delete_all
  Team.delete_all
  Tournament.delete_all
  UserGuess.delete_all

  puts 'Creating users...'
  admin = User.create!(email: 'admin@youse.com.br', name: 'Admin', password: ENV['ADMIN_PASSWORD'], confirmed_at: Time.now)

  puts 'Creating tournament'
  world_cup = Tournament.create!(user: admin, name: 'Women\'s world cup 2019', logo: 'https://upload.wikimedia.org/wikipedia/pt/4/41/2019_FIFA_Women%27s_World_Cup.svg.png')

  puts 'Creating teams...'
  australia = Team.create!(name: 'Australia', flag: 'https://ssl.gstatic.com/onebox/media/sports/logos/jSgw5z0EPOLzdUi-Aomq7Q_48x48.png', tournament: world_cup)
  brazil = Team.create!(name: 'Brazil', flag: 'https://ssl.gstatic.com/onebox/media/sports/logos/zKLzoJVYz0bb6oAnPUdwWQ_48x48.png', tournament: world_cup)
  jamaica = Team.create!(name: 'Jamaica', flag: '//ssl.gstatic.com/onebox/media/sports/logos/4HCKfsNJNHDY-vWSEzLbeQ_48x48.png', tournament: world_cup)
  italy = Team.create!(name: 'Italy', flag: '//ssl.gstatic.com/onebox/media/sports/logos/joYpsiaYi4GDCqhSRAq5Zg_48x48.png', tournament: world_cup)

  puts 'Creating rounds'
  first_round = Round.create!(tournament: world_cup, name: '1st round')

  puts 'Creating games'
  puts '1st round...'
  # Game.create!(round: first_round, host: brazil, visitor: jamaica, allows_tie: true, date: DateTime.parse('2019-06-09 15:00:00'), place: 'Stade des alpes')
  Game.create!(round: first_round, host: brazil, visitor: australia, allows_tie: true, date: DateTime.parse('2019-06-13 13:00:00'), place: 'Stade de la Mosson')
  Game.create!(round: first_round, host: italy, visitor: brazil, allows_tie: true, date: DateTime.parse('2019-06-18 16:00:00'), place: 'Stade du Hainaut')
end
