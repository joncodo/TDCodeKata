# TDCodeKata
Coding interview

User stories and problem description can be found here: https://github.com/testdouble/contributing-tests/wiki/Bank-OCR-kata

## How to run this code on MAC

This code only works in isolation and it validated with unit tests. Run the following commands to see it in action! This code also uses ruby v2.7.0 as specified in the Gemfile. I suggest you use rvm to use this exact verison. (https://rvm.io/rvm/install)

```
gem install bundler
bundle install
rake
```

### Potential errors I came across while setting up the project

ERROR:

```
Fetching: bundler-2.1.4.gem (100%)
ERROR:  While executing gem ... (Gem::FilePermissionError)
    You don't have write permissions for the /Library/Ruby/Gems/2.3.0 directory.
```

Solution:

You need to get permissions on the ruby directory. NOTE: (You will likely need to change the path from '/Library/Ruby/Gems/2.3.0' to the correct path on your machine.)

```
sudo chown $USER /Library/Ruby/Gems/2.3.0
```

## Research

Looking for solutions online...

Looks like the original problem comes from here: https://codingdojo.org/kata/BankOCR/

Solution by someone else and the critique of others: https://codereview.stackexchange.com/questions/128513/solution-for-the-bankocr-kata

OCR = Optical Character Recognition

## Tasks

- Set up linter and basic test