---
layout: content
title: Gallery
topNav: true
order: 4
associatedFilesPath: 'gallery'
---

for file in @documentModel.getAssociatedFiles().toJSON()
  @p ->
      @h3 ->
          @a href: file.url, -> file.title or file.name + ' - ' + @templateData[file.basename].arttitle
      @img src: @templateData.getThumbnail(file.url, 'medium'), alt: file.title or file.name
