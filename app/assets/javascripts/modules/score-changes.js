define('score-changes', function() {
  function ScoreChanges() {
    this.element = $('.input-for-score:enabled');
    this.url = $('#games-container').attr('data-update-url');
    this._bindEvents();
  };

  var fn = ScoreChanges.prototype;

  fn._bindEvents = function() {
    this.element.forceNumericOnly();
    this.element.off('keyup').on('keyup', $.proxy(this._changeScore, this));
  };

  fn._changeScore = function(event) {
    var key = event.charCode || event.keyCode || 0;

    //it will be triggered only with numbers
    if (key >= 48 && key <= 57) {
      var element = $(event.currentTarget),
          gameId = parseInt(element.attr('data-game-id')),
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
      type: "POST",
      url: this.url,
      data: {
        game_id: gameId,
        host_score: hostScore,
        visitor_score: visitorScore
      },
      error: function (data) {
        M.toast({ html: "Hum... something didn't work" });
      },
      success: function() {
        if (hostInput.val() !== '') {
          hostInput.val(hostScore);
        }

        if (visitorInput.val() !== '') {
          visitorInput.val(visitorScore);
        }
      }
    });
  };

  return ScoreChanges;
});
