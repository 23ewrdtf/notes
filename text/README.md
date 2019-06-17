
Very dirty and stupid and "quick" way of searching Wikipedia and other sites.

#### Find MAC addresses

```(?i)(?:(?1):){5}([[:xdigit:]]{2})```

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
