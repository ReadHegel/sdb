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
VAL_DIR="$DST_DIR/val"

mkdir -p "$TRAIN_DIR" "$VAL_DIR"

echo "🔄 Renaming + splitting CelebA-HQ..."

i=0
for img in $(ls "$DST_DIR"/*.jpg | sort); do
  out_name="img_${i}.png"

  if (( i < 27000 )); then
    out_dir="$TRAIN_DIR"
  else
    out_dir="$VAL_DIR"
  fi

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
