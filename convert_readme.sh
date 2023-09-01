#!/bin/bash
#
# Exports README.md to html and pdf formats using pandoc.
#
# uses xelatex to render pdf /
# to install on debian/ubuntu: 
#   sudo apt install texlive-xetex
#


set -x

function export_to {
  cat README.md\
  | pandoc --pdf-engine=xelatex --standalone --toc --citeproc -t "${1}"\
  > "README.${1}"
  echo converted ["${PWD}/README.md"] to ["${PWD}/README.${1}"]
}

export_to pdf
export_to html
export_to docx
