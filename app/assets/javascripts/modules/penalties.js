define('penalties', function() {
  function Penalties() {
    this.url = $('#games-container').attr('data-update-score-url');
    this._bindEvents();
  };

  var fn = Penalties.prototype;

  fn._bindEvents = function() {
    EventDispatcher.on('scoreRemoved', $.proxy(this._scoreChanged, this));
    EventDispatcher.on('scoreChanged', $.proxy(this._scoreChanged, this));
    EventDispatcher.on('extraTimeScoreRemoved', $.proxy(this._extraTimeScoreChanged, this));
    EventDispatcher.on('extraTimeScoreChanged', $.proxy(this._extraTimeScoreChanged, this));

    $('[data-winner]').on('change', $.proxy(this._selectPenaltiesWinner, this));
  };

  fn._scoreChanged = function(payload) {
    var penaltiesContainer = payload.container.find('.penalties-container'),
        inputs = payload.container.find('.input-for-score');

    if (penaltiesContainer.length > 0) {
      this._onScoreChanged(penaltiesContainer, inputs);
    }
  };

  fn._onScoreChanged = function(container, inputs) {
    var hostInput = $(inputs[0]),
        visitorInput = $(inputs[1]),
        hostScore = hostInput.val() || 0,
        visitorScore = visitorInput.val() || 0,
        regularTimeWarning = container.find('.regular-time-warning'),
        winnerSelection = container.find('.winner-selection');

    regularTimeWarning.addClass('hide');
    winnerSelection.addClass('hide');

    if (hostInput.val() && visitorInput.val()) {
      if (hostScore === visitorScore) {
        winnerSelection.removeClass('hide');
        winnerSelection.parents('.card-panel').find('.penalties-container').addClass('waiting-for-winner');
      } else {
        regularTimeWarning.removeClass('hide');
      }
    }
  };

  fn._selectPenaltiesWinner = function(event) {
    var element = $(event.currentTarget),
        panel = element.parents('.card-panel'),
        container = panel.find('.card-content'),
        gameId = parseInt(container.attr('data-game-id'));

    $.ajax({
      type: 'PUT',
      url: this.url,
      data: {
        step: 'penalties',
        game_id: gameId,
        winner_id: element.attr('data-winner')
      },
      error: function(data) {
        M.toast({ html: 'Hum... something didn\'t work as expected' });
      },
      success: function(data) {
        panel.find('.waiting-for-winner').removeClass('waiting-for-winner');
      }
    });
  };

  return Penalties;
});
