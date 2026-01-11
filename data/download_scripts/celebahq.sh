#!/bin/bash

DST_DIR="../datasets/celebahq"

set +e

mkdir -p ../packed/
mkdir -p ../datasets/

curl -L -o ../packed/celebahq.zip\
  https://www.kaggle.com/api/v1/datasets/download/badasstechie/celebahq-resized-256x256

unzip -q ../packed/celebahq.zip -d ../datasets/

# set up required structure

mv ../datasets/celeba_hq_256 "$DST_DIR"

TRAIN_DIR="$DST_DIR/train"
VAL_DIR="$DST_DIR/valid"

mkdir -p "$TRAIN_DIR" "$VAL_DIR"

echo "🔄 Renaming + splitting CelebA-HQ..."

i=0
out_dir="$TRAIN_DIR"

for img in $(ls "$DST_DIR"/*.jpg | sort); do
  if (( i == 27000 )); then
    out_dir="$VAL_DIR"
    i=0
  fi

  out_name="img_${i}.png"

  if (( i % 1000 == 0 )); then
      echo "$i images converted"
  fi

  # JPG → PNG + rename xD
  magick "$img" "$out_dir/$out_name"

  rm "$img"

  i=$((i+1))
done

echo "✅ Done!"
echo "Train images: $(ls "$TRAIN_DIR" | wc -l)"
echo "Val images:   $(ls "$VAL_DIR" | wc -l)"


rm ../packed/celebahq.zip
