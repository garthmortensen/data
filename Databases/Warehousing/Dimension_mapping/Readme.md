# # Dimension Mapping

## Milestone 2

Garth Mortensen
2020.12.03

These are the steps for completing Milestone 2.

### Setup repo and workspace

Check username and email

```bash
git config user.name
11900-Garth

git config user.email 
xxx@email.com
```

Create bare repo, then validate it was successfully created. This is essentially an offline Github.com that you can share with collaborators.

```bash
mkdir repo
cd repo
git init --bare Team-09-11900-Garth.git
cd Team-09-11900-Garth.git

ls -lah
total 11K
drwxr-xr-x 1 morte 197609   0 Nov 21 09:13 ./
drwxr-xr-x 1 morte 197609   0 Nov 21 09:20 ../
-rw-r--r-- 1 morte 197609 104 Nov 21 09:13 config
-rw-r--r-- 1 morte 197609  73 Nov 21 09:13 description
-rw-r--r-- 1 morte 197609  23 Nov 21 09:13 HEAD
drwxr-xr-x 1 morte 197609   0 Nov 21 09:13 hooks/
drwxr-xr-x 1 morte 197609   0 Nov 21 09:13 info/
drwxr-xr-x 1 morte 197609   0 Nov 21 09:13 objects/
drwxr-xr-x 1 morte 197609   0 Nov 21 09:13 refs/
```

Looks good. Create work repo, then validate it was successfully created.

```bash
cd ../../
mkdir work
cd work
git init
cd .git/

 ls -lah
total 11K
drwxr-xr-x 1 morte 197609   0 Nov 21 09:19 ./
drwxr-xr-x 1 morte 197609   0 Nov 21 09:19 ../
-rw-r--r-- 1 morte 197609 130 Nov 21 09:19 config
-rw-r--r-- 1 morte 197609  73 Nov 21 09:19 description
-rw-r--r-- 1 morte 197609  23 Nov 21 09:19 HEAD
drwxr-xr-x 1 morte 197609   0 Nov 21 09:19 hooks/
drwxr-xr-x 1 morte 197609   0 Nov 21 09:19 info/
drwxr-xr-x 1 morte 197609   0 Nov 21 09:19 objects/
drwxr-xr-x 1 morte 197609   0 Nov 21 09:19 refs/
```

Looks good. Test to see if my connection string is setup correctly.

```bash
cd ../

$ ls -lah "$PWD/../repo/Team-09-11900-Garth.git"
total 11K
drwxr-xr-x 1 morte 197609   0 Nov 21 09:13 ./
drwxr-xr-x 1 morte 197609   0 Nov 21 09:20 ../
-rw-r--r-- 1 morte 197609 104 Nov 21 09:13 config
-rw-r--r-- 1 morte 197609  73 Nov 21 09:13 description
-rw-r--r-- 1 morte 197609  23 Nov 21 09:13 HEAD
drwxr-xr-x 1 morte 197609   0 Nov 21 09:13 hooks/
drwxr-xr-x 1 morte 197609   0 Nov 21 09:13 info/
drwxr-xr-x 1 morte 197609   0 Nov 21 09:13 objects/
drwxr-xr-x 1 morte 197609   0 Nov 21 09:13 refs/
```

Connect this work repo to the to bare repo. 

```bash
$ git remote add origin "$PWD/../repo/Team-09-11900-Garth.git"
```

Per [this](https://stackoverflow.com/questions/9162271/fatal-not-a-valid-object-name-master) SO post, I need to commit before being able to proceed to the next step of setting up branches. 

> Git creates a master branch once you've done your first commit. There's nothing to have a branch for if there's no code in the repository.

Before committing, we must first add files. Here, I'll add the folders, but you are still required to add files before branching.

```bash
$ git commit -m "initial commit, required a file before branching allowed"
```

### Create branches

In addition to master branch, we need a Final branch and a dev branch. 

```bash
git branch Team_09_M1_Final_Submission
git branch dev-11900-Garth

git checkout dev-11900-Garth
```

Add your working files per requirements, then stage and commit.

```bash
$ git add .
$ git commit -m "adding mapping xlsx and pdfs. 2 mappings remain incomplete."
[dev-11900-Garth ca76ce8] adding mapping xlsx and pdfs. 2 mappings remain incomplete.
 6 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 Team_09_M2_Final_Submission/Team_09_M2_D1_Dimension_Mapping_metadata/Team_09_M2_D1_Dimension_Mapping_PRODUCT.pdf
 create mode 100644 Team_09_M2_Final_Submission/Team_09_M2_D1_Dimension_Mapping_metadata/Team_09_M2_D1_Dimension_Mapping_SALES_ORG.pdf
 create mode 100644 Team_09_M2_Final_Submission/Team_09_M2_D1_Dimension_Mapping_metadata/support/Team_09_M2_D1_Dimension_Mapping_DEALER.xlsx
 create mode 100644 Team_09_M2_Final_Submission/Team_09_M2_D1_Dimension_Mapping_metadata/support/Team_09_M2_D1_Dimension_Mapping_PACKAGE.xlsx
 create mode 100644 Team_09_M2_Final_Submission/Team_09_M2_D1_Dimension_Mapping_metadata/support/Team_09_M2_D1_Dimension_Mapping_PRODUCT.xlsx
 create mode 100644 Team_09_M2_Final_Submission/Team_09_M2_D1_Dimension_Mapping_metadata/support/Team_09_M2_D1_Dimension_Mapping_SALES_ORG.xlsx
```

Having committed my changes, I'll check the log.

```bash
$ git log
commit ca76ce8c6df16114371133dfc1cf627bb5dd51ce (HEAD -> dev-11900-Garth)
Author: 11900-Garth <xxx@email.com>
Date:   Sat Dec 5 09:04:58 2020 -0600

    adding mapping xlsx and pdfs. 2 mappings remain incomplete.

commit b524c25cfc535826b17b627fbc9cb06a997c8983 (master, Team_09_M1_Final_Submission)
Author: 11900-Garth <xxx@email.com>
Date:   Sat Dec 5 08:58:02 2020 -0600

    initial commit, required a file before branching allowed
```

Looks good.

### Merge dev into master

```bash
git checkout master
git merge dev-11900-Garth
```

### Push all repos to remote

Now push all of my branches to remote.

```bash
$ git branch -a
  Team_09_M1_Final_Submission
  dev-11900-Garth
* master

$ git push origin master
Enumerating objects: 18, done.
Counting objects: 100% (18/18), done.
Delta compression using up to 4 threads
Compressing objects: 100% (18/18), done.
Writing objects: 100% (18/18), 537.08 KiB | 4.44 MiB/s, done.
Total 18 (delta 3), reused 0 (delta 0)
To C:/gdrive/01_StThomas/10_DataWarehousing/06_project/M2/files/git/work/../repo/Team-09-11900-Garth.git
 * [new branch]      master -> master

$ git branch -a
  Team_09_M1_Final_Submission
  dev-11900-Garth
* master
  remotes/origin/master
```

That worked, so do the others as well.

```bash
$ git checkout dev-11900-Garth
$ git push --set-upstream origin dev-11900-Garth

$ git branch -a
  Team_09_M1_Final_Submission
* dev-11900-Garth
  master
  remotes/origin/dev-11900-Garth
  remotes/origin/master
  
$ git checkout Team_09_M1_Final_Submission
$ git push --set-upstream origin Team_09_M1_Final_Submission

$ git branch -a
* Team_09_M1_Final_Submission
  dev-11900-Garth
  master
  remotes/origin/Team_09_M1_Final_Submission
  remotes/origin/dev-11900-Garth
  remotes/origin/master
```

Good, now I can zip and share.

Checkout dev to make sure I don't mess anything up in master.

```bash
git checkout dev-11900-Garth
```

Cd to remote repo.

```bash
cd ../repo
7z a 20201205_remote_garth.zip Team-09-11900-Garth.git
7-Zip 19.00 (x64) : Copyright (c) 1999-2018 Igor Pavlov : 2019-02-21
Scanning the drive:
27 folders, 37 files, 578456 bytes (565 KiB)
Creating archive: 20201205_remote_garth.zip
Add new data to archive: 27 folders, 37 files, 578456 bytes (565 KiB)
Files read from disk: 37
Archive size: 581220 bytes (568 KiB)
Everything is Ok
```

Email it.

### Next step