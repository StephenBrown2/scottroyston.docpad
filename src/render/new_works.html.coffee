---
layout: content
title: New Works
topNav: true
order: 3
associatedFilesPath: 'art'
newstyle: false
---

@text '* Click on image to enlarge'

if @document.newstyle
  @div '.isotope', ->
    @div '.grid-sizer', ->
    @div '.gutter-sizer', ->
    for file in @documentModel.getAssociatedFiles().toJSON()
      art = @templateData.art[file.basename]
      art.title = @templateData.getTitleCap(art.title)
      art.thw = art.title + ': ' + art.height + '⨯' + art.width
      if ! art.sold
        @div '.art', ->
          @div '.wrapper', style: 'width:100%;', ->
            @img '.image', alt: art.thw, src: @templateData.getThumbnail(file.url, 'medium')
            @a '.overlay', href: file.url, 'data-title': "<a href='#{file.url}'>#{art.thw}</a>", ->
              @h3 '.title', art.title
              @div '.description', ->
                @p -> @raw art.thw
else
  @div '#gallery', class: 'js-isotope', 'data-isotope-options': '{ "itemSelector": ".oldart", "masonry": { "columnWidth": 250 } }', ->
    for file in @documentModel.getAssociatedFiles().toJSON()
      art = @templateData.art[file.basename]
      art.title = @templateData.getTitleCap(art.title)
      art.thw = art.title + ': ' + art.height + ' ⨯ ' + art.width
      if ! art.sold
        @div '.oldart .oldwrapper', ->
          @a href: file.url, class: 'old', title: art.thw, ->
            @img src: @templateData.getThumbnail(file.url, { w: 144, h: 144 })
          @br ->
          @strong ->
            @a href: file.url, style: 'color: black; text-decoration:none;', ->
              art.title
          @br ->
          @raw art.height + ' ⨯ ' + art.width