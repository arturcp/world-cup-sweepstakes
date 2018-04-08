page.at('games#index', function() {
  var TeamSelection = require('team-selection'),
      ScoreChanges = require('score-changes'),
      Ranking = require('ranking');

  new TeamSelection('.unconfirmed-team');
  new ScoreChanges();
  new Ranking();
});
