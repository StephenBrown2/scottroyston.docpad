---
layout: content
title: New Works
topNav: true
order: 3
associatedFilesPath: 'art'
---

for file in @documentModel.getAssociatedFiles().toJSON()
    if ! @templateData[file.basename].sold
        @h3 ->
            @a href: file.url, -> @templateData.getTitleCap(@templateData[file.basename].arttitle)
        @img src: @templateData.getThumbnail(file.url, 'medium'), alt: file.title or file.name
        if @templateData[file.basename].height
            @br ->
            @raw @templateData[file.basename].height + ' ⨯ ' + @templateData[file.basename].width
        @br ->
