absoluteUrl = (urlToResolve, hostname) ->
  oldBase = $('base')[0]
  oldHref = oldBase && oldBase.href
  docHead = $('head')[0]
  tempBase = oldBase || docHead.appendChild(document.createElement('base'))

  resolver = document.createElement('a')
  tempBase.href = hostname
  resolver.href = urlToResolve
  resolvedUrl  = resolver.href

  if oldBase?
    oldBase.href = oldHref
  else
    docHead.removeChild(tempBase)
  resolvedUrl

class Prerenderer
  nextPage: =>
    href = $(@nextPageSelector).attr("href")
    hostname = url('hostname', href)
    unless hostname? && hostname != ""
      href = absoluteUrl(href, url('hostname'))
    href

  prerender: =>
    nextPageUrl = @nextPage()
    return  unless nextPageUrl?
    console.log("Prerendering: #{nextPageUrl}")
    $("<link rel='prerender' href='#{nextPageUrl}'>").appendTo("head")

class MangaHere extends Prerenderer
  nextPageSelector: "a.next_page:first"

class MangaFox extends Prerenderer
  nextPageSelector: "a.next_page:first"

class MangaStream extends Prerenderer
  nextPageSelector: "#controls a.active + a"

prerenderer = {
  "mangahere.com": MangaHere
  "mangafox.me": MangaFox
  "mangastream.com": MangaStream
}[url('domain')]

new prerenderer?().prerender()
