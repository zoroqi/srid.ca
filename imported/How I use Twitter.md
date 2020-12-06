---
slug: twitter
date: 2020-11-30
---

Twitter is great for **social engagement**, as long as one has the discipline not to get sucked into its dark corners.

## Attention hygiene

Avoid ads and propaganda.[^clickbait]

- On desktop, use [Minimal Twitter](https://github.com/thomaswang/minimal-twitter)
- Be selective in who you allow into your attention
  - Create unique *Twitter Lists* for each domain. Ignore Home feed; use [TweetDeck]
- Liberally block accounts engaging in uncivil behaviour (see next section)

[TweetDeck]: https://tweetdeck.twitter.com/

## Affective hygiene

Be cognizant of trolls.

- Sometimes otherwise intelligent people may engage in malicious behaviour (eg. those who are "[woke](https://newdiscourses.com/tftw-woke-wokeness/)").
- Learn the distinction between criticism and toxic behaviour[^vibe].

[^vibe]: Appearing negative (eg: when criticizing something) is not the same thing as emanating a negative **vibe**. See [Experimental evidence of massive-scale emotional contagion through social networks](https://www.pnas.org/content/111/24/8788). Cf. [[2015101]]. 

## Memory hygiene

- [ ] Setup auto-delete of old tweets
  ```bash
  # TODO: Delete all but last N days of tweets
  # TODO: Run as systemd service
  nix-shell -p xsv -p t --run "t timeline -c -n 1000  \
    @srid_2012 | xsv select ID | tail -n +30 | \
    xargs t delete status -f"
  ```

[^clickbait]: Like any popular tech social media, Twitter forces both clickbait content and [[Mainstream Media Bias]] into your valuable attention.
