This is a complete setup pipeline to end up with an encoder-attention-decoder system
on the speech recognition task [LibriSpeech 1000h](http://www.openslr.org/12/)
using [RETURNN](https://github.com/rwth-i6/returnn),
as it is described in our paper [Improved training of end-to-end attention models for speech recognition](https://arxiv.org/abs/1805.03294),
which yields very competitive results;
when used together with a LSTM language model, this is currently state-of-the-art.
See also ["WER are we"](https://github.com/syhw/wer_are_we) for a comparison.

This setup also includes the dataset download and preparation.

All the data will be created in a `data` subdirectory.
The raw dataset files will be downloaded to `data/dataset-raw` (about 58GB). This can be deleted once the dataset preparation is finished.
All the prepared dataset files will be in `data/dataset` (about 60GB).

Note that the dataset should be on a fast file system. NFS will make the training much slower!
(At our chair, we use NFS together with the [CacheManager software](https://github.com/pavelgolik/cache-manager).
 RETURNN has the option `use_cache_manager` in the `LibriSpeechCorpus` to use that.)

The RETURNN training/model config `returnn.config` is based on `../attention/exp3.ctc.config`
and adapted for the data pathes here.
See `../attention/scores` for reference what train/dev scores to expect,
and also what recognition word-error-rate (WER) to expect.

Training takes 37 min / epoch on average with a GTX 1080 Ti in our environment.
We train for 250 epochs. One epoch corresponds to 1/20 of the whole training data, thus the training sees the data over 12 times.
Note that the training is not deterministic, so there will be some slight variance in the results.

The recognition will automatically select a few interesting epochs (via cross validation scores).
Then it will select the best model by the best WER from the dev-other dataset.

You can also run an interactive demo with that final best model.

