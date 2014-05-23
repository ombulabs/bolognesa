$(function(){

  // Pomodoro Model
  window.Pomodoro = Backbone.Model.extend({});

  // Pomodoro Collection
  window.PomodoroList = Backbone.Collection.extend({

    model: Pomodoro,
    url: '/pomodoris'

  });

  // Apply Mustache-style delimiters:
  //    {% statements %} for executing arbitrary JavaScript code
  //    {{ var }}        for interpolating values
  _.templateSettings = {
	  evaluate    : /\{%([\s\S]+?)%\}/g,
	  interpolate : /\{\{([\s\S]+?)\}\}/g
  };

  // Create global collection of Pomodoros
  window.Pomodoros = new PomodoroList;

  window.PomodoroView = Backbone.View.extend({

    tagName: "li",
    className: "pomodoro",
    template: _.template($('#pomodoro-template').html()),

    events: {

    },

    initialize: function() {

    },

    render: function() {
      var pomodoro = this.model.toJSON();
      pomodoro['created_at_fmt'] = Util.formatTime(pomodoro['created_at']);
      // pomodoro['finished_at_fmt'] = Util.formatTime(pomodoro['finished_at']);
      $(this.el).html(this.template(pomodoro));
      return this;
    }

  });

  window.AppView = Backbone.View.extend({

    el: $('#main'),

    events: {
      "click .start-button" : "startPomodoro"
    },

    initialize: function() {
      Pomodoros.bind('add', this.addOne, this);
      Pomodoros.bind('reset', this.addAll, this);
      Pomodoros.bind('all', this.render, this);

      Pomodoros.fetch();
    },

    // Add a single Pomodoro to the list by creating a view for it
    addOne: function(pomodoro) {
      var view = new PomodoroView({model: pomodoro});
      this.$("#pomodoro-list").append(view.render().el);
    },

    // Add all items in the Pomodoros collection at once.
    addAll: function() {
      Pomodoros.each(this.addOne);
    },

    startPomodoro: function() {
      var pom = new Pomodoro();
      Pomodoros.create(pom, { wait: true });
    }

  });

  function Util() {};

  Util.formatTime = function(d) {
      d = new Date(d);
      var hours = d.getHours();
      var minutes = d.getMinutes();
      var ampm = hours >= 12 ? 'PM' : 'AM';
      hours = hours % 12;
      hours = hours ? hours : 12;
      minutes = minutes < 10 ? '0'+minutes : minutes;
      var strTime = hours + ':' + minutes + ' ' + ampm;
      return strTime;
  };

  window.App = new AppView;

});
