var _URL_LIGHT = 'http://192.168.1.102/api/edersondelima/';

var lamps = {

  init: function() {
    lamps.setBoxLights();
    lamps.buildSlider();
    $("#lamp_alert").on({click: lamps.alert});
    $("#lamp_off").on({click: lamps.off});
  },

  buildSlider: function() {
    var objSlider = $("#slider_lamp");

    objSlider.slider({
      min: 0,
      max: 254,
      animate: "slow"
    });

    objSlider.slider({
        change: function( event, ui ) {
          lamps.setBrilho(ui["value"]);
        }
    });
  },

  off: function(){
    var json   = {"on":false};
    var flag   = false;

    jQuery("input[name='lamp']").each(function() {
       if(this.checked) {
          lamps.sendData(this.value, json);
          $("#item_lamp_" + this.value + "_effect").remove();
       }
    });
  },

  alert: function(){
    var effect = "colorloop";
    var on     = true;

    if ($(this).hasClass("active")) {
      effect = "none";
      on     = false;
      $(this).removeClass("active")
    } else {
      $(this).addClass("active")
    }

    var json   = {"on":true, "effect": effect, "alert": "lselect", "transitiontime": 2};

    jQuery("input[name='lamp']").each(function() {
       if(this.checked) {
          lamps.sendData(this.value, json);

          if (on) {
            $("#item_action_lamp_" + this.value).append('<span class="label label-important" id="item_lamp_' + this.value+'_effect">Efeito</span>');
          } else {
            $("#item_lamp_" + this.value + "_effect").remove();
          }
       }
    });
  },

  setBrilho: function(bri) {
    var url = _URL_LIGHT + "lights/";
    jQuery("input[name='lamp']").each(function() {

       if(this.checked) {
          var dataJson = {"on":true, "bri":bri};
          lamps.sendData(this.value, dataJson);
       }
    });
  },

  sendData: function(lampId, data_json) {
    var url = _URL_LIGHT + "lights/" + lampId + "/state";

    if (data_json["on"] !== undefined) {
      var label = "    Desligado  "
      if (data_json["on"]) {
        label = "    Ligado  "
      }
      $("#link_lamp_on_" + lampId).text(label)
    }


    $.ajax({
          url: url,
          type: 'PUT',
          data: JSON.stringify(data_json),
          contentType: "application/json",
          dataType: 'json'
    });
  },

  setBoxLights: function() {
    var url = _URL_LIGHT + "lights";
    $("#box_light_names").empty();

    $.get(url)
      .done(function(data){
        $.each(data, function(key, value) {
          lamps.makeBox(key, data[key]["name"]);
        });
      });
  },

  getStatus: function(id) {
    var url = _URL_LIGHT + "lights/" + id;

    $.get(url)
      .done(function(data){
        lamps.setStatusOnOff(id, data["state"]["on"])
      });
  },

  setStatusOnOff: function(id, data) {
    var obj      = $("#lamp_status_" + id);
    var status   = data ? 'Ligado' : 'Desligado';
    var icon     = data ? 'ico-flash' : 'ico-attention';
    var label    = data ? 'info' : 'nverse';

    var content  = '';
        content += '<li>';
        content += '  <a href="javascript:;" class="' + icon + '" id="link_lamp_on_' + id + '">';
        content += '    ' + status;
        content += '  </a>';
        content += '</li>';

        content += '<li id="item_action_lamp_' + id + '">';
        content += '  <input type="checkbox" name="lamp" value="' + id + '"  >';
        content += '  &nbsp; <span class="label label-'+ label +'">Ação</span> ';
        content += '</li>';

    obj.append(content);
  },

  makeBox:function(id, data) {
    var box = $("#box_light_names");

    lamps.getStatus(id);

    var content  = '';
        content += '  <div class="span3">';
        content += '    <section class="sideBox">';
        content += '      <div class="boxSidebarTitle"><i class="ico-lamp"></i></div>';
        content += '      <h1 class="titSide">' + data + '</h1>';
        content += '      <div class="innerSideBox"  >';
        content += '        <ul class="listWhite" id="lamp_status_' + id + '" >';
        content += '        </ul>';
        content += '      </div>';
        content += '    </section>';
        content += '  </div>';

    box.append(content);
  }
}