---
layout: content
title: Gallery
topNav: true
order: 4
associatedFilesPath: 'art'
---

for file in @documentModel.getAssociatedFiles().toJSON()
    if @templateData[file.basename].sold
        @p ->
            @h3 ->
                @a href: file.url, -> file.title or @templateData[file.basename].arttitle
            @img src: @templateData.getThumbnail(file.url, 'medium'), alt: file.title or file.name
