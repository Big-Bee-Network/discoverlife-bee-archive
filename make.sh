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
