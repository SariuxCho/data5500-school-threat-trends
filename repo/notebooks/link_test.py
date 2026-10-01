"""
link_test.py  —  feasibility test for the DATA 5500 project.

Takes a random sample of article links from a GDELT export and checks how many
can still be downloaded and turned into readable text.

Usage:
    pip install trafilatura pandas
    python link_test.py articles_2016_clowns.csv
    python link_test.py articles_2021_tiktok.csv [sample_size]

Writes <input>_linktest.csv with one row per tested link.
"""

import sys
import time
import random

import pandas as pd
import trafilatura

SAMPLE_SIZE = 100     # how many links to test
PAUSE_SECONDS = 1.0   # wait between requests, to be polite to news sites


def main():
    if len(sys.argv) < 2:
        print("Usage: python link_test.py <csv file> [sample size]")
        sys.exit(1)

    path = sys.argv[1]
    n = int(sys.argv[2]) if len(sys.argv) > 2 else SAMPLE_SIZE

    df = pd.read_csv(path)
    if "url" not in df.columns:
        print(f"No 'url' column found. Columns are: {list(df.columns)}")
        sys.exit(1)

    urls = df["url"].dropna().unique().tolist()
    random.seed(42)                       # same sample every run, so results are reproducible
    sample = random.sample(urls, min(n, len(urls)))

    print(f"File: {path}")
    print(f"Total unique links: {len(urls):,}")
    print(f"Testing a random sample of {len(sample)}\n")

    rows = []
    for i, url in enumerate(sample, 1):
        ok, words, note = False, 0, ""
        try:
            html = trafilatura.fetch_url(url)
            if html is None:
                note = "could not download"
            else:
                text = trafilatura.extract(html)
                if not text:
                    note = "downloaded but no article text found"
                else:
                    ok = True
                    words = len(text.split())
        except Exception as e:                       # noqa: BLE001
            note = f"error: {type(e).__name__}"

        rows.append({"url": url, "ok": ok, "words": words, "note": note})

        status = f"OK  {words:>5} words" if ok else f"--  {note}"
        print(f"[{i:>3}/{len(sample)}] {status}")
        time.sleep(PAUSE_SECONDS)

    out = pd.DataFrame(rows)
    good = out[out["ok"]]

    print("\n" + "=" * 52)
    print("RESULT")
    print("=" * 52)
    print(f"Links tested:        {len(out)}")
    print(f"Downloaded and read: {len(good)}  ({len(good) / len(out):.0%})")
    if len(good):
        print(f"Median article length: {int(good['words'].median())} words")
        print(f"Shortest / longest:    {int(good['words'].min())} / {int(good['words'].max())} words")
        short = (good["words"] < 100).sum()
        print(f"Very short (<100 words, probably not usable): {short}")
    if len(good) != len(out):
        print("\nWhy the rest failed:")
        print(out[~out["ok"]]["note"].value_counts().to_string())

    out_path = path.replace(".csv", "_linktest.csv")
    out.to_csv(out_path, index=False)
    print(f"\nSaved details to: {out_path}")


if __name__ == "__main__":
    main()
