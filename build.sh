# #!/usr/bin/env bash

# List of websites to build
declare -a websites=("website-base", "website-retina")

# Distribute the content pages
python parse_content.py

for website in "${websites[@]}"
do
  echo "Building $website"

  # Copy images
  cp -r --no-clobber content/images $website/images
  # Copy bib generator script
  cp plugins/bib_writer.py $website/plugins/bib_writer.py
  # Copy literature
  cp content/diag.bib $website/content/diag.bib
  cp content/dict_pubs.json $website/content/dict_pubs.json

  cd $website
  pwd

  # Generate publications
  python plugins/bib_writer.py

  # Build pelican website
  pelican content -s publishconf.py

  # Go back to root directory
  cd ..
done