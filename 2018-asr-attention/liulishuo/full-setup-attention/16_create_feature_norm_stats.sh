#!/bin/bash

set -ex

returnndir=/Users/lls/Works/returnn
train_dir="/Users/lls/Works/seq2seq_on_openasr_01/data_h100"
valid_dir="/Users/lls/Works/seq2seq_on_openasr_01/test_h10"
test_dir=${valid_dir}

mydir=$(pwd)
cd ./dataset

test -s stats.mean.txt && test -s stats.std_dev.txt && echo "stats.*.txt files already exist, exit" && exit

# 'seq_ordering':'random' just to have a better estimate of remaining time.
# Takes around 10h for me.
# bpe stuff not really needed here, just to make it load.

${returnndir}/tools/dump-dataset.py \
  "{'class':'LLSDatasetWav', 'bpe':{'bpe_file':'trans.bpe.codes', 'vocab_file':'trans.bpe.vocab'}, 'path':'${train_dir}', 'audio':{}, 'prefix': 'train', 'seq_ordering':'random'}" \
  --endseq -1 --type null --dump_stats stats

test -s stats.mean.txt && test -s stats.std_dev.txt
