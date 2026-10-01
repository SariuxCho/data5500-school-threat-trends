# Classifying and Comparing Viral School-Threat Trends on Social Media, 2016–2026

**DATA 5500 – Senior Design · Sara Choque Molina**

This project studies how viral social media trends turn into threats against schools, and
builds a method that separates news coverage of real student threats from coverage that
uses similar words but is about something else.

The main case is the **December 2021 TikTok school threat trend** (Nov 15, 2021 – Jan 14, 2022).
The 2016 "Killer Clown" craze and the 2026 "Cat in the Hat" trend are used later to test
whether a model trained on one trend still works on another.

---

## Why this is not just a keyword count

A simple keyword search for school threats is unreliable. Depending on the period,
between 15% and 52% of the matching articles are not about student threats at all. They are
about threats against school board members, pandemic lockdowns, or real shootings.
Measuring and removing that noise is the core of the project.

| Case period | Articles | Student threats | Unrelated |
|---|---|---|---|
| Killer Clown (Sep–Nov 2016) | 6,392 | 5,195 | 19% |
| TikTok trend (Nov 2021–Jan 2022) | 4,995 | 4,266 | 15% |
| Devious Licks (Aug–Oct 2021) | 3,296 | 1,568 | 52% |
| Cat in the Hat (Aug–Sep 2026) | 1,356 | 1,148 | 15% |

---

## Data source

All article data comes from the **GDELT Global Knowledge Graph**, a free public database of
online news, queried through Google BigQuery.

- Dataset: [GDELT 2.0 on Google Cloud](https://console.cloud.google.com/marketplace/product/the-gdelt-project/gdelt-2-events)
- Table used: `gdelt-bq.gdeltv2.gkg_partitioned`
- Field definitions: [GKG 2.1 codebook (PDF)](http://data.gdeltproject.org/documentation/GDELT-Global_Knowledge_Graph_Codebook-V2.1.pdf)

The dataset is public, so anyone with a Google account can open it and run the queries in
`queries/` without needing access to this project.

---

## Repository structure

```
queries/      One .sql file per query, each with a header explaining what it does
data/raw/     The CSV files those queries produced
data/processed/   Deduplicated corpus and extracted article text (added in Week 5)
notebooks/    Numbered notebooks, meant to be read in order
docs/         Codebook, project plan, design document
figures/      Charts used in the reports and the poster
```

---

## Notebooks

| Notebook | What it does | Status |
|---|---|---|
| `01_link_test.ipynb` | Tests how many article links still work, to decide the main case | Done |
| `02_extract_text.ipynb` | Downloads the article text with Trafilatura and removes duplicate stories | Week 5 |
| `03_labeling.ipynb` | Model-assisted labeling with human verification | Week 6 |
| `04_models.ipynb` | TF-IDF with logistic regression, then DistilBERT | Weeks 7–8 |

---

## Results so far

**The main case was chosen by testing, not by preference.** A random sample of 100 article
links from each candidate period was downloaded to see how many still work:

| | 2016 Clowns | 2021 TikTok |
|---|---|---|
| Links that still work | 33% | **64%** |
| Median article length | 232 words | **319 words** |
| Estimated usable stories | ~1,200 | **~2,100** |

The 2021 trend has nearly twice the usable text, so it became the main case.

**Three other limitations were measured directly:**

- 23% of the 2021 rows are the same story republished on another site, so stories are
  deduplicated before labeling.
- Article links die over time, and the ones that survive favor larger outlets, which biases
  the corpus away from small local news.
- Location is available for 52% of the 2021 articles, covering 51 states.

---

## How to reproduce

1. Open [BigQuery](https://console.cloud.google.com/bigquery) with any Google account. The
   free sandbox is enough and does not require billing.
2. Run any file from `queries/`. Every query filters on `_PARTITIONTIME`, which keeps the
   scanned data small and stays inside the free monthly tier.
3. Save the result as CSV. The matching file in `data/raw/` shows what the output looks like.
4. Run the notebooks in order.

---

## Tools

Python 3 with pandas, Trafilatura, spaCy, scikit-learn, Hugging Face Transformers, SHAP, and
matplotlib. Everything runs in Jupyter on a laptop. Google Colab is a fallback if model
training is slow.
