// Lib do deal with event dispatching like a Pub/Sub.
//
// Usage:
//
// * The event handler:
//
//   function handler() { console.log.apply(console,arguments); }
//
// * Subscribe the event `an_event`:
//
//   EventDispatcher.on('an_event', handler);
//
// * Publish the event `an_event` with `foo`, `bar` and `123` data:
//
//   EventDispatcher.trigger('an_event', 'foo', 'bar', 123);
//   # => foo bar 123
//
// * Unsubscribe the event `an_event`:
//
//   EventDispatcher.off('an_event', handler);
//
// * Execute the handler function only once:
//
//   EventDispatcher.once('an_event', handler)
var EventDispatcher = {
  listeners: {},
  on: function(event, callback) {
    if(!Object.prototype.hasOwnProperty.call(this.listeners, event)) {
      this.listeners[event] = [];
    }
    this.listeners[event].push(callback);
  },
  once: function(event, callback) {
    var once = function() {
      try {
        return callback.apply(this, arguments);
      }
      finally {
        this.off(event, once);
      }
    };
    this.on(event, once);
  },
  off: function(event, callback) {
    if (Object.prototype.hasOwnProperty.call(this.listeners, event)) {
      var listeners = this.listeners[event];

      for (var i = 0; i < listeners.length; i++) {
        if (listeners[i] === callback) {
          listeners.splice(i, 1);
          return;
        }
      }
    }
  },
  trigger: function(event) {
    if (Object.prototype.hasOwnProperty.call(this.listeners, event)) {
      var listeners = this.listeners[event];
      var args = Array.prototype.slice.call(arguments, 1);

      for (var i = 0; i < listeners.length; i++) {
        listeners[i].apply(this, args);
      }
    }
  }
};
