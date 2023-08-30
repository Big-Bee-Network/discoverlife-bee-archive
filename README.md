---
title: DiscoverLife Bee Checklist Archive
date: 2023-08-29
author: 
  - name: Poelen, JH
    role: archivist
    orcid: 0000-0003-3138-4118
abstract: |
  Digital biodiversity knowledge resources are increasingly available openly on the internet. Some of these potentially valuable resources are still actively curated, whereas others may have lost their maintenance/curators due to life events, funding, or a change in institutional policy. This data publication records a snapshot of an authoritive resource on the biodiversity of bees: Ascher, J. S. and J. Pickering. 2022. Discover Life bee species guide and world checklist (Hymenoptera: Apoidea: Anthophila). http://www.discoverlife.org/mp/20q?guide=Apoidea_species The reason for making this snapshot is to provide a citable data package containing the DiscoverLife Bee checklist for use in data synthesis and integration workflows. This data package is versioned and made verifiable using Preston, a biodiversity data tracker. With this publication, verifiable versions of the DiscoverLife Bee Checklist can now be cited and copied regardless of their physical location.
---

:warning: work in progress

# Introduction

Life on earth is sustained through a complex, and diverse, web of relationships between organisms and their environment. Now that digital storage, processing and networking technologies are within reach of (community) scientists, digital datasets documenting life on earth are increasingly available through the internet. However, evidence suggestions these network accessible digital datasets are likely to become unavailable due to linkrot, or change due to content drift [@elliott2020, @elliott2023]. To help reduce the risk of dataloss (or change) of valuable digital biodiversity datasets, content-based data tracking methods are applied to a commonly used digital biodiversity resource, the DiscoverLife Bee Checklist [@ascher2022].  

# Methods

To help version a snapshot of the DiscoverLife Bee Checklist, the following openly available tools were used: bash, Preston, grep, xmllint, cut, and xargs. With these tools the following archiving workflow was implemented:

~~~ { .bash .numberLines }
#!/bin/bash
#
# Makes an archive of DiscoverLife Bee checklist and associated species pages.
#

preston track "https://www.discoverlife.org/mp/20q/?act=x_checklist&guide=Apoidea_species&flags=HAS"\
 | grep hasVersion\
 | preston cat\
 | xmllint --html --xpath '//table//tr/td/i/a/@href' -\
 | cut --delimiter '"' -f2\
 | sed 's+^+https://www.discoverlife.org+g'\
 | xargs -L100 preston track  

# re-try previously failed web requests
preston ls -l tsv\
 | grep well-known\
 | grep hasVersion\
 | cut -f1\
 | xargs preston track
~~~

In this workflow, `preston track` in line 6 take a snapshot of an html pages that contains references to all bee species pages. The output of this tracking process is a stream of statement describing the tracking process in great detail. This output is fed into `grep hasVersion` using a linux pipe to selects only statements that associate the web location with the content that was found. Following, the associated content is streamed to stdout (or standard output) using `preston cat`. Following, URLs to species pages are generated from this streamed content by extracting a relevant html fragments using a xpath query. Then, this fragment is transformed into a URLs using string parsing (i.e., `cut --delimiter '"' -f2\`) and stream editing (i.e., `sed 's+^+https://www.discoverlife.org+g'`). The resulting URLs of the bees species pages are then tracked, in blocks on 100 URLs, by Preston. To help compensate for likely web request failures, the workflow was completed with a retry procedure for web locations that failed to successfully provide content initially.

# Results

The resulting archive can be used to access a versioned copy of discover life. The archive contains over 20k HTML pages that appear to be consistently structured. This consistent structure allow for scripts, or other computer programs, to automatically transform the data into a format suitable for reuse.



| url | content id |
| --- | --- |
| https://www.discoverlife.org/mp/20q/?act=x_checklist&guide=Apoidea_species&flags=HAS  | [hash://sha256/c4fc072c4977b8a55fc386402b6b2b3128f9de27349e61b369c887ce88e525e8](data/c4/fc/c4fc072c4977b8a55fc386402b6b2b3128f9de27349e61b369c887ce88e525e8) |
| https://www.discoverlife.org/mp/20q?search=Andrena+angustior  | [hash://sha256/3091d3029b4349a8b851cabd982da9d805d881ad0d334eac9c87d7c738ac676f](data/30/91/3091d3029b4349a8b851cabd982da9d805d881ad0d334eac9c87d7c738ac676f) |
| https://www.discoverlife.org/mp/20q?search=Andrena+angusticrus  | [hash://sha256/afe0f96a9c6d8e5aacddc00e79ef18eac4a8d48f2bec888d5d800feca2d37aae](data/af/e0/afe0f96a9c6d8e5aacddc00e79ef18eac4a8d48f2bec888d5d800feca2d37aae) |
: First three DiscoverLife Bee Checklist HTML resources tracked. The first contains the [index page of species pages](data/c4/fc/c4fc072c4977b8a55fc386402b6b2b3128f9de27349e61b369c887ce88e525e8). The following two are locations, and associated content identifiers, to species pages associated with [_Andrena angustior_](data/30/91/3091d3029b4349a8b851cabd982da9d805d881ad0d334eac9c87d7c738ac676f) and [_Andrena angusticrus_](data/af/e0/afe0f96a9c6d8e5aacddc00e79ef18eac4a8d48f2bec888d5d800feca2d37aae). This table was generated using `preston alias -l tsv | tail -n3 | tac | cut -f1-3 | mlr --hi --itsvlite --omd cat` . 

The current content identifiers of this versioned package of DiscoverLife Bee Checklist html resources are:

hash://sha256/86e7ce5f3df9a136a2957de5655261c007b95e217b2f0901988ffb39ee0230fe

hash://md5/55fe2b12ab306704ce332d97723b95af

Example 1. List Most Frequently Appearing Bee Subgenus Names 

To query for all subgenus names appearing in the pages, you can use:

~~~ { .bash .numberLines }
preston ls\
 --remote https://linker.bio,https://github.com/Big-Bee-Network/discoverlife-bee-archive/raw/main/data/,https://softwareheritage.org\
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


