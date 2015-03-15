---
layout: content
title: Resume
topNav: false
order: 2
grouped: true
---

removeDuplicates = (ar) ->
  if ar.length == 0
    return []
  res = {}
  res[ar[key]] = ar[key] for key in [0..ar.length-1]
  value for key, value of res

@h2 'Education'
@dl ->
  sortedEdu = @templateData.education.sort (a, b) -> b.start - a.start
  for e in sortedEdu
    @dt -> e.start + ' - ' + e.end
    @dd -> e.institution + if e.city? then (', ' + e.city + ', ' + e.state) else ''

sortedShows = @templateData.group_shows.sort (a, b) -> b.dateBegin - a.dateBegin
showYears = (item.dateBegin.getFullYear() for item in sortedShows)
uniqShowYears = removeDuplicates(showYears).sort (a, b) -> b - a

if @document.grouped
  @h2 'Grouped Group Shows'
  @dl ->
    for year in uniqShowYears
      if (uniqShowYears.indexOf(year) > 0) then @br ->
      @dt -> year + ' Shows:'
      for g in (item for item in sortedShows when item.dateBegin.getFullYear() is year)
        @dd ->  g.aventName + ', ' + g.venue + if g.venueCity? then (', ' + g.venueCity + ', ' + g.venueState) else ''
else
  @h2 'Selected Group Shows'
  @dl ->
    for g in sortedShows
      @dt -> g.dateBegin.getFullYear()
      @dd -> g.aventName + ', ' + g.venue + if g.venueCity? then (', ' + g.venueCity + ', ' + g.venueState) else ''

sortedAwards = @templateData.awards.sort (a, b) -> b.date - a.date
@h2 'Awards'
@dl ->
  for a in sortedAwards
    @dt -> a.date.getFullYear()
    @dd -> @raw a.award + ', ' + a.event + if a.sponsor? then (', ' + a.sponsor) else ''

sortedSolo = @templateData.solo_shows.sort (a, b) -> b.dateBegin - a.dateBegin
@h2 'One-Man Shows'
@dl ->
  for s in sortedSolo
    @dt -> s.dateBegin.getFullYear()
    @dd -> s.show + ', ' + s.gallery + ', ' + s.city + ', ' + s.state

@h2 'Corporate and Private Collections'
@ul ->
  for c in @templateData.collections
    @li -> c.collection + ', ' + c.city + ', ' + c.state + '.'

sortedBib = @templateData.bibliography.sort (a, b) -> b.date - a.date
@h2 'Bibliography'
@dl ->
  for b in sortedBib
    @dt -> b.date.getFullYear()
    @dd -> @raw b.citation

sortedAff = @templateData.affiliations.sort (a, b) -> b.start - a.start
@h2 'Affiliations'
@dl ->
  for aff in sortedAff
    @dt -> aff.start + ' - ' + aff.end
    @dd -> aff.affiliation + ', ' + @a href: aff.website, -> @raw aff.organization