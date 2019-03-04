
Very dirty and stupid and "quick" way of searching Wikipedia and other sites.

#### Find words ending with ly

```\b(\w*ly)\b```

#### Find words between quotes including quotes

```"(.*?[^\\])"```

#### Enclose found words in %

```\n%\1%\n```

#### Adding \n before text will add a Enter before that line. 

In notepad++ find `01-03-2019` and replace with `\n01-03-2019`
