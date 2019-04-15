Adding current kubectl context into a terminal prompt

`sudo nano ~/kube-prompt.sh`

```
#!/bin/bash

__kube_ps1()
{
    # Get current context
    CONTEXT=$(cat ~/.kube/config | grep "current-context:" | sed "s/current-context: //")

    if [ -n "$CONTEXT" ]; then
        echo "(k8s: ${CONTEXT})"
    fi
}
```


`sudo nano ~/.bash_profile`

```
export PATH=$HOME/bin:$PATH

NORMAL="\[\033[00m\]"
BLUE="\[\033[01;34m\]"
YELLOW="\[\e[1;33m\]"
GREEN="\[\e[1;32m\]"

source ~/kube-prompt.sh

export PS1="${BLUE}\W ${GREEN}\u${YELLOW}\$(__kube_ps1)${NORMAL} \$ "
```




