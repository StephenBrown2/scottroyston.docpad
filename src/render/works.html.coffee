---
layout: content
title: Works
topNav: false
future: true
order: 4
associatedFilesPath: 'art'
---

@div '#filters.button-group', ->
  @button 'data-filter': "*", 'show all'
  @button 'data-filter': ".sold", 'sold'
  @button 'data-filter': ".notsold", 'new works'
  @input '#quicksearch', type: 'text', placeholder: 'Search Paintings'

@br ->

@div '.isotope', ->
  @div '.grid-sizer', ->
  @div '.gutter-sizer', ->
  for file in @documentModel.getAssociatedFiles().toJSON()
    art = @templateData.art[file.basename]
    art.title = @templateData.getTitleCap(art.title)
    art.thw = art.title + ': ' + art.height + '⨯' + art.width
    soldclass = if art.sold then '.sold' else '.notsold'
    completedDate = @templateData.moment(art.completed_date).format("YYYY-MM-DD")
    sortDate = @templateData.moment(art.sold_date or art.completed_date).format("YYYY-MM-DD")
    @div '.art'+soldclass, 'data-sort-date': sortDate, ->
      @div '.wrapper', style: 'width:100%;', ->
        @div soldclass, ->
          @img '.image', alt: art.thw, src: @templateData.getThumbnail(file.url, 'medium')
        @a '.overlay', href: file.url, 'data-title': "<a href='#{file.url}'>#{art.thw}</a>", ->
          @h3 '.title', art.title
          @div '.description', ->
            @p -> @raw art.thw
