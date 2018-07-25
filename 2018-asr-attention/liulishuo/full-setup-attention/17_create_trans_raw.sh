#!/bin/bash

set -exv
returnndir=/Users/lls/Works/returnn
train_dir="/Users/lls/Works/seq2seq_on_openasr_01/data_h100"
valid_dir="/Users/lls/Works/seq2seq_on_openasr_01/test_h10"
test_dir=${valid_dir}

# This is just needed to calculate the final word-error-rate (WER).
for s in "train ${train_dir}" "valid ${valid_dir}" "test ${test_dir}" ; do
    prefix=$(echo ${s} | awk -F ' ' '{printf $1}')
    path=$(echo ${s} | awk -F ' ' '{printf $2}')

    if test -s ./dataset/$prefix.trans.raw; then
      echo "$prefix exists already"
      continue
    fi

    ${returnndir}/tools/dump-dataset-raw-strings.py \
        --dataset "{'class':'LLSDatasetWav', 'bpe':{'bpe_file':'./dataset/trans.bpe.codes', 'vocab_file':'./dataset/trans.bpe.vocab'}, 'path':'${path}', 'audio':{}, 'prefix': '${prefix}'}" --out dataset/$prefix.trans.raw

done

wc -l ./dataset/*.trans.raw

#test $(wc -l data/dataset/dev-clean.trans.raw | awk {'print $1'}) -eq 2705
#test $(wc -l data/dataset/dev-other.trans.raw | awk {'print $1'}) -eq 2866
#test $(wc -l data/dataset/test-clean.trans.raw | awk {'print $1'}) -eq 2622
#test $(wc -l data/dataset/test-other.trans.raw | awk {'print $1'}) -eq 2941
#test $(wc -l data/dataset/train-clean.trans.raw | awk {'print $1'}) -eq 132555
#test $(wc -l data/dataset/train-other.trans.raw | awk {'print $1'}) -eq 148690
