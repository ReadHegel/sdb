#!/bin/bash

set +e

mkdir -p ../packed/
mkdir -p ../datasets/

curl -L -o ../packed/div2k-dataset-for-super-resolution.zip\
  https://www.kaggle.com/api/v1/datasets/download/takihasan/div2k-dataset-for-super-resolution

unzip -q ../packed/div2k-dataset-for-super-resolution.zip -d ../datasets/
mv ../datasets/Dataset/ ../datasets/div2k 

# remove unessesery
rm -r DIV2K_train_LR_bicubic DIV2K_train_LR_bicubic_X4 DIV2K_valid_LR_bicubic DIV2K_valid_LR_bicubic_X4

rm ../packed/div2k-dataset-for-super-resolution.zip
