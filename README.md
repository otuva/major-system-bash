Calling script

```
./mnemonics.sh
```

Update

```
sudo apt update
```

Install dictionaries

```
sudo apt install hunspell-fr
sudo apt install hunspell-es
sudo apt install hunspell-tr
...
```

Create txt

```
unmunch /usr/share/hunspell/en_US.dic /usr/share/hunspell/en_US.aff
```

Gather dictionaries

```
wget https://raw.githubusercontent.com/dwyl/english-words/refs/heads/master/words.txt
wget https://raw.githubusercontent.com/mertemin/turkish-word-list/refs/heads/master/words.txt
```

Final dictionary operations

```
cat words_en.txt >> words_all.txt
cat words_tr.txt >> words_all.txt
tr '[:upper:]' '[:lower:]' < words_all.txt > words_unsorted.txt
sort words_unsorted.txt > words.txt
```