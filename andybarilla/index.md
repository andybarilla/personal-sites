---
layout: default
title: Andy Barilla
---

<div id="topstuff" markdown="1">

![Andy Barilla playing upright bass]({{ site.baseurl }}/assets/andy_barilla_bass_275x500.jpg){:.me}
I am **Andy Barilla**. I am a [musician](https://www.reverbnation.com/musician/andybarilla) and [geek](http://github.com/andybarilla).

[The Rhythm Ratz](http://therhythmratz.com) is my rockabilly and psychobilly band and [Tinker's Damn](http://tinkersdamnband.com/) is my cover band.

If you need to communicate with me or stalk me you can find me on [Twitter](https://twitter.com/bassburner) or [Facebook](https://facebook.com/andrew.p.barilla). You can also [email](mailto:bassburner@gmail.com) me.

</div>

|----------------------------------------------|
| My Upcoming Gigs                             |
|-----+---------+------------------------------|
|Date | Artists | Venue                        |
{% for event in site.data.bitevents %}|{{ event.strftime }} | <a href="{{event.facebook_rsvp_url}}">{{event.artistlist}}</a> | <a href="{{event.facebook_rsvp_url}}">{{ event.venue.place }}</a> |
{% endfor %}

