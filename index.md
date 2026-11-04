---
layout: default
title: Blog
permalink: /
home: true
---

<div class="home-page">
  <section class="home-hero" aria-labelledby="home-title">
    <div class="home-hero__text">
      <p class="eyebrow">Writing · software · art</p>
      <h1 id="home-title">Jameson<br> Stone<span class="home-period">.</span></h1>
      <p class="tagline" data-random-tagline>Just put the AGI in the bag, bro.</p>
      <a class="home-text-link" href="#latest-posts">Explore the writing <span aria-hidden="true">↓</span></a>
    </div>
    <figure class="home-art">
      <a href="{{ '/paintings/' | relative_url }}" aria-label="Explore paintings: Continuity of Complexity">
        <img src="{{ '/assets/images/paintings/continuity-home.jpg' | relative_url }}" alt="Blue, white, and charcoal brushstrokes in Continuity of Complexity" width="1100" height="825" fetchpriority="high">
      </a>
      <figcaption><span>Continuity of Complexity</span><a href="{{ '/paintings/' | relative_url }}">Paintings <span aria-hidden="true">↗</span></a></figcaption>
    </figure>
  </section>

  <section class="home-writing" aria-labelledby="latest-posts">
    <div class="home-section-heading">
      <h2 id="latest-posts">Latest Posts</h2>
      <a class="home-text-link" href="{{ '/blog/' | relative_url }}">Read the full archive <span aria-hidden="true">↗</span></a>
    </div>
    <ol class="post-list post-list--home">
      {% for post in site.posts limit: 5 %}
        <li{% if forloop.first %} class="home-featured"{% endif %}>
          <article class="post-card">
            <div class="post-card__meta">
              {% if forloop.first %}<span class="eyebrow">Latest essay</span>{% endif %}
              <time datetime="{{ post.date | date_to_xmlschema }}">{{ post.date | date: "%B %-d, %Y" }}</time>
            </div>
            <h3><a href="{{ post.url | relative_url }}">{{ post.title }}</a></h3>
            {% assign excerpt_text = post.excerpt | strip_html | normalize_whitespace | strip %}
            {% if excerpt_text.size < 30 %}
              {% assign excerpt_text = post.content | strip_html | remove_first: "tl;dr:" | normalize_whitespace | strip %}
            {% endif %}
            {% if excerpt_text != "" %}
              <p>{{ excerpt_text | truncate: 160 }}</p>
            {% endif %}
            {% if forloop.first %}<a class="post-card__read" href="{{ post.url | relative_url }}" aria-label="Read {{ post.title | escape }}">Read essay <span aria-hidden="true">↗</span></a>{% endif %}
          </article>
        </li>
      {% endfor %}
    </ol>
  </section>

  <aside class="home-studio" id="site-family" aria-labelledby="studio-title">
    <div>
      <p class="eyebrow">Beyond the writing</p>
      <h2 id="studio-title"><a href="{{ '/reasoning-machines/' | relative_url }}">[reasoning machines] <span aria-hidden="true">↗</span></a></h2>
    </div>
    <p>Studios &amp; projects.<br>Connected work across software, systems, and applied AI.</p>
  </aside>
</div>
