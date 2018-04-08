define('team-selection', function() {
  function TeamSelection(element) {
    this.element = $(element);
    this.container = $('#games-container');
    this.url = this.container.attr('data-update-game-url');;
    this._bindEvents();
  };

  var fn = TeamSelection.prototype;

  fn._bindEvents = function() {
    this.element.on('click', $.proxy(this._convertToSelect, this));
  };

  fn._convertToSelect = function(event) {
    var select = $('#teams-template').find('select').clone(),
        element = $(event.currentTarget);

    select.attr('id', '');
    element.after(select);
    element.parent().find('.flag').remove();
    element.remove();

    select.select2({
      templateResult: $.proxy(this._formatData, this),
      templateSelection: $.proxy(this._formatData, this)
    });

    select.on('change', $.proxy(this._selectTeam, this));
  };

  fn._formatData = function(option) {
    var flag = this.container.find('.flag[data-for="' + option.text + '"]');

    if (flag.length > 0) {
      return $('<img class="flag" src="' + flag.attr('src') + '" />' + option.text);
    } else {
      return $('<div class="flag-placeholder"></div>' + option.text);
    }
  };

  fn._selectTeam = function(event) {
    var element = $(event.currentTarget),
        container = element.parents('.card-content'),
        gameId = container.attr('data-game-id'),
        hostId = parseInt(container.attr('data-host-id') || 0),
        visitorId = parseInt(container.attr('data-visitor-id') || 0),
        isHost = element.parent().attr('data-type') == 'host',
        self = this;

    if (isHost) {
      hostId = parseInt(element.val());
      container.attr('data-host-id', hostId);
    } else {
      visitorId = parseInt(element.val());
      container.attr('data-visitor-id', visitorId);
    }

    if (visitorId > 0 && hostId > 0) {
      $.confirm({
        title: 'Game update',
        content: 'Are the teams right? The game will be updated and there is no way to undo this action. Are you sure?',
        type: 'red',
        boxWidth: '40%',
        useBootstrap: false,
        buttons: {
          ok: {
            text: "I am sure!",
            btnClass: 'btn-primary',
            keys: ['enter'],
            action: function() {
              self._updateUnconfirmedTeam(gameId, hostId, visitorId);
            }
          },
          cancel: function(){
            // console.log('the user clicked cancel');
          }
        }
      });
    }
  };

  fn._updateUnconfirmedTeam = function(gameId, hostId, visitorId) {
    $.ajax({
      type: 'PUT',
      url: this.url,
      data: {
        game_id: gameId,
        host_id: hostId,
        visitor_id: visitorId
      },
      error: function (data) {
        M.toast({ html: 'Hum... something didn\'t work as expected' });
      },
      success: function() {
        var container = $('.card-content[data-game-id="' + gameId + '"]');

        container.find('input[type="text"]').prop('disabled', false);
        var selects = container.find('select');

        $.each(selects, function() {
          var select = $(this),
              data = select.select2('data');

          select.after($('<span class="team-name">' + data[0].text + '</span>'));
          select.remove();
        });
      }
    });
  };

  return TeamSelection;
});
