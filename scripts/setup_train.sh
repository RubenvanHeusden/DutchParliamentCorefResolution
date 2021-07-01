#!/bin/bash
CONFIG_FILE=$1

# NOTE: This reguires a file in the style of the 'defaults.conf' to be inputted
# as the first argument so that the model can download the data, this can
# be altered to make it more understandable

extract_config() {
  pyhocon -f properties < $CONFIG_FILE | awk '/^'$1'/{print $3}'
}

dlx() {
  wget $1/$2
  tar -xvzf $2
  rm $2
}

TRAIN_FILE_JSON=`extract_config train_path`
TRAIN_FILE_CONLL=`extract_config conll_train_path`
DEV_FILE_JSON=`extract_config eval_path`
DEV_FILE_CONLL=`extract_config conll_eval_path`
DATAPATH=`extract_config datapath`

echo $TRAIN_FILE_JSON $TRAIN_FILE_CONLL $DEV_FILE_JSON $DEV_FILE_CONLL

# Removed the dependency to this library as we are using a different scorer
# TODO: I want to make a slight adjustment here, name just doing a minimize
# combined with the conll data to get the clusters for the existing jsonlines file
python e2edutch/minimize.py $TRAIN_FILE_CONLL -o $TRAIN_FILE_JSON
python e2edutch/minimize.py $DEV_FILE_CONLL -o $DEV_FILE_JSON

python scripts/char_vocab.py $TRAIN_FILE_JSON $DEV_FILE_JSON $DATAPATH/char_vocab.dutch.txt

# Filter word embeddings
python scripts/filter_embeddings.py -c $DATAPATH/fasttext.300.vec $TRAIN_FILE_JSON $DEV_FILE_JSON $DATAPATH/fasttext.300.vec.filtered

# Cache BERT embeddings
python scripts/cache_bert.py bertje $DATAPATH $TRAIN_FILE_JSON $DEV_FILE_JSON
