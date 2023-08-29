---
title: DiscoverLife Bee Checklist Archive
date: 2023-08-29
author: 
  - Poelen, JH
---

# Abstract

This archive provides a snapshot of:

Ascher, J. S. and J. Pickering. 2022.
Discover Life bee species guide and world checklist (Hymenoptera: Apoidea: Anthophila).
http://www.discoverlife.org/mp/20q?guide=Apoidea_species

The reason for making this snapshot is to provide a citable data package containing the DiscoverLife Bee checklist. This data package is versioned and made verifiable using [Preston](https://github.com/bio-guoda/preston). 


# Introduction



# Methods

This archive was compiled using:

~~~
#!/bin/bash
#
# Makes an archive of DiscoverLife Bee checklist and associated species pages.
#

preston track "https://www.discoverlife.org/mp/20q/?act=x_checklist&guide=Apoidea_species&flags=HAS"\
 | grep hasVersion\
 | preston cat\
 | xmllint --html --xpath '//table//tr/td/i/a/@href' -\
 | cut --delimiter '"' -f2 | sed 's+^+https://www.discoverlife.org+g'\
 | xargs -L100 preston track  
~~~

and, finally, the following command was run to re-try previously failed web requests:

~~~
preston ls -l tsv\
 | grep well-known\
 | grep hasVersion\
 | cut -f1\
 | xargs preston track
~~~

yielding an archive with all bee species pages resolved.

# Results

The resulting archive can be used to access a versioned copy of discover life. The archive contains HTML pages that appear to be consistently structured. This consistent structure allow for scripts, or other computer programs, to automatically transform the data into a format suitable for reuse.

The current content identifiers of this versioned package are:

hash://sha256/86e7ce5f3df9a136a2957de5655261c007b95e217b2f0901988ffb39ee0230fe

hash://md5/55fe2b12ab306704ce332d97723b95af

Example 1. List Most Frequently Appearing Bee Subgenus Names 

To query for all subgenus names appearing in the pages, you can use:

~~~
preston ls\
 --remote https://linker.bio,https://github.com/Big-Bee-Network/discoverlife-bee-archive/raw/main/data/,https://softwareheritage.org
 --anchor hash://sha256/86e7ce5f3df9a136a2957de5655261c007b95e217b2f0901988ffb39ee0230fe\
 -l tsv\
 | grep -v well-known\
 | grep hasVersion\
 | cut -f3\
 | preston cat\
 | grep "Subgenus:"\
 | sed 's+<br>.*<i>++g'\
 | sed 's+</i></a></small>++g'\
 | sort\
 | uniq -c\
 | sort -nr\
 | head
~~~

yields the top 10 most frequent appearances of (likely) subgenus names in the bee species pages ordered by decreasing frequency:

~~~
   5600 None
    765 Uncertain
    448 Perdita
    403 Dialictus
    259 Hemihalictus
    209 Eutricharaea
    179 Ctenonomia
    161 Homalictus
    152 Anthidium
    151 Lasioglossum
~~~

# Discussion


