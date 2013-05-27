var prerender = function() {
  var nextPageUrl = $(".next_page:first").attr("href");
  if(!nextPageUrl) return;
  console.log("Prerendering: "+ nextPageUrl);
  $("<link rel='prerender' href='"+nextPageUrl+"'>").appendTo("head");
};

prerender();
