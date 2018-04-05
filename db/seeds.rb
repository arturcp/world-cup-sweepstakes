# Flags from https://github.com/lipis/flag-icon-css

puts 'Creating users...'
john = User.create!(email: 'john.doe@youse.com.br', name: 'John', password: '12345678', confirmed_at: Time.now)
jane = User.create!(email: 'jane.roe@youse.com.br', name: 'John', password: '12345678', confirmed_at: Time.now)
