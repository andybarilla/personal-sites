---
layout: default
title: Andy Barilla
---

Who the hell is <a href="about.html">Andy Barilla?</a>

|-----+---------+------------------------------|
|Date | Artists | Venue                        |
|-----+---------+------------------------------|
{% for event in site.data.bitevents %}|{{ event.strftime }} | <a href="{{event.facebook_rsvp_url}}">{{event.artistlist}}</a> | <a href="{{event.facebook_rsvp_url}}">{{ event.venue.place }}</a> |
{% endfor %}

