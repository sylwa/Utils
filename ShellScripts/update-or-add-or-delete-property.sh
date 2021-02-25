#!/bin/bash

parseParameters() {
  while [[ "$#" -gt 0 ]]
  do
    case $1 in
      -f|--file)
        filePattern="$2"
        ;;
    esac
    shift
  done

  echo "filePattern: $filePattern"
}

function update-or-add-property()
{
# Ask the user for property to be updated
read -p 'Property name and value as in properties file: ' uservar

# Target directory where multiple property files whose property value(s) need to be updated/replaced.
tDir="$(pwd)"

filePattern=".properties"

parseParameters "$@"

# Reads each line and assigns value to variable _line, excluding all commented (starting with #) lines and all empty lines
for _line in "$uservar"; do
    _key=`echo "$_line" | cut -d '=' -f1`
    _value=`echo "$_line" | cut -d '=' -f2`
    echo "Retrieved property key: $_key with value: $_value"
    # Comment following 'for' loop if you are using 'tFile' variable.
    for _file in `find $tDir -type f -print | grep "${filePattern}"`; do
       echo "Updating target property file: $_file"
       sed -i "s/^$_key=.*/$_line/g" "$_file"
       # for those properties which have space between key and '=' sign.
       sed -i "s/^$_key[ \t]=.*/$_line/g" "$_file" 
	   if grep -q "^$_key" "$_file"; then
			echo "$_file contains $_key"
		else
			echo "$_file does not contain $_key"
			echo "$_line" >> "$_file"
		fi
    done   
done

}

function add-new-line-at-the-end()
{

# Target directory where multiple property files whose property value(s) need to be updated/replaced.
tDir="$(pwd)"

filePattern=".properties"

parseParameters "$@"

# Comment following 'for' loop if you are using 'tFile' variable.
for _file in `find $tDir -type f -print | grep "${filePattern}"`; do
   echo "Updating target property file: $_file"
   sed -i -z 's/$/\n/g' "$_file"
done   

}

function delete-a-property()
{
# Ask the user for property to be updated
read -p 'Property name and value as in properties file: ' uservar

# Target directory where multiple property files whose property value(s) need to be updated/replaced.
tDir="$(pwd)"

filePattern=".properties"

parseParameters "$@"

# Reads each line and assigns value to variable _line, excluding all commented (starting with #) lines and all empty lines
for _line in "$uservar"; do
    _key=`echo "$_line" | cut -d '=' -f1`
    _value=`echo "$_line" | cut -d '=' -f2`
    echo "Retrieved property key: $_key with value: $_value"
    # Comment following 'for' loop if you are using 'tFile' variable.
    for _file in `find $tDir -type f -print | grep "${filePattern}"`; do
       echo "Updating target property file: $_file"
       sed -i "/^$_key/d" "$_file"       
    done   
done


}

help() # Show a list of functions
{
    grep "^function" $0
}

if [ "_$1" = "_" ]; then
    help
	echo ""
	echo "To update/add property in <matching_string> files alone"
	echo -e "\tupdate-or-add-or-delete-property.sh update-or-add-property -f <matching_string>"
	echo "To add new line at end of <matching_string> files alone"
	echo -e "\tupdate-or-add-or-delete-property.sh add-new-line-at-the-end -f <matching_string>"
	echo "To delete a property in <matching_string> files alone"
	echo -e "\tupdate-or-add-or-delete-property.sh delete-a-property -f <matching_string>"
else
    "$@"
fi
