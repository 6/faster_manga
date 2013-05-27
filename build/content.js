// Generated by CoffeeScript 1.6.2
(function() {
  var MangaHere, Prerenderer, absoluteUrl, prerenderer, _ref,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  absoluteUrl = function(url, hostname) {
    var base, resolver;

    base = $("base")[0];
    if (base == null) {
      base = $("<base>").appendTo("head")[0];
    }
    base.href = hostname;
    resolver = document.createElement('a');
    resolver.href = url;
    return resolver.href;
  };

  Prerenderer = (function() {
    function Prerenderer() {
      this.prerender = __bind(this.prerender, this);
      this.nextPage = __bind(this.nextPage, this);
    }

    Prerenderer.prototype.nextPage = function() {
      var href;

      href = $(this.nextPageSelector).attr("href");
      if (url('hostname', href) == null) {
        href = absoluteUrl(href, url('hostname'));
      }
      return href;
    };

    Prerenderer.prototype.prerender = function() {
      var nextPageUrl;

      nextPageUrl = this.nextPage();
      if (nextPageUrl == null) {
        return;
      }
      console.log("Prerendering: " + nextPageUrl);
      return $("<link rel='prerender' href='" + nextPageUrl + "'>").appendTo("head");
    };

    return Prerenderer;

  })();

  MangaHere = (function(_super) {
    __extends(MangaHere, _super);

    function MangaHere() {
      _ref = MangaHere.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    MangaHere.prototype.nextPageSelector = "a.next_page:first";

    return MangaHere;

  })(Prerenderer);

  prerenderer = {
    "mangahere.com": MangaHere
  }[url('domain')];

  new prerenderer().prerender();

}).call(this);
