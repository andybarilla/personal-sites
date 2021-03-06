---
layout: default
title: The Knock Blockers
comments: true
---

<script type="application/ld+json">
{
  "@context": "http://schema.org",
  "@type": "MusicGroup",
  "name": "The Knock Blockers",
  "foundingLocation": {
    "@type": "City",
    "name": "Colorado Springs"
  },
  "foundingDate": "2016",
  "genre": "Ska",
  "email": "band@knockblockersska.com",
  "sameAs": [
    "https://twitter.com/knockblockers",
    "https://facebook.com/knockblockers",
    "https://soundcloud.com/knock-blockers",
    "https://reverbnation.com/knockblockers",
    "https://bandsintown.com/TheKnockBlockers"
  ]
}
</script>

<img class="logo" src="{{ site.baseurl }}/assets/kb_logo_1.png" alt="Knock Blockers" />

You found us! We're a ska band from Colorado Springs influenced by all the various waves and forms of ska. We're still writing and getting going so sign up below to stay notified of shows, news release, and other goodies.  We promise we won't harass you too much.

## Mailing List

{% include mailchimp.html %}

## Songs

<iframe width="100%" height="450" scrolling="no" frameborder="no" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/playlists/288598481&amp;auto_play=false&amp;hide_related=false&amp;show_comments=true&amp;show_user=true&amp;show_reposts=false&amp;visual=true"></iframe>

## Upcoming Shows

{% for event in site.data.bitevents %}* [{{event.title}}]({{event.facebook_rsvp_url}})<br />
  {{ event.formatted_datetime }}
  <script type="application/ld+json">
  {
    "@context": "http://schema.org",
    "@type": "Event",
    "name": "{{ event.title }}",
    "startDate": "{{ event.datetime }}",
    "url": "{{ event.facebook_rsvp_url }}",
    "location": {
      "@type": "Place",
      "name": "{{ event.venue.place }}",
      "address": "{{ event.venue.city }}, {{ event.venue.region }}"
    }
  }
  </script>
{% endfor %}

## Booking

For booking information, email [band@knockblockersska.com](mailto:band@knockblockersska.com).
