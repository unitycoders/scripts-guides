---
layout: page
title: About
permalink: /about/
---

This website is a compiled version of the scripts and guides repository curated
by Unity Coders. It features articles and scripts which have been written and
curated by our members.

## How to contribute
Unity Coders members have commit access to the [repository][git-repo]. You can create
articles or add scripts by committing directly to it. Articles should be written
in a markup language compatible with [Jeykll][jekyll-posts].

## Who has contributed?
<ul>
{% for member in site.data.authors %}
<li><a href="https://github.com/{{ member.github }}">{{ member.name }}</a></li>
{% endfor %}
</ul>

[git-repo]: https://github.com/unitycoders/scripts-guides
[jekyll-posts]: http://jekyllrb.com/docs/posts/
