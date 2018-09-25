#!/bin/bash

RUN_PATH="$0"
TARGET_DIR=${RUN_PATH/sync.sh/}
for D in `find $TARGET_DIR/files -maxdepth 1 -type f -exec basename {} \;`
do
 cp ~/$D  $TARGET_DIR/files
done
