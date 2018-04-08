var Loading = {
  show: function() {
    var overlay = $('#overlay');

    if (overlay.length > 0) {
      overlay.removeClass('hide');
    }
  },
  hide: function() {
    var overlay = $('#overlay');
    
    if (overlay.length > 0) {
      overlay.addClass('hide');
    }
  }
};
