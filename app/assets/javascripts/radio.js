var radio = {

  init: function() {
    radio.clearTrack();
    radio.start();
  },

  getContentRadio: function() {
    return $("#content-radio");
  },

  start:function() {
    var url        = radio.getContentRadio().data('uri');
    var dispatcher = new WebSocketRails(url);

    dispatcher.trigger("radio.current_track");
    dispatcher.bind("radio.message_success", function(track) {
      radio.setCurrentTrack(track);
    });

    dispatcher.bind("radio.message_fail", function(track) {
      radio.hideBoxRadio();
    });
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
