page.at('games#index', function() {
  var TeamSelection = require('team-selection');
  new TeamSelection('.unconfirmed-team');
});
