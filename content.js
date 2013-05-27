var absoluteUrl = function(url, hostname) {
  var base = $("base")[0];
  if(!base) base = $("<base>").appendTo("head")[0];
  base.href = hostname;

  var resolver = document.createElement('a');
  resolver.href = url;

  return resolver.href;
};

var nextPage = function() {
  return absoluteUrl($(".next_page:first").attr("href"), url('hostname'));
};

var prerender = function() {
  var nextPageUrl = nextPage();
  if(!nextPageUrl) return;
  console.log("Prerendering: "+ nextPageUrl);
  $("<link rel='prerender' href='"+nextPageUrl+"'>").appendTo("head");
};

prerender();
