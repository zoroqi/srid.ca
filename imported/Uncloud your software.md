---
slug: uncloud
date: 2020-11-02T16:51
---

The **goal** of this project is to eliminate one's dependency on external services beyond one's control, notably Google, such that no matter what these technology companies do, one retains one's *data* for lifetime.

I'm currently dependent on Google for the following services. If Google chooses to [lock my account indefinitely](http://web.archive.org/web/20201102161748/https://www.businessinsider.com/google-users-locked-out-after-years-2020-10) I'd permanently lose access to my data. So it is important to find replacements.

Replacement software should be either self-hostable or be desktop software that works locally (with the data synchronized using something like [Syncthing](https://syncthing.net/)).

## Areas

### DNS

**Importance**: High

- [ ] Using Google Domains at the moment. I have quite a few domains, and this might be a tricky to do right ... 

### Email

**Importance**: Low 

Email has to be hosted by somebody else for reliability, but to minimize the damage use **your own domain**, as well use a **local email client** to store email archives locally. 

I went with continuing to use Gmail, by configuring its "send as" address to use my domain address (whilst using Gmail's smtp addredss), as well setting up an email alias in DNS for receiving email. In this way, if Google terminates my account, I can simply redirect my DNS to use a new email provider, with past email still archived locally and potentially imported into this new provider.

### Passwords

**Importance**: High

- [ ] Find a solution with sync.
  - Explore `pass` + `gpg`
  
### Docs (spreadsheets)

- [ ] Find a spreadsheet software, or design a custom app, for accounts tracking.
  - Research [OnlyOffice](https://github.com/ONLYOFFICE/DesktopEditors)

## See also

- [Zulip thread](https://funprog.srid.ca/random/going-back-to-free-software.html)