---
date: 2020-10-15T14:49
---

# Ka

`ka` (originally announced in [[neuron-v1]]) is already functional but still in ongoing research phase (see [a short demo][twitdemo]). It uses a FRP ([[2012405]]) based reactive build system as the engine for managing notes, as well provides an interactive user interface to navigate the notes in an extensible structured fashion.

Project goals:

1. Fast build system
2. Extensible via plugins[^plugins]
3. UX optimized for navigating private notebooks

The first two goals in particular are relevant for preparing `ka` to eventually supplant rib and shake in [[neuron]].

## Early Access

[[neuron]] [sponsors] may get early access to `ka` source code, which can be utilized to run it locally on your notes. If you are a (tier 2+) sponsor, please [email me][email] your GitHub user name - for access to the repository.

## News

[[[z:zettels?tag=ka&timeline]]]

[sponsors]: https://github.com/sponsors/srid
[email]: mailto:srid@srid.ca
[twitdemo]: https://twitter.com/sridca/status/1317218846026117125

[^plugins]:
    Here's a potential list of plugins:
    - Task management (gather GFM checklists)
    - Flash cards
    - Self-tracking
    - Calendar of daily notes
    - Smart review of old cards (uses last-modified or git history)
    - Folgezettel linking (`[[[..]]]`) of neuron
    - [Link queries](https://neuron.zettel.page/link-query.html) of neuron
