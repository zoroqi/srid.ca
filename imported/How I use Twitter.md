---
slug: twitter
---

Twitter is great for **social engagement**, as long as one has the discipline not to get sucked into its dark corners.

## Attention hygiene

Avoid ads and propaganda. Like any popular tech social media, Twitter forces both clickbait content and [[Mainstream Media Bias]] into your valuable attention.

- On desktop, use [Minimal Twitter](https://github.com/thomaswang/minimal-twitter)
- Be selective in who you allow into your attention
  - Create unique *Twitter Lists* for each domain. 
- Ignore Home feed; use [TweetDeck] with lists in columns.
  - Incidentally, Twitter's biased "fact-check" labels (see [[Bias in "fact-checking"]]) don't appear on TweetDeck.

[TweetDeck]: https://tweetdeck.twitter.com/

## Affective hygiene

Given the [experimental evidence of massive-scale emotional contagion through social networks](https://www.pnas.org/content/111/24/8788) (cf. [[2015101]]) - it is sensible, in regards to mental health, to avoid toxic behaviours on social media.

- Sometimes otherwise intelligent people may engage in malicious behaviour (eg. those who are "[woke](https://newdiscourses.com/tftw-woke-wokeness/)").
- Liberally block accounts engaging in uncivil behaviour

## Memory hygiene

There is no reason to leave a permanent trail of one's thoughts, as a significant amount of them tend to be transient and change over time. 

- Set up auto-delete of old tweets (see below)
- Tweet liberally, but incorporate them into my [[Zettelkasten]] well before auto-delete kicks in.

The idea being that Twitter will act only as a transient medium where as-yet-unexplored thoughts may linger in public, before getting integrated into one's "second brain" (that *is* permanent; and evolving over time).

### Auto-delete

- [ ] Improve this script
  ```bash
  # TODO: Delete all but last N days of tweets
  # TODO: Run as systemd service

  # Delete all but recent tweets
  nix-shell -p xsv -p t --run "t timeline -c -n 1000  \
    @srid_2012 | xsv select ID | tail -n +30 | \
    xargs t delete status -f"
  # Do the same for likes
  nix-shell -p xsv -p t --run "t favourites -c -n 1000  \
    @srid_2012 | xsv select ID | tail -n +30 | \
    xargs t delete favourite -f"
  ```
