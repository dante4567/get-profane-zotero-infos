# get-profane-zotero-infos
Get "profane" information about my Zotero library, for example to be able to sort by number of pages of PDFs or file sizes.
Helps me in sanity-checking if some PDFs are much rather a book than just a note, given their sheer number of pages. And 

## Remark:
It may very well be that you can also set this within Zotero, the search for it took - for me - longer than the bash-script. 

## How it works:
Bash-script recursively traverses given zotero directory, gathers pdf-info (like number of pages, file size, file-paths) and exports the result as csv.



