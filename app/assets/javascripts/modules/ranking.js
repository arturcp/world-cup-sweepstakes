define('ranking', function(Events) {
  function Ranking() {
    if ($('.ranking-button-container').length > 0) {
      this._hideRankingButtons();
      this._bindEvents();
    }
  };

  var fn = Ranking.prototype;

  fn._hideRankingButtons = function() {
    var buttons = $('.ranking-button');

    $.each(buttons, function() {
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

  fn._bindEvents = function() {
    EventDispatcher.on('scoreChanged', $.proxy(this._scoreChanged, this));
    EventDispatcher.on('scoreRemoved', $.proxy(this._scoreRemoved, this));
  };

  fn._scoreChanged = function(payload) {
    var container = payload.container,
        button = container.find('.ranking-button');

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

  return Ranking;
});
