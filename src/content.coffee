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
    unless url('hostname', href)?
      href = absoluteUrl(href, url('hostname'))
    href

  prerender: =>
    nextPageUrl = @nextPage()
    return  unless nextPageUrl?
    console.log("Prerendering: #{nextPageUrl}")
    $("<link rel='prerender' href='#{nextPageUrl}'>").appendTo("head")

class MangaHere extends Prerenderer
  nextPageSelector: "a.next_page:first"

class MangaReader extends Prerenderer
  nextPageSelector: ".next a:first"

prerenderer = {
  "mangahere.com": MangaHere
  "mangareader.net": MangaReader
}[url('domain')]

new prerenderer?().prerender()
