import json
import re
from bs4 import BeautifulSoup
from pathlib import Path
import requests
import os

def get_cached_html(url, cache_file='cached.html'):
    cache_dir = Path('cache')
    cache_dir.mkdir(exist_ok=True)
    
    cache_path = cache_dir / cache_file
    
    if cache_path.exists() and os.path.getsize(cache_path) > 0:
        with open(cache_path, 'r', encoding='utf-8') as f:
            return f.read()
    
    response = requests.get(url)
    response.raise_for_status()
    
    html_content = response.text
    with open(cache_path, 'w', encoding='utf-8') as f:
        f.write(html_content)
    
    return html_content


def parse_german_nouns(url, output_file='german_nouns.json'):
    html = get_cached_html(url)
    
    soup = BeautifulSoup(html, 'html.parser')
    
    body = soup.select_one(".post-body.entry-content")
    
    nouns = {}
    
    for div in body.select('div > span'):
        # 1. Time Die Zeit Die Zeiten
        text = div.get_text()
        tokens = text.split()
        is_uncountable = 'usually uncountable' in text or len(tokens) < 6
        german = tokens[3].lower()
        if german in nouns:
            # print(f'Found duplicate for {nouns[tokens[3]]} as {text}!')
            continue
        nouns[german] = {
                "english": tokens[1].lower(),
                "article": tokens[2].lower(),
                "plural": None if is_uncountable else tokens[5].lower()
            }
            

      
    with open(output_file, 'w', encoding='utf-8') as f:
        json.dump(nouns, f, ensure_ascii=False)
    
    print(f"Saved {len(nouns)} to {output_file}")

if __name__ == "__main__":
    url = "https://frequencylists.blogspot.com/2015/12/the-2000-most-frequent-german-nouns.html?m=1"  # Replace with the actual URL
    parse_german_nouns(url)