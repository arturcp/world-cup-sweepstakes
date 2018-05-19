define('score', function() {
  function Score(container) {
    var inputs = this._findInputs(container);

    this.hostInput = $(inputs[0]);
    this.visitorInput = $(inputs[1]);

    this.hostScore = this.hostInput.val() || 0;
    this.visitorScore = this.visitorInput.val() || 0;
  };

  var fn = Score.prototype;

  fn.isTie = function() {
    return this.hostScore === this.visitorScore;
  };

  fn.enable = function() {
    this.hostInput.prop('disabled', false);
    this.visitorInput.prop('disabled', false);
  };

  fn.disable = function() {
    this.hostInput.prop('disabled', true);
    this.visitorInput.prop('disabled', true);

    this._reset();
  };

  fn._reset = function() {
    this.hostInput.val(0);
    this.visitorInput.val(0);
    this.hostScore = 0;
    this.visitorScore = 0;
  };

  fn._findInputs = function(container) {
    return container.find('.input-for-score');
  }

  return Score;
});
