function RadioListener() {
  this.dispatcher = null;

  this.getDispatcher = function(){

    if (this.dispatcher == null){
      var url         = radio.getContentRadio().data('uri');
      this.dispatcher = new WebSocketRails(url);
    }

    return this.dispatcher;
  }

  this.stop = function() {
    this.getDispatcher().trigger("radio.stop");
  }

  this.start = function() {
    this.getDispatcher().trigger("radio.current_track");
    this.getDispatcher().bind("radio.message_success", function(track) {
      radio.setCurrentTrack(track);
    });
  }
}

var radio_listener = new RadioListener();

var radio = {

  init: function() {
    radio.clearTrack();
    radio.start();
  },

  getContentRadio: function() {
    return $("#content-radio");
  },

  start:function() {
    radio_listener.start();
  },

  hideBoxRadio: function() {
    $("#box_radio").fadeOut( 'slow');
  },

  clearTrack: function() {
    radio.getContentRadio().find(".radio_logo").hide();
    radio.getContentRadio().find("#application_name").text("iTunes");
    radio.getContentRadio().find("#track").text("");
    radio.getContentRadio().find("#artist").text("");
    radio.getContentRadio().find("#album").text("");
    radio.getContentRadio().find("#genre_description").text("");
  },

  setCurrentTrack: function(track) {
    radio.clearTrack();
    radio.getContentRadio().find("#radio_logo_" + track["application"]).show();
    radio.getContentRadio().find("#track").text(track['track']);
    radio.getContentRadio().find("#artist").text(track['artist']);
    radio.getContentRadio().find("#album").text(track['album']);
    radio.getContentRadio().find("#application_name").text(track['application']);

    var genre = track['genre'];

    if(genre == 'NOT_IMPLEMENTED')
      genre = "";

    radio.getContentRadio().find("#genre_description").text(genre);
    $("#box_radio").fadeIn( 'slow');
  }
}
