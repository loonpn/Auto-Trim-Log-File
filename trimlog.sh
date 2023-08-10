#!/bin/sh
#   Copyright 2023 Steven
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#
# This script takes a list of directories as arguments and checks the size of all *.log files in them
# If the file size is greater than 128KB, it deletes all but the last 10 lines of the file

# Loop through the arguments
for dir in "$@"; do
  # Check if the argument is a valid directory
  if [ ! -d "$dir" ]; then
    echo "Invalid directory: $dir"
    continue
  fi

  # Find all *.log files in the directory
  find "$dir" -type f -name "*.log" | while read file; do
    # Get the file size in bytes
    file_size=$(stat -c %s "$file")

    # Convert 128KB to bytes
    max_size=$((128 * 1024))

    # Compare the file size with the maximum size
    if [ $file_size -gt $max_size ]; then
      # Delete all but the last 10 lines of the file
      tail -n 10 "$file" > tmp.txt
      mv tmp.txt "$file"
      echo "File size reduced to $(stat -c %s "$file") bytes: $file"
    else
      echo "File size is within limit: $file_size bytes: $file"
    fi
  done
done
