# Streamlined Git Fetch Merge techniques

When using git, you have 2 workflows.

If you're working in isolation (giving files), you use:

1. git add .
2. git commit 
3. git push

If you're bringing someone else's remote in and need to incorporate their work (receiving files), you use:

1. git fetch
2. git checkout
3. git merge
4. git push

Here, a pull is just a blind checkout + merge in 1 step. You don't get to fetch (to obtain the tree (like the schematic)), and checkout their work to see if it looks good before merging it in. It just accepts anything that's in the remote.

pull = checkout + merge

add remote repo. Point work directory to other's remote.

```bash
# check path
$ ls -lah "$PWD/../ethan_remote/Team-09-11200-Ethan.git"
$ ls -lah "$PWD/../ethan_remote/Team-09-11200-Ethan.git"
total 19K
drwxr-xr-x 1 morte 197609   0 Dec 18 15:04 ./
drwxr-xr-x 1 morte 197609   0 Dec 18 15:04 ../
-rw-r--r-- 1 morte 197609 104 Dec 17 20:45 config
-rw-r--r-- 1 morte 197609  73 Dec 17 20:45 description
-rw-r--r-- 1 morte 197609  23 Dec 17 20:45 HEAD
drwxr-xr-x 1 morte 197609   0 Dec 17 20:45 hooks/
drwxr-xr-x 1 morte 197609   0 Dec 17 20:45 info/
drwxr-xr-x 1 morte 197609   0 Dec 17 21:30 objects/
drwxr-xr-x 1 morte 197609   0 Dec 17 20:48 refs/

# point to remote
$ git remote add ethan_remote "$PWD/../ethan_remote/Team-09-11200-Ethan.git"

# fetch all branches
$ git fetch ethan_remote

# examine all branches
$ git branch -a
  Team_09_M3_Final_Submission
* dev-11900-Garth
  master
  remotes/ethan_remote/Team_09_M3_Final_Submission
  remotes/ethan_remote/dev-11200-Ethan
  remotes/ethan_remote/dev-11900-Garth
  remotes/ethan_remote/master
  remotes/origin/Team_09_M3_Final_Submission
  remotes/origin/dev-11900-Garth
  remotes/origin/master
  
# add remote branch to local branch under same name
$ git branch dev-11200-Ethan ethan_remote/dev-11200-Ethan

# merge ethan's branch into my own
$ git checkout dev-11900-Garth
$ git merge dev-11200-Ethan

# push to origin and remote
git push origin Team_09_M3_Final_Submission
git push ethan_remote Team_09_M3_Final_Submission
```

Everything:

``` bash
  483  cd work/
  484  ls -lah "$PWD/../ethan_remote"
  485  ls -lah "$PWD/../ethan_remote/Team-09-11200-Ethan.git"
  486  git remote add ethan_remote "$PWD/../ethan_remote/Team-09-11200-Ethan.git"
  487  git fetch ethan_remote
  488  git branch -a
  489  git branch dev-11200-Ethan ethan_remote/dev-11200-Ethan
  490  git checkout dev-11200-Ethan
  491  $ git branch dev-11200-Ethan ethan_remote/dev-11200-Ethan
  492  git branch -a
  # here i grab a branch from remote and bring it to local under same name
  493  git branch Team_09_M3_Final_Submission ethan_remote/Team_09_M3_Final_Submission
  # here i start checking out remote and bringing it to local
  494  git checkout dev-11900-Garth
  495  git merge dev-11200-Ethan
  496  git branch -a
  497  git checkout Team_09_M3_Final_Submission
  498  git checkout dev-11900-Garth
  499  exit
  500  git status
  501  git add .
  502  git commit -m "Adding garth sql and pdf files, renaming many D3 files"
  503  git status
  # here i start pushing everything to origin and remote, and double checking everything is up to date
  504  git branch -a
  505  git push origin dev-11900-Garth
  506  git checkout Team_09_M3_Final_Submission
  507  git merge dev-11900-Garth
  508  git push origin Team_09_M3_Final_Submission
  509  git branch -a
  510  git checkout dev-11200-Ethan
  511  git merge dev-11900-Garth
  512  git branch -a
  513  git checkout Team_09_M3_Final_Submission
  514  git checkout dev-11200-Ethan
  515  git checkout dev-11900-Garth
  516  git push origin Team_09_M3_Final_Submission
  517  git push origin dev-11900-Garth
  518  git push origin dev-11200-Ethan
  519  git push ethan_remote Team_09_M3_Final_Submission
  520  git branch -a
  521  git push ethan_remote dev-11200-Ethan
  522  git push ethan_remote dev-11900-Garth
  523  git push ethan_remote master
  524  git push origin Team_09_M3_Final_Submission
  525  git branch -a
  526  git checkout Team_09_M3_Final_Submission
  527  git checkout ethan_remote/Team_09_M3_Final_Submission
  528  git checkout ethan_remote/dev-11900-Garth
  529  git checkout ethan_remote/dev-112
  530  git checkout ethan_remote/dev-11200-Ethan
  531  git checkout ethan_remote/master
  532  git checkout Team_09_M3_Final_Submission
  533  history
  534  exit  # :)
```

**you push to remotes, you merge to local**