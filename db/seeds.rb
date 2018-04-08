puts 'Creating users...'
john = User.create!(email: 'john.doe@youse.com.br', name: 'John', password: '123123', confirmed_at: Time.now)
jane = User.create!(email: 'jane.roe@youse.com.br', name: 'John', password: '123123', confirmed_at: Time.now)
