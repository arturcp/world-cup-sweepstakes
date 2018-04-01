# Flags from https://github.com/lipis/flag-icon-css

puts 'Creating users...'
admin = User.create!(email: 'admin@youse.com.br', name: 'Admin', password: '12345678', confirmed_at: Time.now)
john = User.create!(email: 'john.doe@youse.com.br', name: 'John', password: '12345678', confirmed_at: Time.now)
jane = User.create!(email: 'jane.roe@youse.com.br', name: 'John', password: '12345678', confirmed_at: Time.now)

puts 'Creating tournament'
world_cup = Tournament.create!(user: admin, name: 'World Cup 2018', logo: 'http://www.freelogovectors.net/wp-content/uploads/2015/08/2018_FIFA_World_Cup_Logo.png')

puts 'Creating teams...'
brazil = Team.create!(name: 'Brasil', flag: 'https://lipis.github.io/flag-icon-css/flags/4x3/br.svg', tournament: world_cup)
germany = Team.create!(name: 'Germany', flag: 'https://lipis.github.io/flag-icon-css/flags/4x3/de.svg', tournament: world_cup)
russia = Team.create!(name: 'Russia', flag: 'https://lipis.github.io/flag-icon-css/flags/4x3/ru.svg', tournament: world_cup)
portugal = Team.create!(name: 'Portugal', flag: 'https://lipis.github.io/flag-icon-css/flags/4x3/pt.svg', tournament: world_cup)

puts 'Creating rounds'
first_round = Round.create!(tournament: world_cup, name: '1st round')
second_round = Round.create!(tournament: world_cup, name: '2nd round')

puts 'Creating games'
Game.create!(round: first_round, host: brazil, visitor: germany, allows_tie: true, date: 5.days.from_now, place: 'OLÍMPICO LUJNIKI')
Game.create!(round: first_round, host: russia, visitor: portugal, allows_tie: true, date: 5.days.from_now, place: 'ECATERIMBURGO')
