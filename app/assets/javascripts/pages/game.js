page.at('games#index', function() {
  var TeamSelection = require('team-selection'),
      ScoreChanges = require('score-changes');

  new TeamSelection('.unconfirmed-team');
  new ScoreChanges();
});
