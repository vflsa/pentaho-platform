#!/bin/bash

declare -r dir_changes="src/main/changes"
declare -r dir_java="src/main/java"
declare -ar file_list_to_chg=("org/pentaho/platform/web/http/ConfigurationAdminNonOsgiProxy" "org/pentaho/platform/web/http/api/resources/FileResource")
declare -ar file_list_to_add=()

# Loop through files to change...
for file in "${file_list_to_chg[@]}"
do
  #echo "$file"
  rm $dir_changes'/'$file'_new.java'
  cp $dir_java'/'$file'.java' $dir_changes'/'$file'_new.java'
  rm $dir_java'/'$file'.java'
  diff3 -m $dir_changes'/'$file'_new.java' $dir_changes'/'$file'_ori.java' $dir_changes'/'$file'_orichg.java' > $dir_java'/'$file'.java'
  
  retVal=$?
  if [ $retVal -ne 0 ]; then 
    echo "Error - Conflict trying to change class '$file.java'"
    exit $retVal 
  else
    echo "Successfully changed class '$file.java'"
  fi
done

# Loop through files to add...
for file in "${file_list_to_add[@]}"
do
  #echo "$file"
  cp $dir_changes'/'$file'.java' $dir_java'/'$file'.java'
  
  retVal=$?
  if [ $retVal -ne 0 ]; then 
    echo "Error - Failed creating new class '$file.java'"
    exit $retVal 
  else
    echo "Successfully added new class '$file.java'"
  fi
done

exit $retVal 
