---
layout: default
title: Blog
permalink: /
home: true
---

<div class="home-page">
  <section class="home-hero" aria-labelledby="home-title">
    <h1 id="home-title">Jameson Stone</h1>
    <p class="tagline">Put the AGI in the bag, bro.</p>
  </section>

  <section class="home-section" aria-labelledby="latest-posts">
    <h2 id="latest-posts">Latest Posts</h2>

    <ol class="post-list post-list--home">
      {% for post in site.posts limit: 5 %}
        <li>
          <article class="post-card">
            <time datetime="{{ post.date | date_to_xmlschema }}">{{ post.date | date: "%B %-d, %Y" }}</time>
            <h3><a href="{{ post.url | relative_url }}">{{ post.title }}</a></h3>
            {% assign excerpt_text = post.excerpt | strip_html | strip %}
            {% if excerpt_text != "" %}
              <p>{{ excerpt_text | truncate: 160 }}</p>
            {% endif %}
          </article>
        </li>
      {% endfor %}
    </ol>

    <p class="archive-link"><a href="{{ '/blog/' | relative_url }}">Read the full archive</a></p>
  </section>
</div>
