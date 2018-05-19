page.at('games#index', function() {
  var TeamSelection = require('team-selection'),
      ScoreChanges = require('score-changes'),
      Ranking = require('ranking'),
      ExtraTime = require('extra-time');
      Penalties = require('penalties');

  new TeamSelection('.unconfirmed-team');
  new ScoreChanges();
  new Ranking();
  new ExtraTime();
  new Penalties();

  $('[data-checked]').prop('checked', true);
});
