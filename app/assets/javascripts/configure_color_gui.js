function ConfigureColorGui(lampId) {
  this.lampId = lampId;

  this.build = function(){
    this.buildSpectrum();
    this.buildSlider();
    this.buildCheck();
  }

  this.buildCheck = function() {
    var lamp = this.lampId;
    $("#check_alert_" + lamp).on({change: this.controlAlert })
    $("#check_on_" + lamp).on({change: this.controlOn})
  }

  this.buildSpectrum = function() {
    $("#lamp_" + this.lampId).spectrum({
      chooseText: "Escolher",
      change: function(color) {
        new LampConfiguration($(this).data("lampid")).setProperties();
      }
    });
  }

  this.buildSlider = function() {
    var objSlider = $("#color_sat_slider_" + this.lampId);
    var value     = objSlider.data("saturationvalue");
    var conf      = this;

    objSlider.slider({
      value: value,
      min: 0,
      max: 254,
      animate: "slow"
    });

    objSlider.slider({
        change: function( event, ui ) {
          conf.setSaturation(ui["value"]);
        }
    });

  }

  this.getPicker = function(){
    return $("#lamp_" + this.lampId).spectrum("get");
  }

  this.setVal = function(_obj, _val) {
    $("#" + _obj  + this.lampId).val(_val);
  }

  this.setHex = function(_val) {
    this.setVal("color_code_hex_", _val);
  }

  this.setXY = function(x, y) {
    var _val = "" + x + " , " +  y;
    this.setVal("color_code_xy_", _val);
  }

  this.setSaturation = function(_val){
    this.setVal("color_saturation_", _val);
  }

  this.getSaturation = function() {
    var sat = $("#color_saturation_" + this.lampId).val();
    return sat == "" ? 0 : sat;
  }

  this.setBrightness= function(_val){
    this.setVal("color_brightness_", _val);
  }

  this.controlOn = function(){
    var lamp = $(this).val();
    $("#color_on_" + lamp).val($(this).prop("checked"));
  }

  this.controlAlert = function() {
    var lamp = $(this).val();
    $("#color_alert_" + lamp).val($(this).prop("checked"));
  }

  this.setOn = function() {
    $("#check_on_" + this.lampId).prop( "checked", true );
    $("#check_on_" + this.lampId).change();
  }

  this.getOn = function() {
    return $("#check_on_" + this.lampId).prop( "checked");
  }

  this.getAlert = function() {
    return $("#check_alert_" + this.lampId).prop( "checked");
  }
}
