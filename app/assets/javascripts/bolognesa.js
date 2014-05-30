$(function(){

  // Apply Mustache-style delimiters:
  //    {% statements %} for executing arbitrary JavaScript code
  //    {{ var }}        for interpolating values
  _.templateSettings = {
    evaluate    : /\{%([\s\S]+?)%\}/g,
    interpolate : /\{\{([\s\S]+?)\}\}/g
  };

  // Pomodoro Model
  window.Pomodoro = Backbone.Model.extend({

    initialize: function() {
      this.tags = new TagList(this.get('tags'));
    }

  });

  // Pomodoro Collection
  window.PomodoroList = Backbone.Collection.extend({

    model: Pomodoro,
    url: '/pomodoris'

  });

  // Tag Model
  window.Tag = Backbone.Model.extend({});
  // Tag Collection
  window.TagList = Backbone.Collection.extend({ model: Tag });

  // Create global collection of Pomodoros
  window.Pomodoros = new PomodoroList;

  window.PomodoroView = Backbone.View.extend({

    tagName: "li",
    className: "pomodoro",
    template: _.template($('#pomodoro-template').html()),

    events: {
      "click #update-pomodori" : "render" // TODO: Not working!
    },

    initialize: function() {
      Pomodoros.bind('change', this.render, this);
    },

    render: function() {
      // Stringify tags as "tag1, tag2, tag3"
      var tags = this.model.get('tags').map(
        function(elem) {
          return elem.name;
        }).join(", ");
      // Set them in pomodoro's joined-tags attribute
      this.model.set('joinedtags', tags)

      var pomodoro = this.model.toJSON();
      pomodoro['created_at_fmt'] = Util.formatTime(pomodoro['created_at']);
      pomodoro['finished_at_fmt'] = Util.formatTime(pomodoro['finished_at']);
      $(this.$el).attr('id', 'pomodoro-' + pomodoro.id); // Adds pomodoro-id
      $(this.$el).html(this.template(pomodoro));
      return this;
    }

  });

  window.AppView = Backbone.View.extend({

    el: $('#main'),

    events: {
      "click .start-button" : "startPomodoro",
      "click .edit_tags" : "openModal",
      "click #modal.close, #modal-container" : "closeModal"
    },

    initialize: function() {
      Pomodoros.bind('add', this.addOne, this);
      Pomodoros.bind('reset', this.addAll, this);
      Pomodoros.fetch();
    },

    // Add a single Pomodoro to the list by creating a view for it
    addOne: function(pomodoro) {
      var view = new PomodoroView({model: pomodoro});
      this.$("#pomodoro-list").prepend(view.render().el);
    },

    // Add all items in the Pomodoros collection at once.
    addAll: function() {
      Pomodoros.each(this.addOne);
    },

    // Triggered with start button, creates a Pomodoro in the backend.
    startPomodoro: function() {
      var pom = new Pomodoro();
      Pomodoros.create(pom, { wait: true });
    },

    openModal: function(xhr, data, status) {
      $('#modal').html(data).prepend($('#modal').find('.close'))
                            .css('top', $(window).scrollTop() + 40).show();
      $('#modal-container').show();
    },

    closeModal: function() {
      $('#modal').hide();
      $('#modal-container').hide();
      return false;
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
