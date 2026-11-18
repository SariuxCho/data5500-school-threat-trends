# Verification sheet

Short version of the codebook I used for the blind reading in notebook 09. Reread the top of this sheet at the start of every batch.

Note: when I did the reading this sheet said a rumor still counts as a threat. I fixed that line later so it matches codebook v3 (a rumor with nobody making a threat is `unrelated`).

---

## Step 1. The question that decides every article

> **Did someone make a threat, and does this article report it as current news?**

If no, the label is `unrelated`, no matter how serious the article is.

- An attack is not a threat.
- Fear is not a threat.
- A threat is someone saying they are going to do something.

## Step 2. If yes, one more question

> **Can you say which school was threatened?**

- Yes → `targeted_threat`
- No → `nontargeted_threat`

## The trap

A school being **named** is not the same as a school being the **target**.

A school that only reacted, by adding security or writing to parents, is not the target. That is `nontargeted_threat`, even though the school is named in the headline.

This was 19 of the 40 disagreements in round 1. It is the single most likely place to drift.

---

## Decision table

| The article reports | Label |
|---|---|
| A threat against a named school, district, or person at a school | `targeted_threat` |
| A school closed, locked down, or investigated because it received a threat | `targeted_threat` |
| A threat with no school named | `nontargeted_threat` |
| A named school only added security or wrote to parents | `nontargeted_threat` |
| A viral threat post circulating with no named target (the TikTok warning) | `nontargeted_threat` |
| Only a rumor that someone might bring a weapon; nobody is reported as making a threat | `unrelated` |
| Analysis or opinion about the current wave of threats | `nontargeted_threat` |
| A shooting happened, no threat reported | `unrelated` |
| A shooting happened and threats followed | label by the **threat** |
| A shooting elsewhere, local schools added security, nobody threatened | `unrelated` |
| A threat recalled from a previous year | `unrelated` |
| Threats against school board members or staff at board meetings | `unrelated` |
| COVID school closures | `unrelated` |
| The word *threat* used in a legal or figurative sense | `unrelated` |
| The text is not a news story at all | `unusable` |

The last three rows of the shooting group are the trap in reverse: an article can describe schools, security and a shooting while nobody has made a threat at all.

---

## Rules for hard cases

1. **Specific beats general.** Names a particular school as a target and also describes the nationwide trend → `targeted_threat`.
2. **A false threat is still a threat, but a rumor is not.** If someone made the threat, it counts even if it was a hoax or never credible. If the article only reports a second-hand rumor and nobody is reported as having made a threat, the label is `unrelated`. The test: is there a person who said or posted it? (Same rule as codebook v3.)
3. **Label the text, not the link.** Some urls point to one story and return another. Follow the text, because that is what the model read.
4. **Who made the threat does not change the label.** The target decides it.
5. **Where the threat came from does not change the label.** The link to the trend comes from the date, not the label.
6. **One label per article**, even if it covers several threats.
7. **The medium does not matter.** Bathroom wall, social media, phone call, email, spoken out loud, all the same.

---

## If the extraction is broken

Stray symbols, a weather listing, a page of advertising, an events calendar, a cookie notice: write `unusable`, not `unrelated`.

`unrelated` means the article is about something else. `unusable` means there is no article. Mixing them hides how much of the corpus is broken.

---

## The four values to type

```
targeted_threat
nontargeted_threat
unrelated
unusable
```

When you hesitate, write the reason in `notes`. Those notes are what explains the disagreements later.
