import requests
import logging
import os

API_URL = "http://universities.hipolabs.com/search"

def fetch_universities(filters: dict):
    try:
        req = requests.get(API_URL, params=filters, timeout=10)
        req.raise_for_status()
        data = req.json()
        universities = [uni['name'] for uni in data]
        if not universities:
            logging.warning("No universities found for this country") 
        return data
    except requests.exceptions.RequestException as e:
        logging.exception("Request failed")
        return []   
    
def filter_universities(universities, key, value):
    filtered = [uni for uni in universities if value.lower() in uni.get(key, "").lower()]
    if not filtered:
        logging.info(f"No universities matched the filter {key}={value}")
    return filtered

 
if __name__ == "__main__":
    country = os.environ.get("COUNTRY", "Poland")
    filters = {"country": country}
    data = fetch_universities(filters)
    filtered = filter_universities(data, key="name", value="University")
    for uni in filtered:
        print(uni['name'])
    print(len(filtered))