#/bin/bash

DIR=$(find . -depth 1 -type d)
echo "$DIR" $(basename "$DIR")
BASE_DIR_NAME=$(basename "$DIR")


find "$DIR" -name "*.db" -exec rm {} \;
find "$DIR" -name "*.url" -exec rm {} \;
find "$DIR" -name "*.ion" -exec rm {} \;
find "$DIR" -name "*.txt" -exec rm {} \;

# rm "$DIR"/*.db
# rm "$DIR"/*.url

zip -r -9 "$BASE_DIR_NAME.zip" "$DIR"

# for i in (find ?.bmp); mv $i "0$i"; end
# for i in (find . *); sips -s format public.jpeg $i --out $i.jpg;end