define('team-selection', function() {
  function TeamSelection(element) {
    this.element = $(element);
    this.container = $('#games-container');
    this._bindEvents();
  };

  var fn = TeamSelection.prototype;

  fn._bindEvents = function() {
    var self = this;

    this.element.off('click').on('click', function() {
      self._convertToSelect($(this));
    });
  };

  fn._convertToSelect = function(element) {
    var select = $('#teams-template').find('select').clone(),
        self = this;

    select.attr('id', '');
    element.after(select);
    element.parent().find('.flag').remove();
    element.remove();

    select.select2({
      templateResult: $.proxy(self._formatData, self),
      templateSelection: $.proxy(self._formatData, self)
    });
  };

  fn._formatData = function(option) {
    var flag = this.container.find('.flag[data-for="' + option.text + '"]');
    if (flag.length > 0) {
      return $('<img class="flag" src="' + flag.attr('src') + '" />' + option.text);
    } else {
      return $('<div class="flag-placeholder"></div>' + option.text);
    }
  };

  return TeamSelection;
});
