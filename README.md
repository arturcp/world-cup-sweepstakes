# World Cup Sweepstakes

Do you want to bet with your friends to find out who knows more about soccer?
This website is the right tool for you. Create a tournament and try to guess
the games' results before they happen.

# Set up

To prepare the database:

```
  bin/rake db:create db:migrate
```

To populate database with the 2018 world cup data:

```
  bin/rake create_world_cup_2018
```

If you need users to test the website, you can run:

```
  bin/rake db:seed
```


# To test with a different time zone

Go to the terminal and run:

```
  bin/chrome_with_timezone
```

If you want to try another timezone rather than `America/Los_Angeles`, edit the
script file and change the line 26. [Here is a list of valid timezones](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones)
