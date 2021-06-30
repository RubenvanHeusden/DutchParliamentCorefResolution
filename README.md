

# DutchParliamentCorefResolution
This repository contains the codebase for the paper 'Neural Coreference Resolution for Dutch Parliamentary Documents', presented at the 31th CLIN conference
on Natural Language Processing for the Dutch Language. This repository is a fork of the [Dutch e2e implementation] of the [e2e model by Kenton Lee](https://arxiv.org/abs/1804.05392),
and also contains the dataset that was annotated during this project, as well as the parse trees that were used for the rulebased baseline model based on Alpino.

## Installation

Below are the installation instructions for this repository, these are largely based on he instructions of the original repository.

Requirements:
- Python 3.6 or 3.7
- pip
- tensorflow v2.0.0 or higher

In this repository, run:
```
pip install -r requirements.txt
pip install .
```

Alternatively, you can install directly from Pypi:
```
pip install tensorflow
pip install e2e-Dutch
```

## Changes

Although the version of the e2e model used in this research is mostly identical to the main repository, some changes have been made to the original repository,
the largest changes are mentioned below.

- In line with the [original e2e implementation](https://github.com/kentonl/e2e-coref), the option to include speaker metadata in the e2e model has been
added to this version of the e2e model in the 'coref_model.py' file.

- For the experiments concerning the genders of the actors mentioned in texts, the ability to add this information has been added, these changes
were also made in the 'coref_model.py' file.

- some minor changes were made in the 'train.py' file, including the ability to specify the number of epochs that the model should be trained for in
the form of the '--epochs' command line argument.

- As the method used for converting the files to jsonlines is custom because of the speaker information, a new train preparation script is added, 'my_train.sh',
and the 'download.py' script was also also slightly altered to remove downloads that are not necessary for this project.

