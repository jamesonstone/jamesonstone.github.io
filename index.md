---
layout: default
title: Blog
permalink: /
---

# Jameson Stone

Notes, archive posts, paintings, and small public records.

I use this site as a source-first blog: short Markdown posts live beside older archive material, paintings, projects, and contact details.

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
