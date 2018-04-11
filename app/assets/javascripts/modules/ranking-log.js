define('ranking-log', function() {
  function RankingLog() {
    this.buttons = $('.show-log');
    this._bindEvents();
  };

  var fn = RankingLog.prototype;

  fn._bindEvents = function() {
    this.buttons.on('click', $.proxy(this._openRankingLog, this));
  };

  fn._openRankingLog = function(event) {
    var element = $(event.currentTarget);

    $.ajax({
      type: 'GET',
      url: element.attr('data-ranking-url'),
      error: function(data) {
        M.toast({ html: 'Hum... something didn\'t work as expected' });
      },
      success: function(data) {
        $.dialog({
          title: 'Check the user\'s points',
          content: data,
          boxWidth: '40%',
          useBootstrap: false
        });
      }
    });
  };

  return RankingLog;
});
