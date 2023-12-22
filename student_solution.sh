
#!/bin/bash

path=$1

cd $path
for file in `ls`;
do
if [ -f $file ];then
extension=${file##*.}
if [ -z $extension ];then
mv $file "$path/misc"
else
  
case "$file" in

*.jpg|*.jpeg|*.png|*.gif)
mkdir "$path/$extension"
mv "$file"  "$path/$extension"
echo "$file" 
;;
*.txt|*.pdf|*.doc|*.docx)
mkdir "$path/$extension"
mv "$file" "$path/$extension"
echo "$file"
;;
*.mp4|*.avi)
mkdir "$path/$extension"
mv "$file" "$path/$extension"
echo "$file"
;;
*)
mkdir "$path/misc"
mv "$file" "path/$extension"
;;
esac
fi
fi 

done
