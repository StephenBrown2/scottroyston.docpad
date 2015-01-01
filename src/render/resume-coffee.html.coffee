---
layout: content
title: Resume
topNav: true
order: 2
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
###
@h2 'Selected Group Shows'
@dl ->
  sortedShows = @templateData.group_shows.sort (a, b) -> b.dateBegin - a.dateBegin
  for g in sortedShows
    @dt -> g.dateBegin.getFullYear()
    @dd -> g.aventName + ', ' + g.venue + if g.venueCity? then (', ' + g.venueCity + ', ' + g.venueState) else ''
###
sortedShows = @templateData.group_shows.sort (a, b) -> b.dateBegin - a.dateBegin
showYears = (item.dateBegin.getFullYear() for item in sortedShows)
uniqShowYears = removeDuplicates(showYears).sort (a, b) -> b - a

@h2 'Grouped Group Shows'
@dl ->
  for year in uniqShowYears
    if (uniqShowYears.indexOf(year) > 0) then @br ->
    @dt -> year + ' Shows:'
    for g in (item for item in sortedShows when item.dateBegin.getFullYear() is year)
      @dd ->  g.aventName + ', ' + g.venue + if g.venueCity? then (', ' + g.venueCity + ', ' + g.venueState) else ''
###

<h2>Awards</h2>
<dl>
<% sortedAwards = @awards.sort (a, b) -> b.date - a.date %>
<% for a in sortedAwards: %>
  <dt><%= a.date.getFullYear() %></dt>
  <dd><%= a.award %>, <% if a.website?: %><a href="<%- a.website %>"><% end %><%- a.event %><% if a.website?: %></a><% end %><% if a.sponsor?: %>, <%= a.sponsor %><% end %></dd>
<% end %>
</dl>

<h2>One-Man Shows</h2>
<dl>
<% sortedSolo = @solo_shows.sort (a, b) -> b.dateBegin - a.dateBegin %>
<% for s in sortedSolo: %>
  <dt><%= s.dateBegin.getFullYear() %></dt>
  <dd><%= s.show %>, <%= s.gallery %>, <%= s.city %>, <%= s.state %></dd>
<% end %>
</dl>

<h2>Corporate and Private Collections</h2>
<ul>
<% for c in @collections: %>
  <li><%= c.collection %>, <%= c.city %>, <%= c.state %>.</li>
<% end %>
</ul>

<h2>Bibliography</h2>
<dl>
<% sortedBib = @bibliography.sort (a, b) -> b.date - a.date %>
<% for b in sortedBib: %>
  <dt><%= b.date.getFullYear() %></dt>
  <dd><%- b.citation %></dd>
<% end %>
</dl>

<h2>Affiliations</h2>
<dl>
<% sortedAff = @affiliations.sort (a, b) -> b.start - a.start %>
<% for aff in sortedAff: %>
  <dt><%= aff.start %> - <%= aff.end %></dt>
  <dd><%= aff.affiliation %>, <a href="<%= aff.website %>"><%= aff.organization %></a></dd>
<% end %>
</dl>
###
