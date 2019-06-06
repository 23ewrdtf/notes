#### Set your user name and email address.

```git config --global user.email <email address>```

#### Create folder, enter it and Download a reppository to it from github/bitbucket

```
mkdir <directory>
cd <directory>
git clone <https://bitbucket.org/....>
```

#### Set branch master as active

```git checkout master```

#### Create a new branch via web and use below command to fetch and make it active

```git fetch && git checkout <branch name>```

#### Show active branch

```git branch```

#### Show file permissions in numerical format

```stat -c '%A %a %n' *```

#### Add newly created file

```git add <file name>```

#### Commit changes

```git commit -m "Message ie. changed/added a file etc"```

#### Push changes

```git push```

#### Extract Repositories names from BitBucket

```
curl -s -S --user username:password https://bitbucket.org/api/1.0/user/repositories | jq '.[].name'
```
