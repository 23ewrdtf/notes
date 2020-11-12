
#### Find files

```find . -name "*.log" 2>/dev/null | grep text```

#### Find inside files

```grep -r --include "*.log" texthere .```

#### Find MAC addresses
##### Go to /var/logs/

```cd /var/logs/```

##### Find all gz files and extract them

```find . -name '*.gz' -execdir gunzip '{}' \;```

#### Find MAC addresses in all files and dont show duplicates and other crap.

```grep -hoiIs '[0-9A-F]\{2\}\(:[0-9A-F]\{2\}\)\{5\}' * | sort -u```

#### Find words ending with ly

```\b(\w*ly)\b```

#### Find all between quotes

```(?<=(["']\b))(?:(?=(\\?))\2.)*?(?=\1)```

#### Find words between quotes including quotes

```"(.*?[^\\])"```

#### Enclose found words in %

```\n%\1%\n```

#### Adding \n before text will add a Enter before that line. 

In notepad++ find `01-03-2019` and replace with `\n01-03-2019`

#### Sort text in Notepad++

```Edit> Line Operations> Sort Lines as Integer Ascending```

#### Remove text duplicates in Notepad++

```Find: ^(.*?)$\s+?^(?=.*^\1$) and replace with nothing```

#### Find two words in one line

```screen[^\r\n]+open```

#### Below will return result found via regex

```$&```

#### When you format your e-book for Amazon or Smashwords and want to keep Italics. Using Word.

Replace all Italics with `QQQ<your text>QQQ`
`Find all Italics and replace with QQQ^&QQQ`

Replace all `QQQ<your text>QQQ` back to Italics
`Find all (QQQ)(*)(QQQ) and replace with \2 and Ctrl-I to set Italics. Enable wildcards.`



