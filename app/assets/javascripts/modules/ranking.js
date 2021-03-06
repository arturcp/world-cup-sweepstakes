define('ranking', function() {
  function Ranking() {
    this.buttons = $('.ranking-button');
    this.url = $('#games-container').attr('data-ranking-url');

    if (this._hasRankingButtons()) {
      this._hideRankingButtons();
      this._bindEvents();
    }
  };

  var fn = Ranking.prototype;

  fn._bindEvents = function() {
    EventDispatcher.on('scoreChanged', $.proxy(this._scoreChanged, this));
    EventDispatcher.on('scoreRemoved', $.proxy(this._scoreRemoved, this));
    this.buttons.on('click', $.proxy(this._calculateRanking, this))
  };

  fn._hasRankingButtons = function() {
    return $('.ranking-button-container').length > 0;
  };

  fn._hideRankingButtons = function() {
    $.each(this.buttons, function() {
      var button = $(this),
          container = button.parents('.card-panel'),
          inputs = container.find('.input-for-score'),
          hostInput = $(inputs[0]),
          visitorInput = $(inputs[1]);

      if (container.hasClass('ranking-points-distributed')) {
        button.addClass('invisible');
      }
      else if (hostInput.val() === '' || visitorInput.val() === '') {
        button.addClass('disabled');
      }
    });
  };

  fn._scoreChanged = function(payload) {
    var container = payload.container,
        button = container.find('.ranking-button'),
        penaltiesWinner = payload.container.parent().find('.waiting-for-winner');

    if (container.hasClass('ranking-points-distributed')) {
      button.addClass('invisible');
    }
    else if (payload.hostScore !== '' && payload.visitorScore !== '') {
      button.removeClass('disabled');
    } else {
      button.addClass('disabled');
    }
  };

  fn._scoreRemoved = function(payload) {
    var container = payload.container,
        button = container.find('.ranking-button');

    if (!container.hasClass('ranking-points-distributed')) {
      button.addClass('disabled');
    }
  };

  fn._calculateRanking = function(event) {
    var button = $(event.currentTarget),
        container = button.parents('.card-panel'),
        content = container.find('.card-content'),
        inputs = container.find('.input-for-score'),
        hostInput = $(inputs[0]),
        visitorInput = $(inputs[1]),
        gameId = content.attr('data-game-id');

    if (container.find('.waiting-for-winner').length > 0) {
      M.toast({
        html: 'You have to define the winner of the penalties first :(',
        classes: 'danger-toast'
      });
      return;
    }

    $.ajax({
      type: 'POST',
      url: this.url,
      data: { game_id: gameId },
      beforeSend: function() {
        Loading.show();
      },
      error: function(data) {
        M.toast({ html: 'Hum... something didn\'t work as expected' });
        Loading.hide();
      },
      success: function() {
        Loading.hide();
        container.addClass('ranking-points-distributed');
        button.addClass('invisible');
        M.toast({ html: 'Points distributed!' });
      }
    });
  };

  return Ranking;
});
