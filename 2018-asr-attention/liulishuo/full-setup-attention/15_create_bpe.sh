#!/bin/bash

set -ex
mydir=$(pwd)

train_dir="/Users/lls/Works/seq2seq_on_openasr_01/data_h100"
valid_dir="/Users/lls/Works/seq2seq_on_openasr_01/test_h10"
test_dir=${valid_dir}

if ! [ -d "./dataset" ] ; then
    mkdir ./dataset
fi

cd ./dataset

test -s train-trans-all.txt || { $mydir/tools/collect-train-text.py "${train_dir}/text" > train-trans-all.txt; }
wc -l train-trans-all.txt
#test $(wc -l train-trans-all.txt | awk {'print $1'}) -eq 281241

test -s trans.bpe.codes || $mydir/subword-nmt/learn_bpe.py --input train-trans-all.txt --output trans.bpe.codes --symbols 10000

test -s trans.bpe.vocab || \
	$mydir/subword-nmt/create-py-vocab.py --txt train-trans-all.txt --bpe trans.bpe.codes --unk "<unk>" \
	--out trans.bpe.vocab

