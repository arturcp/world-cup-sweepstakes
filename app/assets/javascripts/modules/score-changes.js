define('score-changes', function() {
  function ScoreChanges() {
    this.url = $('#games-container').attr('data-update-score-url');
    this._bindEvents();
  };

  var fn = ScoreChanges.prototype;

  fn._bindEvents = function() {
    var inputs = $('.card-content .input-for-score');
    inputs.on('keyup', $.proxy(this._changeScore, this));
  };

  fn._changeScore = function(event) {
    var key = event.charCode || event.keyCode || 0,
        element = $(event.currentTarget),
        cardPanel = element.parents('.card-panel'),
        cardContent = element.parents('.card-content'),
        gameId = parseInt(cardContent.attr('data-game-id')),
        inputs = cardContent.find('.input-for-score'),
        penaltiesContainer = cardPanel.find('.penalties-container');

    if (element.val() === '') {
      EventDispatcher.trigger('scoreRemoved', {
        container: element.parents('.card-panel')
      });
    }

    //The update will be triggered only when a number is typed in the inputs.
    if (key >= 48 && key <= 57) {
      this._updateScore(gameId, $(inputs[0]), $(inputs[1]));
    }
  };

  fn._updateScore = function(gameId, hostInput, visitorInput) {
    console.log('update score ' + gameId + ' ' + hostInput + ' ' + visitorInput);
    var hostScore = hostInput.val() || 0,
        visitorScore = visitorInput.val() || 0,
        self = this;

    $.ajax({
      type: 'POST',
      url: this.url,
      async: false,
      data: {
        game_id: gameId,
        host_score: hostScore,
        visitor_score: visitorScore
      },
      error: function(data) {
        console.log('error');
        M.toast({ html: 'Hum... something didn\'t work as expected' });
      },
      success: function() {
        console.log('success');
        if (hostInput.val() !== '') {
          hostInput.val(hostScore);
        }

        if (visitorInput.val() !== '') {
          visitorInput.val(visitorScore);
        }

        EventDispatcher.trigger('scoreChanged', {
          gameId: gameId,
          hostScore: hostInput.val(),
          visitorScore: visitorInput.val(),
          container: hostInput.parents('.card-panel')
        });
      }
    });
  };

  return ScoreChanges;
});
