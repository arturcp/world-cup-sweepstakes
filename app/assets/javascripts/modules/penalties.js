define('penalties', ['score'], function(Score) {
  function Penalties() {
    this.url = $('#games-container').attr('data-update-score-url');
    this._bindEvents();
  };

  var fn = Penalties.prototype;

  fn._bindEvents = function() {
    EventDispatcher.on('scoreRemoved', $.proxy(this._onScoreChanged, this));
    EventDispatcher.on('scoreChanged', $.proxy(this._onScoreChanged, this));
    EventDispatcher.on('extraTimeScoreRemoved',
      $.proxy(this._onExtraTimeScoreChanged, this));
    EventDispatcher.on('extraTimeScoreChanged',
      $.proxy(this._onExtraTimeScoreChanged, this));

    $('[data-winner]').on('change', $.proxy(this._selectPenaltiesWinner, this));
  };

  fn._onScoreChanged = function(payload) {
    var penaltiesContainer = payload.container.find('.penalties-container'),
        extraTimeContainer = payload.container.find('.input-for-score');

    if (penaltiesContainer.length > 0) {
      var regularTimeScore = new Score(payload.container),
          extraTimeScore = new Score(extraTimeContainer);

      this._togglePenaltiesFields(penaltiesContainer, regularTimeScore,
        extraTimeScore);
    }
  };

  fn._onExtraTimeScoreChanged = function(payload) {
    var cardPanel = payload.container.parents('.card-panel'),
        penaltiesContainer = cardPanel.find('.penalties-container');

    if (penaltiesContainer.length > 0) {
      var regularTimeScore = new Score(cardPanel.find('.card-content')),
          extraTimeScore = new Score(cardPanel.find('[data-extra-time-container]'));

      this._togglePenaltiesFields(penaltiesContainer, regularTimeScore,
        extraTimeScore);
    }
  };

  fn._togglePenaltiesFields = function(container, regularTimeScore, extraTimeScore) {
    var regularTimeWarning = container.find('.regular-time-warning'),
        winnerSelection = container.find('.winner-selection');

    regularTimeWarning.addClass('hide');
    winnerSelection.addClass('hide');

    if (regularTimeScore.isTie() && extraTimeScore.isTie()) {
      winnerSelection.removeClass('hide');
      winnerSelection.parents('.card-panel').find('.penalties-container').addClass('waiting-for-winner');
      $('[data-winner]').prop('checked', false);
    } else {
      regularTimeWarning.removeClass('hide');
      winnerSelection.parents('.card-panel').find('.penalties-container').removeClass('waiting-for-winner');
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
