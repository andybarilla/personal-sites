---
layout: default
title: Tinker's Damn
comments: true
---

## Upcoming Shows

{% for event in site.data.bitevents %}* [{{event.venue.name}}]({{event.facebook_rsvp_url}})<br />
  {{ event.formatted_datetime }}
{% endfor %}

## Find Us

* [Facebook](http://facebook.com/tinkersdamnband)
* [Twitter](http://twitter.com/tinkersdamnband)
* [YouTube](https://www.youtube.com/channel/UC-62Xkpp556fVzHziz5NLXw)
* [Reverbnation](https://www.reverbnation.com/tinkersdamnband)

## Booking

For booking information, email [band@tinkersdamnband.com](mailto:band@tinkersdamnband.com).