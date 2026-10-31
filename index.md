---
layout: default
title: Blog
permalink: /
home: true
---

<div class="home-page">
  <section class="home-hero" aria-labelledby="home-title">
    <h1 id="home-title">Jameson Stone</h1>
    <p class="tagline" data-random-tagline>Just put the AGI in the bag, bro.</p>
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

  <section class="home-section" id="site-family" aria-labelledby="site-family-title">
    <h2 id="site-family-title">Studios &amp; projects</h2>
    <p>Connected work across software, systems, and applied AI.</p>
    <ul class="project-list site-family-list">
      <li><strong><a href="https://reasoningmachines.co/">Reasoning Machines</a></strong><p>My independent studio for software, systems, and ideas.</p></li>
      <li><strong><a href="https://github.com/appliedsymbolics">Applied Symbolics</a></strong><p>Software for operational work. Explore <a href="https://ambientos.dev/">Ambient OS</a> and <a href="https://opencarrier.dev/">OpenCarrier</a>.</p></li>
      <li><strong><a href="https://openvital.co/">OpenVital</a></strong><p>AI applied to healthcare. The healthcare arm of Reasoning Machines.</p></li>
      <li><strong><a href="https://limina-dev.github.io/">Limina Dev</a></strong><p>Warehouse and logistics software, including mapr and sortr.</p></li>
      <li><strong><a href="https://github.com/spectral7-ltd">Spectral7</a></strong><p>Applied AI and operational software spanning logistics, communications, and knowledge systems.</p></li>
    </ul>
    <p class="site-family-research">Research tools: <a href="https://scout.jamesonstone.io/">Scout</a> &middot; <a href="https://narrowband.jamesonstone.io/">Narrowband</a></p>
    <p class="archive-link"><a href="{{ '/projects/' | relative_url }}">All projects &amp; source code</a></p>
  </section>
</div>
