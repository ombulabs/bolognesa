$(function()){

  // Pomodori Model
  window.Pomodori = Backbone.Model.extend({});

  // Pomodori Collection
  window.PomodoriList = Backbone.Collection.extend({

    model: Pomodori,
    url: '/',

    today: function() { }

  });

  // Create global collection of Pomodoris
  window.Pomodoris = new PomodoriList;

  window.PomodoriView = Backbone.View.extend({

    tagName: "li",

    template: _.template($('#pomodori-template').html()),

    events: {
      "click .edit_tags" : "editTags"
    },

    initialize: function() {

    },

    render: function() {
      $(this.el).html(this.template(this.model.toJSON()));
      return this;
    },

    editTags: function() {

    }

  });

  window.AppView = Backbone.View.extend({

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
    }

  });

  window.App = new AppView;

});
