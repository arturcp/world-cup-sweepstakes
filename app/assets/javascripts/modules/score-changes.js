define('score-changes', function(Events) {
  function ScoreChanges() {
    this.element = $('.input-for-score');
    this.url = $('#games-container').attr('data-update-score-url');
    this._bindEvents();
  };

  var fn = ScoreChanges.prototype;

  fn._bindEvents = function() {
    this.element.forceNumericOnly();
    this.element.on('keyup', $.proxy(this._changeScore, this));
  };

  fn._changeScore = function(event) {
    var key = event.charCode || event.keyCode || 0,
        element = $(event.currentTarget);

    if (element.val() === '') {
      EventDispatcher.trigger('scoreRemoved', {
        container: element.parents('.card-panel')
      });
    }

    //it will be triggered only with numbers
    if (key >= 48 && key <= 57) {
      var gameId = parseInt(element.attr('data-game-id')),
          card = element.parents('.card-content'),
          inputs = card.find('.input-for-score');

      this._update(gameId, $(inputs[0]), $(inputs[1]));
    }
  };

  fn._update = function(gameId, hostInput, visitorInput) {
    var hostScore = hostInput.val() || 0,
        visitorScore = visitorInput.val() || 0,
        self = this;

    $.ajax({
      type: 'POST',
      url: this.url,
      data: {
        game_id: gameId,
        host_score: hostScore,
        visitor_score: visitorScore
      },
      error: function (data) {
        M.toast({ html: 'Hum... something didn\'t work as expected' });
      },
      success: function() {
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
