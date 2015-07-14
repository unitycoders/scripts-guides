#! /bin/bash
# Useful bash alises

# Create a tar.gz archive of the public_html folder
alias backup="tar cvpzf backup`date +%d%b%y`.tgz /home/webpigeon/public_html"
