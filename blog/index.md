---
layout: default
title: Blog
permalink: /blog/
---

# Blog

Short notes and migrated archive posts.

<ul class="post-list">
  {% for post in site.posts %}
    <li>
      <time datetime="{{ post.date | date_to_xmlschema }}">{{ post.date | date: "%B %-d, %Y" }}</time>
      <a class="post-list__title" href="{{ post.url | relative_url }}">{{ post.title }}</a>
      {% if post.archive %}
        <span class="note note--archive">Archive</span>
      {% endif %}
    </li>
  {% endfor %}
</ul>
