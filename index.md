---
layout: default
title: Blog
permalink: /
---

# Jameson Stone

Put the AGI in the bag, bro.

## Latest Posts

<ul class="post-list">
  {% for post in site.posts limit: 5 %}
    <li>
      <time datetime="{{ post.date | date_to_xmlschema }}">{{ post.date | date: "%B %-d, %Y" }}</time>
      <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
      {% if post.excerpt %}
        <p>{{ post.excerpt | strip_html | truncate: 160 }}</p>
      {% endif %}
    </li>
  {% endfor %}
</ul>

[Read the full archive]({{ '/blog/' | relative_url }}).
