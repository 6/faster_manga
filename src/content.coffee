absoluteUrl = (url, hostname) ->
  base = $("base")[0]
  base ?= $("<base>").appendTo("head")[0]
  base.href = hostname

  resolver = document.createElement('a')
  resolver.href = url

  resolver.href

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
