define('extra-time', ['score'], function(Score) {
  function ExtraTime() {
    this.url = $('#games-container').attr('data-update-score-url');
    this.inputs = $('[data-extra-time-container] .input-for-score');
    this._bindEvents();
  };

  var fn = ExtraTime.prototype;

  fn._bindEvents = function() {
    EventDispatcher.on('scoreRemoved', $.proxy(this._onScoreRemoved, this));
    EventDispatcher.on('scoreChanged', $.proxy(this._onScoreChanged, this));

    this.inputs.on('keyup', $.proxy(this._extraTimeScoreChanged, this));
  };

  fn._onScoreChanged = function(payload) {
    this._toggleExtraTimeFields(payload.container);
  };

  fn._onScoreRemoved = function(payload) {
    this._toggleExtraTimeFields(payload.container);
  };

  fn._toggleExtraTimeFields = function(container) {
    var extraTimeContainer = container.find('[data-extra-time-container]'),
        regularTimeScore = new Score(container),
        extraTimeScore = new Score(extraTimeContainer);

    if (regularTimeScore.isTie()) {
      extraTimeScore.enable();
      EventDispatcher.trigger('extraTimeScoreChanged', {
        container: extraTimeContainer, score: extraTimeScore });
    } else {
      extraTimeScore.disable();
    }

    this._updateExtraTimeScore(extraTimeContainer);
  };

  fn._extraTimeScoreChanged = function(event) {
    var key = event.charCode || event.keyCode || 0,
        element = $(event.currentTarget),
        container = element.parents('[data-extra-time-container]');

    if (element.val() === '') {
      EventDispatcher.trigger('extraTimeScoreRemoved', {
        container: container
      });
      element.focus();
    }

    //The update will be triggered only when a number is typed in the inputs.
    if (key >= 48 && key <= 57) {
      this._updateExtraTimeScore(container);
    }
  };

  fn._updateExtraTimeScore = function(container) {
    var gameId = container.attr('data-game-id'),
        score = new Score(container);

    if (gameId) {
      $.ajax({
        type: 'PUT',
        url: this.url,
        data: {
          step: 'extra_time',
          game_id: gameId,
          extra_time: {
            host_score: score.hostScore,
            visitor_score: score.visitorScore
          }
        },
        error: function(data) {
          M.toast({ html: 'Hum... something didn\'t work as expected' });
        },
        success: function(data) {
          EventDispatcher.trigger('extraTimeScoreChanged', {
            container: container, score: score });
        }
      });
    }
  };

  return ExtraTime;
});
