# Codebook v3: labeling school-threat news coverage

DATA 5500, Senior Design
Sara Choque Molina

Every article in the clean corpus gets exactly one of four labels. This document is the rule set used both for the model-assisted labeling and for the human verification, so that both follow the same definitions.

## What the label is for

The project measures how many articles about student threats against schools appear each day. The label decides whether an article counts toward that daily number. It is not a description of the article, it is a counting decision.

## The question that decides every case

> Does this article report, as current news, a threat of violence against schools?

The threat counts whether it was real, a hoax or later found to be false, and whether it was aimed at one school or at every school. What matters is that someone is reported as having actually made it. A viral post warning of shootings at schools across the country is a threat, so an article about a district reacting to that post reports a threat, even though nobody threatened that district.

If the answer is no, the label is `unrelated`, no matter how serious the article is. An attack is not a threat. Fear is not a threat. A threat is someone saying they are going to do something.

## Scope

Only articles about schools in the United States are labeled. Articles from outlets in other countries are removed from the corpus before labeling rather than labeled `unrelated`, so that `unrelated` stays a single clear category.

A threat means a threat of violence or harm. The word *threat* in a legal, political or figurative sense does not count. An article headlined "Librarians warn of threat to intellectual freedom" is not reporting a threat under this codebook.

The article must report the threat as current news. An article that recalls a threat from a previous year does not count, because it would add to the wrong day of the daily count.

The medium does not change anything. A threat written on a bathroom wall, posted on social media, phoned in, emailed or said out loud counts the same. What matters is that someone communicated an intention to do harm.

## The four labels

### 1. targeted_threat

The article reports a threat of violence against a named school, district, or person at a school.

Also counts: the lockdown, closure, investigation, arrest or charge that follows such a threat, since the article is reporting the threat through its consequences.

Examples from the corpus:

- A new Instagram account with "MGHS" and "shooter" in its name posted a threat against Maple Grove High School in Minnesota.
- Ionia Public Schools closed while officials investigated "a threat made toward Ionia Middle School" (article 38).

### 2. nontargeted_threat

The article reports student threats against schools with no specific school named.

Also counts: coverage of the viral trend itself (including warnings that the trend is circulating), schools adding security as a precaution in response to a threat that named no school, and opinion or analysis pieces about the trend.

Examples from the corpus:

- Southern California districts raised precautions over a TikTok warning whose messages "did not contain specific information about particular schools or locations" (article 21).
- Galesburg schools took precautions over the nationwide TikTok posts and the day ended without incident. No threat was made against Galesburg (article 16).

### 3. unrelated

The article is not about a threat of violence against a school.

Includes: threats against school board members or school staff in the context of board meetings, COVID school closures, attacks that already happened with no reported threat beforehand, and the word *threat* used in a legal or figurative sense.

Examples from the corpus:

- An FBI email shows the agency monitoring threats against school board members and teachers. These are adults threatened at board meetings, not students threatening a school.
- A high school lockdown that ended when the reported weapon turned out to be a vaping device. Nobody made a threat (article 30).

### 4. unusable

What was extracted is not a news story. Stray symbols, a weather listing, a page of advertising, an events calendar, a cookie notice.

These are extraction failures, not articles about an unrelated subject, and mixing them into `unrelated` hides how much of the corpus is broken. Articles labeled `unusable` are removed from the corpus rather than used for training.

This label was added after the first round of annotation, where three annotators independently flagged at least eight of 100 articles as not being news. Those were recorded as `unrelated` at the time.

## The rule that caused the most disagreement

In the first round, 19 of the 40 disagreements were between `targeted_threat` and `nontargeted_threat`. Fifteen of those 19 articles mention a district or a nationwide trend, which is the pattern behind the confusion: the article names a school and also describes a threat aimed at nobody in particular.

> **The question is not whether the article names a school. It is whether the threat was aimed at that school.** A school that only reacted, by adding security or writing to parents, is not the target.

Albuquerque Public Schools wrote to parents about a nationwide TikTok challenge and added security. APS is named, but nobody threatened APS. That article is `nontargeted_threat`.

A threat posted against Glacier High School put that school into a soft lockdown. That article is `targeted_threat`.

The test: after reading, can you say which school was threatened? If yes, `targeted_threat`.

The target counts even when the article does not spell it out. A student who threatens classmates at a named school has threatened that school.

## The rules that changed after the second round

The second annotation round, 40 articles labeled with the version of this codebook that added `unusable`, reached a Fleiss kappa of 0.274, down from 0.575. The confusion between `targeted_threat` and `nontargeted_threat` mostly disappeared, but 21 of the 27 disputed articles split between a threat label and `unrelated`. They fell into two groups, and both are now settled by the opening question:

1. **Coverage of the viral trend itself (11 articles).** A district adds police or warns parents because of the nationwide TikTok post. The old opening question, "Did someone make a threat?", led annotators to answer no for that district. The post was a threat against every school, so these articles are `nontargeted_threat`. Example: Idaho schools stepped up security in response to TikTok posts warning of shootings at schools around the country (article 111).

2. **False, rumored or prosecuted threats (10 articles).** A threat someone actually made counts even when it turned out to be a hoax, and so does an article about students charged for threats they made earlier (article 106). A rumor that someone might bring a weapon, with nobody reported as having made a threat, does not (article 114, Stewartville Middle School).

## Rules for hard cases

1. **Specific beats general.** An article that names a particular school as a target and also describes the nationwide trend is `targeted_threat`.

2. **A false threat is still a threat, but a rumor is not.** If someone made a threat against a named school and it was later found not credible, unfounded or a hoax, the article is `targeted_threat`. If it was aimed at no school in particular, it is `nontargeted_threat`. The label records what the article reports, not whether the threat was real. Most of the December 2021 TikTok threats were never found credible, so treating false threats as `unrelated` would remove most of the trend this project measures.

   The same holds for the arrests, charges and court cases that follow a threat, even when the threat itself turned out to be empty.

   A rumor is different. When the article only reports that students heard someone might bring a weapon, second-hand, and nobody is reported as having actually made a threat, the label is `unrelated`. The test: is there a person who said or posted it? If not, it is a rumor.

8. **A threat between students is not a threat against the school.** A student threatening another student in a fight or an argument is `unrelated`. A threat to carry out a shooting or a bombing at a school is a threat against the school, even when it names particular students.

9. **Warning signs are not a threat.** Worrying behavior before an attack, such as a violent drawing or a search for ammunition, is not someone saying they will do harm. An article about it is labeled by what else it reports.

3. **An attack is not a threat.** See the decision table below.

4. **Label the text, not the link.** Some links point to one story but return another, for example a link reading "school-threat-december-17" whose text is about a new superintendent. The label follows the extracted text, because that is what the model reads.

5. **Who made the threat does not change the label.** The label is decided by the target, which is a school, not by who made the threat. Most articles report that a threat was made without identifying anyone, so requiring the person to be a student would leave most of the corpus unlabelable.

6. **Where the threat came from does not change the label.** An article almost never states that a threat came from a viral trend, and it does not need to. The connection to the trend comes from the date of the article, not from the label.

7. **One label per article.** An article covering several threats is still labeled once.

## Decision table

Shootings and threats appear together often in this period, because the Oxford High School shooting happened on November 30, 2021, shortly before the TikTok trend.

| What the article reports | Label |
|---|---|
| Someone threatened a shooting against a named school | targeted_threat |
| Someone threatened a shooting, no school named | nontargeted_threat |
| A school named in the article only added security or wrote to parents | nontargeted_threat |
| Someone made a threat against a named school that was later found to be false | targeted_threat |
| Only a rumor that someone might bring a weapon; nobody is reported as making a threat | unrelated |
| A student threatened another student in a fight or argument | unrelated |
| Students were arrested or charged for threats against a school | targeted_threat |
| A shooting happened, no threat is reported | unrelated |
| A shooting happened, and threats against schools followed | label by the threat |
| A shooting happened elsewhere and local schools added security, nobody made a threat | unrelated |
| A school closed because it received a threat | targeted_threat |
| The article recalls a threat from a previous year | unrelated |
| The article analyzes the current wave of threats | nontargeted_threat |
| What was extracted is not a news story | unusable |

The fourth and fifth rows are the common case in this period. Articles about copycat threats discuss both the shooting and the threats, and are labeled by the threat, because the threat is what is being counted.

The sixth row is its opposite and is the trap. An article can describe schools, security and a shooting while nobody has made a threat at all.

## Verification

Each label proposed by the model is checked by hand against these rules. Disagreements between the proposed label and the verified label are recorded, and the disagreement rate is reported as the quality measure for the labeling step.
