#Search Words

A tool for analyzing search keyterm data from Google Analytics.

Search Words splits keyterms into their component words and recomputes search volume on a word-by-word basis. Search Words also combines plural versions of words with their singular form if the singular form appears in the list, and removes common low-meaning words (e.g. "a", "an", "of", etc.).

## Use
1. Upload a CSV file with keyterm data (keyterms in first column, search volume in the second).
2. Hit Submit.
3. Click the download link to grab a copy of the processed file.

## Installation
	gem install bundler
	cd ../Search-Words
	bundle
	
	# To start up the server
	rackup
	
## Example
### Input
	|-------------------------------|
	| Search Phrase        | Hits   |
	| ==============================|
	| Lemurs               | 1,000  |
	| durham bulls         | 500    |
	| bull fighting        | 100    |
	| lemur dance          | 2,000  |
	| Durham               | 700    |
	| How to catch a lemur | 35     |
	|-------------------------------|
### Output
	|-------------------------------|
	| Search Word          | Hits   |
	| ==============================|
	| durham               | 1,200  |
	| bull                 | 600    |
	| fighting             | 100    |
	| lemur                | 3,035  |
	| dance                | 2,000  |
	| catch                | 35     |
	|-------------------------------|