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

#### Git Flow if you have Arcanist and Phabricator

##### Before development

`git checkout master`

`git pull origin master`

`git status`

If local changes:

git push origin master

##### Local development

Branch from master

`git checkout -B <branch name>`

Make changes.

Add new files

git add <filename>

Commit changes.

git commit -m 'Headline'  -m 'message'  -m 'message' 

Create diff against “master” branch.

Preview in browser:

`arc diff --preview <master branch> --browse`

Preview in nano:

`arc diff`

##### Update local dev branch if needed

Make changes.

Add new files.

git add <files>

git commit

arc diff --update <revision id> -m <message>

Or using the UI

arc diff --preview <master branch> 

##### Update “master” branch

`git checkout master`

`git status`

Patch branch

`arc patch D[XY] --nobranch`

`git push`

`git branch -D <local dev branch>`
