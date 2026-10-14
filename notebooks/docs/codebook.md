# Codebook v2: labeling school-threat news coverage

DATA 5500, Senior Design
Sara Choque Molina

Every article in the clean corpus gets exactly one of three labels. This document is the rule set used both for the model-assisted labeling and for the human verification, so that both follow the same definitions.

## What the label is for

The project measures how many articles about student threats against schools appear each day. The label decides whether an article counts toward that daily number. It is not a description of the article, it is a counting decision.

## The question that decides every case

> Did someone make a threat, and does this article report it as current news?

If the answer is no, the label is `unrelated`, no matter how serious the article is. An attack is not a threat. Fear is not a threat. A threat is someone saying they are going to do something.

## Scope

Only articles about schools in the United States are labeled. Articles about schools in other countries are removed from the corpus before labeling rather than labeled `unrelated`, so that `unrelated` stays a single clear category.

A threat means a threat of violence or harm. The word *threat* in a legal, political or figurative sense does not count. An article headlined "Librarians warn of threat to intellectual freedom" is not reporting a threat under this codebook.

The article must report the threat as current news. An article that recalls a threat from a previous year does not count, because it would add to the wrong day of the daily count.

## The three labels

### 1. targeted_threat

The article reports a threat of violence against a named school, district, or person at a school.

Also counts: the lockdown, closure, investigation, arrest or charge that follows such a threat, since the article is reporting the threat through its consequences.

Examples from the corpus:

- A new Instagram account with "MGHS" and "shooter" in its name posted a threat against Maple Grove High School in Minnesota.
- Two minors were arrested for a shooting threat directed at Cheney Middle School in West Fargo, North Dakota, which moved the school to online learning for the day.

### 2. nontargeted_threat

The article reports student threats against schools with no specific school named.

Also counts: coverage of the viral trend itself, rumors circulating without a named target, schools adding security as a precaution in response to a threat that named no school, and opinion or analysis pieces about the trend.

Examples from the corpus:

- Bethel police in Connecticut stationed extra patrols at the town's schools in response to the nationwide TikTok trend for December 17. No credible threat against Bethel was found.
- Illinois parents were warned about threats against all schools nationwide after a TikTok post circulated.

### 3. unrelated

The article is not about a threat of violence against a school.

Includes: threats against school board members or school staff in the context of board meetings, COVID school closures, attacks that already happened with no reported threat beforehand, and the word *threat* used in a legal or figurative sense.

Examples from the corpus:

- An FBI email shows the agency monitoring threats against school board members and teachers. These are adults threatened at board meetings, not students threatening a school.
- Hundreds of students at Sydney schools are isolating after COVID-19 exposures. The article matches the search on the word lockdown but reports no threat.

## Decision table

Shootings and threats appear together often in this period, because the Oxford High School shooting happened on November 30, 2021, shortly before the TikTok trend. This table settles those cases.

| What the article reports | Label |
|---|---|
| Someone threatened a shooting against a named school | targeted_threat |
| Someone threatened a shooting, no school named | nontargeted_threat |
| A shooting happened, no threat is reported | unrelated |
| A shooting happened, and threats against schools followed | label by the threat |
| A shooting happened elsewhere and local schools added security as a precaution, nobody made a threat | unrelated |
| A school closed because it received a threat | targeted_threat |
| The article recalls a threat from a previous year | unrelated |
| The article analyzes the current wave of threats | nontargeted_threat |

The fourth row is the common case in this period. Articles about copycat threats discuss both the shooting and the threats, and are labeled by the threat, because the threat is what is being counted.

The fifth row is its opposite and is the trap. An article can describe schools, security and a shooting while nobody has made a threat at all.

## Rules for hard cases

1. **Specific beats general.** An article that names a particular school and also describes the nationwide trend is `targeted_threat`.

2. **A false or rumored threat is still a threat.** If a threat was aimed at a named school and later found not credible, the article is `targeted_threat`. The label records what the article reports, not whether the threat was real.

3. **An attack is not a threat.** See the decision table above.

4. **Label the text, not the link.** Some links point to one story but return another, for example a link reading "school-threat-december-17" whose text is about a new superintendent. The label follows the extracted text, because that is what the model reads.

5. **Who made the threat does not change the label.** The label is decided by the target, which is a school, not by who made the threat. Most articles report that a threat was made without identifying anyone, so requiring the person to be a student would leave most of the corpus unlabelable.

6. **Where the threat came from does not change the label.** An article almost never states that a threat came from a viral trend, and it does not need to. The connection to the trend comes from the date of the article, not from the label.

7. **One label per article.** An article covering several threats is still labeled once.

## Verification

Each label proposed by the model is checked by hand against these rules. Disagreements between the proposed label and the verified label are recorded, and the disagreement rate is reported as the quality measure for the labeling step.
