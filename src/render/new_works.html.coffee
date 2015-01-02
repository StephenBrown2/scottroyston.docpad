---
layout: content
title: New Works
topNav: true
order: 3
associatedFilesPath: 'art'
---

@div '.isotope', ->
  @div '.grid-sizer', ->
  @div '.gutter-sizer', ->
  for file in @documentModel.getAssociatedFiles().toJSON()
    art = @templateData.art[file.basename]
    art.title = @templateData.getTitleCap(art.title)
    art.thw = art.title + ': ' + art.height + 'x' + art.width
    if ! art.sold
      @div '.art', ->
        @div '.wrapper', style: 'width:100%;', ->
          @img '.image', alt: art.thw, src: @templateData.getThumbnail(file.url, 'medium')
          @a '.overlay', href: file.url, 'data-title': "<a href='#{file.url}'>#{art.thw}</a>", ->
            @h3 '.title', art.title
            @div '.description', ->
              @p -> art.thw

###
for file in @documentModel.getAssociatedFiles().toJSON()
    if ! @templateData[file.basename].sold
        @h3 ->
            @a href: file.url, -> @templateData.getTitleCap(@templateData[file.basename].arttitle)
        @img src: @templateData.getThumbnail(file.url, 'medium'), alt: file.title or file.name
        if @templateData[file.basename].height
            @br ->
            @raw @templateData[file.basename].height + ' ⨯ ' + @templateData[file.basename].width
        @br ->
###