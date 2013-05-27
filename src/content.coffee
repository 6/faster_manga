absoluteUrl = (url, hostname) ->
  base = $("base")[0]
  base ?= $("<base>").appendTo("head")[0]
  base.href = hostname

  resolver = document.createElement('a')
  resolver.href = url;

  resolver.href

nextPage = ->
  href = $(".next_page:first").attr("href")
  unless url('hostname', href)?
    href = absoluteUrl(href, url('hostname'))
  href

prerender = ->
  nextPageUrl = nextPage()
  return  unless nextPageUrl?
  console.log("Prerendering: #{nextPageUrl}")
  $("<link rel='prerender' href='#{nextPageUrl}'>").appendTo("head")

prerender()