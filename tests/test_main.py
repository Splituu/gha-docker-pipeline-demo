import logging
import pytest

universities = [
    {
        "name" : "University of Information Technology and Management in Rzeszow",
        "country" : "Poland",
        "domains" : [
            "wsiz.rzeszow.pl"
            ]
    },
    {
        "name": "State University of New York System",
        "country": "USA",
        "domains": [
            "sunycentral.edu"
        ]
    },
    {
        "name": "United Medical and Dental Schools, University of London",
        "country": "United Kingdom",
        "domains": [
            "umds.ac.uk"
        ]
    }
]

def filter_universities(universities, key, value):
    filtered = [uni for uni in universities if value.lower() in uni.get(key, "").lower()]
    if not filtered:
        logging.info(f"No universities matched the filter {key}={value}")
    return filtered

def test_filter():
    result = filter_universities(universities, key="country", value="Poland")
    assert len(result) == 1
    assert result[0]['name'] == "University of Information Technology and Management in Rzeszow"

def test_filter_no_match():
    result = filter_universities(universities, key="country", value="Germany")
    assert result == []

@pytest.mark.parametrize("key,value,expected_count", [
    ("country","Poland",1),
    ("country","USA",1),
    ("name","University",3),
    ("country","Germany",0)
])
def test_filter_param(key, value, expected_count):
    result = filter_universities(universities, key=key, value=value)
    assert len(result) == expected_count

def test_filter_missing_key():
    result = filter_universities(universities, key="state", value="somevalue")
    assert result == []

def test_filter_empty_list():
    result = filter_universities([], key="country", value="Poland")
    assert result == []