---
title: DiscoverLife Bee Checklist Archive
date: 2023-08-29
author: 
  - Poelen, JH
---

# discoverlife-bee-archive

This archive provides a snapshot of:

Ascher, J. S. and J. Pickering. 2022.
Discover Life bee species guide and world checklist (Hymenoptera: Apoidea: Anthophila).
http://www.discoverlife.org/mp/20q?guide=Apoidea_species

The reason for making this snapshot is to provide a citable data package containing the DiscoverLife Bee checklist. This data package is versioned and made verifiable using [Preston](https://github.com/bio-guoda/preston). 

The current content identifiers of this versioned package are:

hash://sha256/86e7ce5f3df9a136a2957de5655261c007b95e217b2f0901988ffb39ee0230fe

hash://md5/55fe2b12ab306704ce332d97723b95af

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
```

and, finally, the following command was run to re-try previously failed web requests:

~~~
preston ls -l tsv\
 | grep well-known\
 | grep hasVersion\
 | cut -f1\
 | xargs preston track
~~~

yielding an archive with all bee species pages resolved. 
