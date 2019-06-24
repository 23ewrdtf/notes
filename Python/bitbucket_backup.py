import os
import datetime
import tarfile
import time
from datetime import datetime
import shutil
import pdb

print("")
print("******************************************")
print("* Downloading list of repos...")
print("******************************************")
print("")
result = os.popen("curl -s -S --user username:apppassword https://bitbucket.org/api/1.0/user/repositories | jq '.[].slug' | sed 's/\"//g'").read()

backupdir = "/backups/bitbucket/"
repo_url = "https://bitbucket.org/<ORG_NAME>/temp.git" #set var to something, it will be changed later.
now = datetime.now() # current date and time
date_time = now.strftime("%m_%d_%Y_%H_%M_%S")
date_only = now.strftime("%m_%d_%Y")

os.system("export GIT_MERGE_AUTOEDIT=no")
os.system("git config --global core.mergeoptions --no-edit")

logfile = open("/backups/bitbucket/{}.txt".format(date_time), "a")

for repo in result.split('\n'):
    repo = repo.strip('\r')
    backupdir = "/backups/bitbucket/{}".format(repo)
    if not os.path.isdir(backupdir):

        repo_url = "https://username:apppassword@bitbucket.org/<ORG_NAME>/{}.git".format(repo) 
        backupdir = "/backups/bitbucket/{}".format(repo)

        logfile.write("{} {} cloning started.\n".format(date_time,repo))

        print("")
        print("******************************************")
        print("* Cloning {}...".format(repo))
        print("******************************************")
        print("")
        os.system("git clone --progress {} {}".format(repo_url,backupdir))

        logfile.write("{} {} cloned.\n".format(date_time,repo))

        print("")
        print("******************************************")
        print("* Waiting 10s to give BitBucket a break...")
        print("******************************************")
        print("")
        time.sleep(10)

    else:

        repo_url = "https://username:apppassword@bitbucket.org/<ORG_NAME>/{}.git".format(repo) 
        backupdir = "/backups/bitbucket/{}".format(repo)

        print("")
        print("******************************************")
        print("* {} already cloned, pulling.".format(repo))
        print("******************************************")
        print("")

        logfile.write("{} {} already cloned, pulling.\n".format(date_time,repo))

        os.system("git -C {} pull".format(backupdir))

        logfile.write("{} {} pulled.\n".format(date_time,repo))

        print("")
        print("******************************************")
        print("* Waiting 10s to give BitBucket a break...")
        print("******************************************")
        print("")
        time.sleep(10)
