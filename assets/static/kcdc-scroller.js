/******************************************
 * kccode.net
 *
 * KCDC May 4, 2013 - kcdc.info
 *
 * @author          pete.thomas@gmail.com
 * @copyright       Copyright (c) 2013 Pete Thomas.
 * @license         licensed under MIT and GPL licenses.
 * @link            http://kccode.net
 * @github          http://git.io/kccode
 * @version         1.0
 *
 ******************************************/
(function($) {
  $.kcdcScroller = function(option, settings) {
    if(typeof option === 'object') { settings = option; }
    else if(typeof option === 'string') {
      var values = [];

      var elements = this.each(function() {
        var data = $(this).data('_kcdcScroller');

        if(data) {
          if(option === 'reset') { data.reset(); }
          else if($.kcdcScroller.defaultSettings[option] !== undefined)
          {
            if(settings !== undefined) { data.settings[option] = settings; }
            else { values.push(data.settings[option]); }
          }
        }
      });

      if(values.length === 1) { return values[0]; }
      if(values.length > 0) { return values; }
      else { return elements; }
    }

    return this.each(function() {
      var $elem = $(this);
      var $settings = $.extend({}, $.kcdcScroller.defaultSettings, settings || {});
      var scroller = new KCDCScroller($settings, $elem);
      scroller.init();
      $elem.data('_kcdcScroller', scroller);
    });
  }

  $.kcdcScroller.defaultSettings = {
    create : function () {// - code to run for new loaded file 
      $('body').append(
        '<div id="' + 
        this.settings.idPrefix + this.id + 
        '"><pre style="font: ' + 
        this.settings.fontSize + 'px/' + 
        this.settings.fontSize + 
        'px monospace; line-height: 115%;"></pre></div>'
      );

      $('#' + this.settings.idPrefix + this.id + '>pre').load('/0/s' + this.id + '.html');
    },
    delay : 175,         // - delay in ms before scrolling to next loaded file 
    fontSize: 28,        // - font size for content in loaded files
    idPrefix : 'obj_',   // - string with which to prefix Ids
    init : function () { // - code to run when starting scroller
      $('body').append(
        '<div id="' + 
        this.settings.idPrefix + '1' +
        '"><pre style="font: ' + 
        this.settings.fontSize + 'px/' + 
        this.settings.fontSize + 
        'px monospace;"></pre></div>'
      );

      $('#' + this.settings.idPrefix + '0>pre').load('/0/s1.html');
    },
    lastLoad : 10,       // - how many loaded files will there be?
    start : 1            // - what integer to start with when loading files
  };

  function KCDCScroller(settings, $elem) {
    this.settings = settings;
    this.create = this.settings.create;
    this.$elem = $elem;
    this.init   = this.settings.init;
    this.scroller = null;
    this.id = this.settings.start;

    document.addEventListener('touchend',        // mobile
      jQuery.proxy(
        function(e) {                            
          this.moveForward(); e.preventDefault();
        },
        this
      ), false
    );

    $(document).keydown(
      jQuery.proxy(
        function(e) {
          switch(e.which) {
            case 13: this.moveForward(); break;  // enter
            case 32: this.moveForward(); break;  // space
            case 37: this.moveBackward(); break; // left
            case 38: this.moveBackward(); break; // up
            case 39: this.moveForward(); break;  // right 
            case 40: this.moveForward(); break;  // down
            case 65: this.moveBackward(); break; // a
            case 68: this.moveForward(); break;  // d
            case 83: this.moveForward(); break;  // s
            case 87: this.moveBackward(); break; // w 
            default: return;
          };
          e.preventDefault();
        }, this
      )
    );
    return this;
  }

  KCDCScroller.prototype = {

    anchor : function (direction) { 
      var hash = location.hash.replace('#','');
      if(hash != '') {
        var re = /(\D*)(\d+)$/;
        var next   = parseInt(hash.replace(re, "$2"), 10) + direction;
        var prefix = hash.replace(re, "$1");
        this.id = parseInt(next);
        return '#' + prefix + this.id;
      }
      else {
        return '#' + this.settings.idPrefix + this.id;
      }
    },
    destroy: function() { this.paginate.remove(); this.$elem.removeData('_kcdcScroller'); },
    moveBackward : function () {
      if (this.id > this.settings.start) { this._move(-1); }
    },
    moveForward : function () {
      if (this.id < this.settings.lastLoad) {
        this._move(1); 
      }
    },
    _move : function (direction) {
      var delay = this.settings.delay;
      var anchor = this.anchor(direction);
      if ($(anchor).attr('href') && direction > 0) {
        window.open($(anchor).attr('href'));
      }
      else {
        if (!$(anchor).length) {
          this.create();
        }
        setTimeout(function () {
          $('html, body').scrollTo( $(anchor), delay); 
        },   delay);
      }
      location.hash = anchor;
    }
  };

})(jQuery);
