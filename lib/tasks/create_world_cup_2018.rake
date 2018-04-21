desc 'Create a tournament with the world cup 2018 data'
task create_world_cup_2018: :environment do
  # source: https://www.google.com.br/search?ei=va7CWp65BIKgwATQkpqQAQ&q=tablea+jogos+copa+do+mundo&oq=tablea+jogos+copa+do+mundo&gs_l=psy-ab.3...9009.9593.0.9633.7.5.0.0.0.0.0.0..0.0....0...1.1.64.psy-ab..7.0.0....0.KJJ1cIMhIBE#sie=lg;/m/06qjc4;2;/m/030q7;mt;fp;1

  # User.find_by(email: 'admin@youse.com.br')&.destroy
  User.delete_all
  Game.delete_all
  Round.delete_all
  Team.delete_all
  Tournament.delete_all
  UserGuess.delete_all

  puts 'Creating users...'
  admin = User.create!(email: 'admin@youse.com.br', name: 'Admin', password: ENV['ADMIN_PASSWORD'], confirmed_at: Time.now)

  puts 'Creating tournament'
  world_cup = Tournament.create!(user: admin, name: 'World Cup 2018', logo: 'http://www.freelogovectors.net/wp-content/uploads/2015/08/2018_FIFA_World_Cup_Logo.png')

  puts 'Creating teams...'
  russia = Team.create!(name: 'Russia', flag: 'https://ssl.gstatic.com/onebox/media/sports/logos/5Y6kOqiOIv2C1sP9C_BWtA_48x48.png', tournament: world_cup)
  saudi_arabia = Team.create!(name: 'Saudi Arabia', flag: 'https://ssl.gstatic.com/onebox/media/sports/logos/QoAJxO46fHid3_T-7nRZ0Q_48x48.png', tournament: world_cup)
  egypt = Team.create!(name: 'Egypt', flag: 'https://ssl.gstatic.com/onebox/media/sports/logos/lYah1Uqw37XdicC6C4HNqg_48x48.png', tournament: world_cup)
  uruguay = Team.create!(name: 'Uruguay', flag: 'https://ssl.gstatic.com/onebox/media/sports/logos/KnSUdQWiGRoy89q4x85IgA_48x48.png', tournament: world_cup)

  morocco = Team.create!(name: 'Morroco', flag: 'https://ssl.gstatic.com/onebox/media/sports/logos/I3gt2Ew39ux3GGdZ-4JE3g_48x48.png', tournament: world_cup)
  iran = Team.create!(name: 'Iran', flag: 'https://ssl.gstatic.com/onebox/media/sports/logos/1oq8Fy7ETpBpZNaCA22ArQ_48x48.png', tournament: world_cup)
  portugal = Team.create!(name: 'Portugal', flag: 'https://ssl.gstatic.com/onebox/media/sports/logos/HJ3_2c4w791nZJj7n-Lj3Q_48x48.png', tournament: world_cup)
  spain = Team.create!(name: 'Spain', flag: 'https://ssl.gstatic.com/onebox/media/sports/logos/5hLkf7KFHhmpaiOJQv8LmA_48x48.png', tournament: world_cup)

  france = Team.create!(name: 'France', flag: 'https://ssl.gstatic.com/onebox/media/sports/logos/z3JEQB3coEAGLCJBEUzQ2A_48x48.png', tournament: world_cup)
  australia = Team.create!(name: 'Australia', flag: 'https://ssl.gstatic.com/onebox/media/sports/logos/jSgw5z0EPOLzdUi-Aomq7Q_48x48.png', tournament: world_cup)
  argentina = Team.create!(name: 'Argentina', flag: 'https://ssl.gstatic.com/onebox/media/sports/logos/1xBWyjjkA6vEWopPK3lIPA_48x48.png', tournament: world_cup)
  iceland = Team.create!(name: 'Iceland', flag: 'https://ssl.gstatic.com/onebox/media/sports/logos/QSlAlD9v6Fm_drC_2z1u8A_48x48.png', tournament: world_cup)

  peru = Team.create!(name: 'Peru', flag: 'https://ssl.gstatic.com/onebox/media/sports/logos/U08wYdQptUaWuweG82L3dw_48x48.png', tournament: world_cup)
  denmark = Team.create!(name: 'Denmark', flag: 'https://ssl.gstatic.com/onebox/media/sports/logos/LaOvu-pyRqRso6uzff55XA_48x48.png', tournament: world_cup)
  croatia = Team.create!(name: 'Croatia', flag: 'https://ssl.gstatic.com/onebox/media/sports/logos/9toerdOg8xW4CRhDaZxsyw_48x48.png', tournament: world_cup)
  nigeria = Team.create!(name: 'Nigeria', flag: 'https://ssl.gstatic.com/onebox/media/sports/logos/2vpR8clrEZdpNjaiHKpg7A_48x48.png', tournament: world_cup)

  costa_rica = Team.create!(name: 'Costa Rica', flag: 'https://ssl.gstatic.com/onebox/media/sports/logos/ixZiM5pj2IvvYc15k-zfeQ_48x48.png', tournament: world_cup)
  serbia = Team.create!(name: 'Serbia', flag: 'https://ssl.gstatic.com/onebox/media/sports/logos/xyh1vmZ-xJH2iJCKjqS1Ow_48x48.png', tournament: world_cup)
  germany = Team.create!(name: 'Germany', flag: 'https://ssl.gstatic.com/onebox/media/sports/logos/h1FhPLmDg9AHXzhygqvVPg_48x48.png', tournament: world_cup)
  mexico = Team.create!(name: 'Mexico', flag: 'https://ssl.gstatic.com/onebox/media/sports/logos/yJF9xqmUGenD8108FJbg9A_48x48.png', tournament: world_cup)

  brazil = Team.create!(name: 'Brazil', flag: 'https://ssl.gstatic.com/onebox/media/sports/logos/zKLzoJVYz0bb6oAnPUdwWQ_48x48.png', tournament: world_cup)
  switzerland = Team.create!(name: 'Switzerland', flag: 'https://ssl.gstatic.com/onebox/media/sports/logos/1hy9ek4dOIffYULM6k1fqg_48x48.png', tournament: world_cup)
  sweden = Team.create!(name: 'Sweden', flag: 'https://ssl.gstatic.com/onebox/media/sports/logos/OkFlRvRsKMWb8Hk20L9Trw_48x48.png', tournament: world_cup)
  south_korea = Team.create!(name: 'South Coreia', flag: 'https://ssl.gstatic.com/onebox/media/sports/logos/Uu5pwNmMHGd5bCooKrS3Lw_48x48.png', tournament: world_cup)

  belgium = Team.create!(name: 'Belgium', flag: 'https://ssl.gstatic.com/onebox/media/sports/logos/6SF7yEoB60bU5knw-M7R5Q_48x48.png', tournament: world_cup)
  panama = Team.create!(name: 'Panama', flag: 'https://ssl.gstatic.com/onebox/media/sports/logos/JIn8OwxL6KFFiYrKGnL2RQ_48x48.png', tournament: world_cup)
  tunisia = Team.create!(name: 'Tunisia', flag: 'https://ssl.gstatic.com/onebox/media/sports/logos/Xs33c9XVUJBX0IkeFn_bIw_48x48.png', tournament: world_cup)
  england = Team.create!(name: 'England', flag: 'https://ssl.gstatic.com/onebox/media/sports/logos/DTqIL8Ba3KIuxGkpXw5ayA_48x48.png', tournament: world_cup)

  colombia = Team.create!(name: 'Colombia', flag: 'https://ssl.gstatic.com/onebox/media/sports/logos/tXHnA_tDylayacdjWQCJvw_48x48.png', tournament: world_cup)
  japan = Team.create!(name: 'Japan', flag: 'https://ssl.gstatic.com/onebox/media/sports/logos/by4OltvtZz7taxuQtkiP3A_48x48.png', tournament: world_cup)
  poland = Team.create!(name: 'Poland', flag: 'https://ssl.gstatic.com/onebox/media/sports/logos/yTS_Piy3M1wUBnqU0n5aAw_48x48.png', tournament: world_cup)
  senegal = Team.create!(name: 'Senegal', flag: 'https://ssl.gstatic.com/onebox/media/sports/logos/zw3ac5sIbH4DS6zP5auOkQ_48x48.png', tournament: world_cup)

  puts 'Creating rounds'
  first_round = Round.create!(tournament: world_cup, name: '1st round')
  second_round = Round.create!(tournament: world_cup, name: '2nd round')
  third_round = Round.create!(tournament: world_cup, name: '3rd round')
  round_of_16 = Round.create!(tournament: world_cup, name: 'Round of 16')
  quarter_finals = Round.create!(tournament: world_cup, name: 'Quarter finals')
  semi_finals = Round.create!(tournament: world_cup, name: 'Semi finals')
  play_off_third_place = Round.create!(tournament: world_cup, name: 'Play-off for third place')
  final = Round.create!(tournament: world_cup, name: 'Final')

  puts 'Creating games'
  puts '1st round...'
  Game.create!(round: first_round, host: russia, visitor: saudi_arabia, allows_tie: true, date: DateTime.parse('2018-06-14 15:00:00'), place: 'Olimpiyskiy Stadion Luzhniki')
  Game.create!(round: first_round, host: egypt, visitor: uruguay, allows_tie: true, date: DateTime.parse('2018-06-15 12:00:00'), place: 'Central Stadium')
  Game.create!(round: first_round, host: morocco, visitor: iran, allows_tie: true, date: DateTime.parse('2018-06-15 15:00:00'), place: 'Krestovsky Stadium')
  Game.create!(round: first_round, host: portugal, visitor: spain, allows_tie: true, date: DateTime.parse('2018-06-15 18:00:00'), place: 'Fisht Olympic Stadium')
  Game.create!(round: first_round, host: france, visitor: australia, allows_tie: true, date: DateTime.parse('2018-06-16 10:00:00'), place: 'Kazan Arena')
  Game.create!(round: first_round, host: argentina, visitor: iceland, allows_tie: true, date: DateTime.parse('2018-06-16 13:00:00'), place: 'Otkrytie Arena')
  Game.create!(round: first_round, host: peru, visitor: denmark, allows_tie: true, date: DateTime.parse('2018-06-16 16:00:00'), place: 'Mordovia Arena')
  Game.create!(round: first_round, host: croatia, visitor: nigeria, allows_tie: true, date: DateTime.parse('2018-06-16 19:00:00'), place: 'Kaliningrad Stadium')
  Game.create!(round: first_round, host: costa_rica, visitor: serbia, allows_tie: true, date: DateTime.parse('2018-06-17 12:00:00'), place: 'Samara Stadium')
  Game.create!(round: first_round, host: germany, visitor: mexico, allows_tie: true, date: DateTime.parse('2018-06-17 15:00:00'), place: 'Olimpiyskiy Stadion Luzhniki')
  Game.create!(round: first_round, host: brazil, visitor: switzerland, allows_tie: true, date: DateTime.parse('2018-06-17 18:00:00'), place: 'Rostov Arena')
  Game.create!(round: first_round, host: sweden, visitor: south_korea, allows_tie: true, date: DateTime.parse('2018-06-18 12:00:00'), place: 'Níjni Novgorod Stadium')
  Game.create!(round: first_round, host: belgium, visitor: panama, allows_tie: true, date: DateTime.parse('2018-06-18 15:00:00'), place: 'Fisht Olympic Stadium')
  Game.create!(round: first_round, host: tunisia, visitor: england, allows_tie: true, date: DateTime.parse('2018-06-18 18:00:00'), place: 'Volgogrado Arena')
  Game.create!(round: first_round, host: colombia, visitor: japan, allows_tie: true, date: DateTime.parse('2018-06-19 12:00:00'), place: 'Mordovia Arena')
  Game.create!(round: first_round, host: poland, visitor: senegal, allows_tie: true, date: DateTime.parse('2018-06-19 15:00:00'), place: 'Otkrytie Arena')

  puts '2nd round...'
  Game.create!(round: second_round, host: russia, visitor: egypt, allows_tie: true, date: DateTime.parse('2018-06-19 18:00:00'), place: 'Krestovsky Stadium')
  Game.create!(round: second_round, host: portugal, visitor: morocco, allows_tie: true, date: DateTime.parse('2018-06-20 12:00:00'), place: 'Olimpiyskiy Stadion Luzhniki')
  Game.create!(round: second_round, host: uruguay, visitor: saudi_arabia, allows_tie: true, date: DateTime.parse('2018-06-20 15:00:00'), place: 'Rostov Arena')
  Game.create!(round: second_round, host: iran, visitor: spain, allows_tie: true, date: DateTime.parse('2018-06-20 18:00:00'), place: 'Kazan Arena')
  Game.create!(round: second_round, host: denmark, visitor: australia, allows_tie: true, date: DateTime.parse('2018-06-21 12:00:00'), place: 'Samara Stadium')
  Game.create!(round: second_round, host: france, visitor: peru, allows_tie: true, date: DateTime.parse('2018-06-21 15:00:00'), place: 'Central Stadium')
  Game.create!(round: second_round, host: argentina, visitor: croatia, allows_tie: true, date: DateTime.parse('2018-06-21 18:00:00'), place: 'Níjni Novgorod Stadium')
  Game.create!(round: second_round, host: brazil, visitor: costa_rica, allows_tie: true, date: DateTime.parse('2018-06-22 12:00:00'), place: 'Krestovsky Stadium')
  Game.create!(round: second_round, host: nigeria, visitor: iceland, allows_tie: true, date: DateTime.parse('2018-06-22 15:00:00'), place: 'Volgogrado Arena')
  Game.create!(round: second_round, host: serbia, visitor: switzerland, allows_tie: true, date: DateTime.parse('2018-06-22 18:00:00'), place: 'Kaliningrad Stadium')
  Game.create!(round: second_round, host: belgium, visitor: tunisia, allows_tie: true, date: DateTime.parse('2018-06-23 12:00:00'), place: 'Otkrytie Arena')
  Game.create!(round: second_round, host: south_korea, visitor: mexico, allows_tie: true, date: DateTime.parse('2018-06-23 15:00:00'), place: 'Rostov Arena')
  Game.create!(round: second_round, host: germany, visitor: sweden, allows_tie: true, date: DateTime.parse('2018-06-23 18:00:00'), place: 'Fisht Olympic Stadium')
  Game.create!(round: second_round, host: england, visitor: panama, allows_tie: true, date: DateTime.parse('2018-06-24 12:00:00'), place: 'Níjni Novgorod Stadium')
  Game.create!(round: second_round, host: japan, visitor: senegal, allows_tie: true, date: DateTime.parse('2018-06-24 15:00:00'), place: 'Central Stadium')
  Game.create!(round: second_round, host: poland, visitor: colombia, allows_tie: true, date: DateTime.parse('2018-06-24 18:00:00'), place: 'Kazan Arena')

  puts '3rd round...'
  Game.create!(round: third_round, host: saudi_arabia, visitor: egypt, allows_tie: true, date: DateTime.parse('2018-06-25 14:00:00'), place: 'Volgogrado Arena')
  Game.create!(round: third_round, host: uruguay, visitor: russia, allows_tie: true, date: DateTime.parse('2018-06-25 14:00:00'), place: 'Samara Stadium')
  Game.create!(round: third_round, host: iran, visitor: portugal, allows_tie: true, date: DateTime.parse('2018-06-25 18:00:00'), place: 'Mordovia Arena')
  Game.create!(round: third_round, host: spain, visitor: morocco, allows_tie: true, date: DateTime.parse('2018-06-25 18:00:00'), place: 'Kaliningrad Stadium')
  Game.create!(round: third_round, host: australia, visitor: peru, allows_tie: true, date: DateTime.parse('2018-06-26 14:00:00'), place: 'Fisht Olympic Stadium')
  Game.create!(round: third_round, host: denmark, visitor: france, allows_tie: true, date: DateTime.parse('2018-06-26 14:00:00'), place: 'Olimpiyskiy Stadion Luzhniki')
  Game.create!(round: third_round, host: nigeria, visitor: argentina, allows_tie: true, date: DateTime.parse('2018-06-26 18:00:00'), place: 'Krestovsky Stadium')
  Game.create!(round: third_round, host: iceland, visitor: croatia, allows_tie: true, date: DateTime.parse('2018-06-26 18:00:00'), place: 'Rostov Arena')
  Game.create!(round: third_round, host: south_korea, visitor: germany, allows_tie: true, date: DateTime.parse('2018-06-27 14:00:00'), place: 'Kazan Arena')
  Game.create!(round: third_round, host: mexico, visitor: sweden, allows_tie: true, date: DateTime.parse('2018-06-27 14:00:00'), place: 'Central Stadium')
  Game.create!(round: third_round, host: switzerland, visitor: costa_rica, allows_tie: true, date: DateTime.parse('2018-06-27 18:00:00'), place: 'Níjni Novgorod Stadium')
  Game.create!(round: third_round, host: serbia, visitor: brazil, allows_tie: true, date: DateTime.parse('2018-06-27 18:00:00'), place: 'Otkrytie Arena')
  Game.create!(round: third_round, host: senegal, visitor: colombia, allows_tie: true, date: DateTime.parse('2018-06-28 14:00:00'), place: 'Samara Stadium')
  Game.create!(round: third_round, host: japan, visitor: poland, allows_tie: true, date: DateTime.parse('2018-06-28 14:00:00'), place: 'Volgogrado Arena')
  Game.create!(round: third_round, host: england, visitor: belgium, allows_tie: true, date: DateTime.parse('2018-06-28 18:00:00'), place: 'Kaliningrad Stadium')
  Game.create!(round: third_round, host: panama, visitor: tunisia, allows_tie: true, date: DateTime.parse('2018-06-28 18:00:00'), place: 'Mordovia Arena')

  puts 'Round of 16'
  Game.create!(round: round_of_16, host: nil, visitor: nil, allows_tie: false, date: DateTime.parse('2018-06-30 14:00:00'), place: 'Kazan Arena')
  Game.create!(round: round_of_16, host: nil, visitor: nil, allows_tie: false, date: DateTime.parse('2018-06-30 18:00:00'), place: 'Fisht Olympic Stadium')
  Game.create!(round: round_of_16, host: nil, visitor: nil, allows_tie: false, date: DateTime.parse('2018-07-01 14:00:00'), place: 'Olimpiyskiy Stadion Luzhniki')
  Game.create!(round: round_of_16, host: nil, visitor: nil, allows_tie: false, date: DateTime.parse('2018-07-01 18:00:00'), place: 'Níjni Novgorod Stadium')
  Game.create!(round: round_of_16, host: nil, visitor: nil, allows_tie: false, date: DateTime.parse('2018-07-02 14:00:00'), place: 'Samara Stadium')
  Game.create!(round: round_of_16, host: nil, visitor: nil, allows_tie: false, date: DateTime.parse('2018-07-02 18:00:00'), place: 'Rostov Arena')
  Game.create!(round: round_of_16, host: nil, visitor: nil, allows_tie: false, date: DateTime.parse('2018-07-03 14:00:00'), place: 'Krestovsky Stadium')
  Game.create!(round: round_of_16, host: nil, visitor: nil, allows_tie: false, date: DateTime.parse('2018-07-03 18:00:00'), place: 'Otkrytie Arena')

  puts 'Quarter finals'
  Game.create!(round: quarter_finals, host: nil, visitor: nil, allows_tie: false, date: DateTime.parse('2018-07-06 14:00:00'), place: 'Níjni Novgorod Stadium')
  Game.create!(round: quarter_finals, host: nil, visitor: nil, allows_tie: false, date: DateTime.parse('2018-07-06 18:00:00'), place: 'Kazan Arena')
  Game.create!(round: quarter_finals, host: nil, visitor: nil, allows_tie: false, date: DateTime.parse('2018-07-07 14:00:00'), place: 'Samara Stadium')
  Game.create!(round: quarter_finals, host: nil, visitor: nil, allows_tie: false, date: DateTime.parse('2018-07-07 18:00:00'), place: 'Fisht Olympic Stadium')

  puts 'Semi finals'
  Game.create!(round: semi_finals, host: nil, visitor: nil, allows_tie: false, date: DateTime.parse('2018-07-10 18:00:00'), place: 'Krestovsky Stadium')
  Game.create!(round: semi_finals, host: nil, visitor: nil, allows_tie: false, date: DateTime.parse('2018-07-11 18:00:00'), place: 'Olimpiyskiy Stadion Luzhniki')

  puts 'play_off_third_place'
  Game.create!(round: play_off_third_place, host: nil, visitor: nil, allows_tie: false, date: DateTime.parse('2018-07-14 14:00:00'), place: 'Krestovsky Stadium')

  puts 'final'
  Game.create!(round: final, host: nil, visitor: nil, allows_tie: false, date: DateTime.parse('2018-07-15 15:00:00'), place: 'Olimpiyskiy Stadion Luzhniki')
end
