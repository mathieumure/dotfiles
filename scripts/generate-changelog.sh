#!/bin/bash

if [ -n "$1" ]
then
  echo "# $1 changelog" > CHANGELOG.md
else
  echo "# $(basename $(pwd)) changelog" > CHANGELOG.md
fi

echo "" >> CHANGELOG.md

index=0
TAGS=()
for tag in `git for-each-ref --sort=-taggerdate --format '%(refname)' refs/tags | cut -d/ -f3`
do
   TAGS[index++]=$tag

done

for (( i=0 ; i<${#TAGS[@]} ; i++ ))
do
  tag=${TAGS[i]}
  previous=${TAGS[i+1]}
  
  echo "Generating changelog between $tag and ${previous:-first commit}"
  
  echo "## $tag" >> CHANGELOG.md
  echo "" >> CHANGELOG.md
  
  if [ -n "$previous" ]
  then
    git log --pretty=format:"- %s (%h)" $previous...$tag | grep -v -E "^- Merge" | sort >> CHANGELOG.md
  else
    git log --pretty=format:"- %s (%h)" $tag | grep -v -E "^- Merge" | sort >> CHANGELOG.md
  fi

  echo "" >> CHANGELOG.md

done

for (( idx=${#LOGS[@]}-1 ; idx>=0 ; idx-- ))
do
  item=${LOGS[idx]}
  cat ${item} >> CHANGELOG.md
done

echo "DONE"
