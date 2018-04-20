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

    $('[data-winner]').on('change', $.proxy(this._selectPenaltiesWinner, this));
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

      if (penaltiesContainer.length > 0) {
        this._showExtraTimeResult(penaltiesContainer, inputs);
      }
    }

    //The update will be triggered only when a number is typed in the inputs.
    if (key >= 48 && key <= 57) {
      this._updateScore(gameId, $(inputs[0]), $(inputs[1]));

      if (penaltiesContainer.length > 0) {
        this._showExtraTimeResult(penaltiesContainer, inputs);
      }
    }
  };

  fn._updateScore = function(gameId, hostInput, visitorInput) {
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
      error: function(data) {
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

  fn._showExtraTimeResult = function(container, inputs) {
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

  return ScoreChanges;
});
