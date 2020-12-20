# Simulate a distributed git workflow
20120.10.03 - 2020.10.08
Garth Mortensen

_Explore and practice various git commands to enhance understanding._

## Background

## Steps

Change git username, email and disable auto-conversion of carriage return linefeeds.

```bash
git config --global user.name xxx
git config --global user.email xxx
git config --global core.autocrlf false
git config --global core.eol lf
```

Global is the default on your machine, if not overridden by local config. You can change this per repo.

## Naming Conventions

Folders, files, branches, columns, tables, etc will only use:

* Alphanumeric with - or _
* No spaces!

Branch names:

* dev_11900-Garth
* dev_11900-Garth_extra_feature
* dev_11900-Garth_resolving_data

Repo creation

* always create initial bare repo
* always create initial commit in master before branching
* all local branches and commits must be pushed to bare repo

## Larry

### Create dir structure

Create a bare repo and repo for Larry.

```bash
mkdir HandsOn/Larry
mkdir HandsOn/Larry/repo
mkdir HandsOn/Larry/work
cd HandsOn/Larry/repo/
git init --bare 11900-Garth_Larry.git
cd ../work/
git init
```

This produced the following.

```cmd
tree
C:.
└───Larry
    ├───repo
    │   └───11900-Garth_Larry.git
    └───work
        └───.git
```

Test to see if it was created correctly.

```bash
$ ls -lah "$PWD/../repo/11900-Garth_Larry.git"
total 11K
drwxr-xr-x 1 morte 197609   0 Oct  3 12:26 ./
drwxr-xr-x 1 morte 197609   0 Oct  3 12:26 ../
-rw-r--r-- 1 morte 197609 104 Oct  3 12:26 config
-rw-r--r-- 1 morte 197609  73 Oct  3 12:26 description
-rw-r--r-- 1 morte 197609  23 Oct  3 12:26 HEAD
drwxr-xr-x 1 morte 197609   0 Oct  3 12:26 hooks/
drwxr-xr-x 1 morte 197609   0 Oct  3 12:26 info/
drwxr-xr-x 1 morte 197609   0 Oct  3 12:26 objects/
drwxr-xr-x 1 morte 197609   0 Oct  3 12:26 refs/
```

That displayed the content, so the command worked. 

Add remote, (connect it to the bare repo).

```bash
$ git remote add origin "$PWD/../repo/11900-Garth_Larry.git"
```

### Simulate being Larry

Set git config files for Larry.

```bash
git config --local user.name xxx
git config --local user.email xxx
git config --local core.autocrlf false
git config --local core.eol lf
```

Local is only in this working directory's repository. It overrides global settings.

Create a text file named .gitattributes, for telling git that files ending in .sh should use line feeds but no carriage returns.

```bash
echo '*.sh eol=lf' > .gitattributes
```

Bash scripts require line endings.

Add the file to the staging area.

```bash
git add .
```

Excellent. Now let's create a scripts directory to add files into.

```bash
mkdir scripts
```

Extract the .zip folder, using 7zip. Ensure that 7zip is added to path.

```cmd
In Windows,
search "path" - edit path - new - add "C:\Program Files\7-Zip"
```

You might need to restart Git Bash.

Now extract the zip.

```bash
7z x ../../git-hands-on-scripts.zip
```

Zip files don't preserve permissions, so they need to be set again.

```bash
chmod +x scripts/*.sh
```

Add these files to staging.

```bash
git add .
```

Execute the scripts one by one, for the first run.

```bash
scripts/110_verify_basic_dir_struct.sh
scripts/120_verify_repo_dirs.sh
scripts/130_verify_remotes.sh
scripts/140_verify_git_cfg.sh
scripts/150_verify_no_bad_names.sh
```

All checks passed. Check status.

```bash
$ git status
On branch master

No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)
        new file:   .gitattributes
        new file:   scripts/.gitignore
        new file:   scripts/100_verify_all.sh
        new file:   scripts/110_verify_basic_dir_struct.sh
        new file:   scripts/120_verify_repo_dirs.sh
        new file:   scripts/130_verify_remotes.sh
        new file:   scripts/140_verify_git_cfg.sh
        new file:   scripts/150_verify_no_bad_names.sh
        new file:   scripts/950_common.sh
```

Commit.

```bash
$ git commit -m "C1, line-feeds for .sh and scripts"
[master (root-commit) 71faf0f] C1, line-feeds for .sh and scripts
 9 files changed, 749 insertions(+)
 create mode 100644 .gitattributes
 create mode 100644 scripts/.gitignore
 create mode 100644 scripts/100_verify_all.sh
 create mode 100644 scripts/110_verify_basic_dir_struct.sh
 create mode 100644 scripts/120_verify_repo_dirs.sh
 create mode 100644 scripts/130_verify_remotes.sh
 create mode 100644 scripts/140_verify_git_cfg.sh
 create mode 100644 scripts/150_verify_no_bad_names.sh
 create mode 100644 scripts/950_common.sh

$ git status
On branch master
nothing to commit, working tree clean

$ git log
commit 71faf0faf14ee7e29f27bd4a04b5d7d68719e8b2 (HEAD -> master)
Author: 11900-Garth_as_Larry <eh@eh.com>
Date:   Sat Oct 3 13:24:37 2020 -0500

    C1, line-feeds for .sh and scripts
```

With that, Larry just committed to the local's master branch. To share it,

```bash
git push origin master
```

Now Larry has: 

* bare repo (origin) has the first commit
* the master branch in both local and bare point to that commit 

### Branch

Create and checkout a branch for Larry.

```bash
git branch dev_11900-Garth_as_Larry
git checkout dev_11900-Garth_as_Larry
Switched to branch 'dev_11900-Garth_as_Larry'
```

Since we've checked the branch out, all work will be done on this branch until you checkout another.

Create a placeholder text file and add to staging area.

```bash
echo "twinkle, twinkle, little bat" > poem.txt
git add .
```

Perform your second commit, check log and gitk.

```bash
git commit -m "C2 - start my poem"
git status
git log
commit 56135a39c08569ef0b67e27a993e03edc0c93b43 (HEAD -> dev_11900-Garth_as_Larry)
Author: 11900-Garth_as_Larry <xxx>
Date:   Sun Oct 4 14:48:22 2020 -0500

    C2 - start my poem

commit 71faf0faf14ee7e29f27bd4a04b5d7d68719e8b2 (origin/master, master)
Author: 11900-Garth_as_Larry <xxx>
Date:   Sat Oct 3 13:24:37 2020 -0500

    C1, line-feeds for .sh and scripts

gitk --all
```

This displays the git GUI, which is interesting to see.

Append another line to the poem.

```bash
echo "how I wonder what your at" >> poem.txt
git add .
git commit -m "C3 - completed 1st verse"
git status
git log
commit c4b71cdfcf39ef4dcb19306e87b70cc2d88a20d9 (HEAD -> dev_11900-Garth_as_Larry)
Author: 11900-Garth_as_Larry <xxx>
Date:   Sun Oct 4 14:56:41 2020 -0500

    C3 - completed 1st verse

commit 56135a39c08569ef0b67e27a993e03edc0c93b43
Author: 11900-Garth_as_Larry <xxx>
Date:   Sun Oct 4 14:48:22 2020 -0500

    C2 - start my poem

commit 71faf0faf14ee7e29f27bd4a04b5d7d68719e8b2 (origin/master, master)
Author: 11900-Garth_as_Larry <xxx>
Date:   Sat Oct 3 13:24:37 2020 -0500

    C1, line-feeds for .sh and scripts
```

Push to bare repo.

```bash
git push origin dev_11900-Garth_as_Larry
```

Bare repo now has the dev branch and all commit history.

The remote branch has also been updated.

### Diff

Explore git diff commands.

```bash
$ git diff HEAD~1
diff --git a/poem.txt b/poem.txt
index 0176796..2a0d325 100644
--- a/poem.txt
+++ b/poem.txt
@@ -1 +1,2 @@
 twinkle, twinkle, little bat
+how I wonder what your at

$ git diff master
diff --git a/poem.txt b/poem.txt
new file mode 100644
index 0000000..2a0d325
--- /dev/null
+++ b/poem.txt
@@ -0,0 +1,2 @@
+twinkle, twinkle, little bat
+how I wonder what your at

$ git diff HEAD~2
diff --git a/poem.txt b/poem.txt
new file mode 100644
index 0000000..2a0d325
--- /dev/null
+++ b/poem.txt
@@ -0,0 +1,2 @@
+twinkle, twinkle, little bat
+how I wonder what your at
```

### Reset

You can undo or reset changes using some of the following commands.

```bash
$ git reset --hard HEAD~1
HEAD is now at 56135a3 C2 - start my poem
```

This moves the HEAD to commit, updates the staging area to match the new HEAD, and updates the working directory to match the new HEAD & index.

```bash
$ git status
On branch dev_11900-Garth_as_Larry
nothing to commit, working tree clean

$ git log
commit 56135a39c08569ef0b67e27a993e03edc0c93b43 (HEAD -> dev_11900-Garth_as_Larry)
Author: 11900-Garth_as_Larry <xxx>
Date:   Sun Oct 4 14:48:22 2020 -0500

    C2 - start my poem

commit 71faf0faf14ee7e29f27bd4a04b5d7d68719e8b2 (origin/master, master)
Author: 11900-Garth_as_Larry <xxx>
Date:   Sat Oct 3 13:24:37 2020 -0500

    C1, line-feeds for .sh and scripts
```

This pushed our poem.txt back in time to our C2 branch.

* If we hadn't pushed our branch, C3 would have been almost lost. It would be hard to find if nothing is pointing at it and we didn't remember the SHA-1 for C3. Effectively, lost.

### Merge

Let's merge the changes of the named commit into the current branch.

```bash
$ git merge --ff-only origin/dev_11900-Garth_as_Larry
Updating 56135a3..c4b71cd
Fast-forward
 poem.txt | 1 +
 1 file changed, 1 insertion(+)
```

--ff-only means Fast Forward only. If there were any conflicts, the merge would fail. This travels us back to the present.

The dev branch is now pushed to origin and merged back into the currently checked out local dev branch.

### Less common Git commands

**git init** creates an a repo inside a work directory. It creates a default master branch.

**git init --bare** creates a repo that is not attached to a work directory (*suitable for being a remote*).

- [ ] Q) When would you use this?

**git remote add (name) (url)** creates a reference to a remote for the current repo and work dir. It merely associates the name with the url. It doesn't actually connect to the remote repo yet.

- [ ] git fetch vs git pull?

**git fetch remote** copies all updates in the named remote into the .git local repo. This does not affect the work directory. 

**git clone --origin (name) (url)** creates a remote named (name). The url points to a remote (and bare) repo. Copies all branches from the remote into the local repo as (remote)/(branch name). Creates a default master branch, checks out master and merge remote/master into master.

## Curly

### Create dir structure

Navigate to the HandsOn parent folder

```bash
mkdir HandsOn/Curly
mkdir HandsOn/Curly/repo
mkdir HandsOn/Curly/work
cd HandsOn/Curly/repo/
```

With the directories created, I'll setup git for Curly.

```bash
git init --bare 11900-Garth_Curly.git
cd ../work/
git init
git config --local user.name 11900-Garth_as_Curly
ls -lah "$PWD/../repo/11900-Garth_Curly.git"
```

Now Curly wants to connect to Larry's bare repo.

```cmd
C:.
├───Curly
│   ├───repo
│   │   └───11900-Garth_Curly.git
│   └───work # Current working directory
├───Larry
│   ├───repo # parent of our target
│   │   └───11900-Garth_Larry.git
│   └───work
│       └───scripts
```

### Remote

Create Curly's remote.

```bash
git remote add Mine "$PWD/../repo/11900-Garth_Curly.git"
```

(Originally used git remote add **origin**, but merely reran with Mine. Part 4 page 17)

Create Larry's remote.

Now Curly wants to connect to Larry's bare repo. We start with a test.

```bash
ls -lah "$PWD/../../Larry/repo/11900-Garth_Larry.git"
```

The command worked. Let's git remote add & fetch.

```bash
git remote add Hey_Larry "$PWD/../../Larry/repo/11900-Garth_Larry.git"
```

This remote now points to the bare repo, just like it does for Larry.

* Mine is Curly's bare repo.
* Hey_Larry is Larry's bare repo.

Curly now needs to update his local master branch to start contributing to Larry's work. However, Curly hasn't done any work yet, so there's nothing in his work dir. There's no commit for his local master branch to point to. His local master branch is empty.

### Fetch

Fetch all objects (commits, blobs, etc) from Larry's bare repo (Larry.git). Also, it will create a "remote branch" for Curly's local repo for each branch in Larry's bare repo.

```bash
git fetch Hey_Larry
```

This has no effect on:

* Larry's local or bare repos
* Curly's bare repo
* Curly's work dir

Verify branches.

```bash
$ git branch
$ git branch -r
  Hey_Larry/dev_11900-Garth_as_Larry
  Hey_Larry/master
$ git branch -rv
  Hey_Larry/dev_11900-Garth_as_Larry c4b71cd C3 - completed 1st verse
  Hey_Larry/master                   71faf0f C1, line-feeds for .sh and scripts
```

-r lists remote branches!

-rv lists remote branches verbosely!

Curly still needs to update his local master branch, **because we're using fetch instead of pull**, i think.

His local master is empty, and in essence, doesn't really exist since it points to nothing.

Curly's local repo has Hey_Larry/master, but that's equivalent to (remote)/master.

**git fetch "asked" Larry's bare repo "what commit is your 'master' branch pointed at now?"** and stored the answer in Curly's local repo in a branch named Hey_Larry/master.

Merge local with master.

```bash
git merge --ff-only Hey_Larry/master
```

This updates Cury's local master branch to match the remote we fetched from Larry's bare (Hey_Larry/master), and updates the work directory.

### Push

Push is in some respects the opposite or compliment to a fetch.

```bash
git push Mine master
```

This pushes all changes to Curly's bare repo (the remote Mine).

### Dev

Create Curly's dev branch based on Curly's local repo's remembered value for "what Larry's dev branch pointed to the last time we fetched"

```bash
git branch dev_11900-Garth_as_Curly Hey_Larry/dev_11900-Garth_as_Larry
```

Merge with local master.

```bash
ls -lah
total 9.0K
drwxr-xr-x 1 morte 197609  0 Oct  5 18:21 ./
drwxr-xr-x 1 morte 197609  0 Oct  4 17:19 ../
drwxr-xr-x 1 morte 197609  0 Oct  5 18:46 .git/
-rw-r--r-- 1 morte 197609 12 Oct  5 18:21 .gitattributes
drwxr-xr-x 1 morte 197609  0 Oct  5 18:21 scripts/
```

We've created the branch, so check out.

```bash
git checkout dev_11900-Garth_as_Curly
```

Make some changes now.

```bash
echo "Up above the world you fly," >> poem.txt
echo "Like a tea tray in the sky." >> poem.txt
git add .
git status
On branch dev_11900-Garth_as_Curly
Your branch is up to date with 'Hey_Larry/dev_11900-Garth_as_Larry'.

Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        modified:   poem.txt

git commit -m "C4 - added another verse"
```

Rename the file. You should use git to rename it to ensure everything works well.

```bash
git mv poem.txt Great_Poem.txt
On branch dev_11900-Garth_as_Curly
Your branch is ahead of 'Hey_Larry/dev_11900-Garth_as_Larry' by 1 commit.
  (use "git push" to publish your local commits)

Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        renamed:    poem.txt -> Great_Poem.txt

git commit -m "C5 - Great Poem completed"
[dev_11900-Garth_as_Curly 9319234] C5 - Great Poem completed
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename poem.txt => Great_Poem.txt (100%)
```

Mv automatically staged the rename.

Push the changes.

```bash
git push Mine dev_11900-Garth_as_Curly
```

**Curly has pushed his dev branch to his bare repo, but has not shared it with anyone.**

## Moe

Moe needs to create a work and bare repo. He'll base his work off Larry's dev branch, located on Larry's bare repo.

Create Moe's directory, init repo and config.

```bash
morte@Cyberfuchi5 MINGW64 /c/gdrive/01_StThomas/10_DataWarehousing/08_hw/02_git_repo
$ mkdir HandsOn/Moe
mkdir HandsOn/Moe/repo
mkdir HandsOn/Moe/work
cd HandsOn/Moe/repo/
git init --bare 11900-Garth_Moe.git
cd ../work/
git init
git config --local user.name 11900-Garth_as_Moe
```

Test the line to add remote repo, then run it.

```bash
ls -lah "$PWD/../repo/11900-Garth_Moe.git"
git remote add origin "$PWD/../repo/11900-Garth_Moe.git"
```

*Note: Moe's origin is not the same repo that Larry's origin.*

### Connect Moe to Larry's repo

Our current directory is:

```cmd
├───Curly
│   ├───repo
│   │   └───11900-Garth_Curly.git
│   └───work
│       └───scripts
├───Larry
│   ├───repo  # parent of our target
│   │   └───11900-Garth_Larry.git
│   └───work
│       └───scripts
├───Moe
│   ├───repo
│   │   └───11900-Garth_Moe.git
│   └───work  # current working directory
└───scripts
```

Create Moe's WiseGuy remote, starting with a testing line.

```bash
ls -lah "$PWD/../../Larry/repo/11900-Garth_Larry.git"
git remote add WiseGuy "$PWD/../../Larry/repo/11900-Garth_Larry.git"
```

Moe's bare repo "Origin" now points to Larry's bare repo "WiseGuy".

He still needs to update his local master branch to build on Larry and Curly have started. 

### Fetch

```bash
$ git fetch WiseGuy
remote: Enumerating objects: 18, done.
remote: Counting objects: 100% (18/18), done.
remote: Compressing objects: 100% (15/15), done.
remote: Total 18 (delta 3), reused 0 (delta 0)
Unpacking objects: 100% (18/18), done.
From C:/gdrive/01_StThomas/10_DataWarehousing/08_hw/02_git_repo/HandsOn/Moe/work/../../Larry/repo/11900-Garth_Larry
 * [new branch]      dev_11900-Garth_as_Larry -> WiseGuy/dev_11900-Garth_as_Larry
 * [new branch]      master     -> WiseGuy/master

$ git branch -v
$ git branch -rv
  WiseGuy/dev_11900-Garth_as_Larry c4b71cd C3 - completed 1st verse
  WiseGuy/master                   71faf0f C1, line-feeds for .sh and scripts
  
$ git branch -av
  remotes/WiseGuy/dev_11900-Garth_as_Larry c4b71cd C3 - completed 1st verse
  remotes/WiseGuy/master                   71faf0f C1, line-feeds for .sh and scripts

$ ls -lah
total 4.0K
drwxr-xr-x 1 morte 197609 0 Oct  7 11:12 ./
drwxr-xr-x 1 morte 197609 0 Oct  7 11:11 ../
drwxr-xr-x 1 morte 197609 0 Oct  7 11:31 .git/

git merge --ff-only WiseGuy/master

$ git branch -av
* master                                   71faf0f C1, line-feeds for .sh and scripts
  remotes/WiseGuy/dev_11900-Garth_as_Larry c4b71cd C3 - completed 1st verse
  remotes/WiseGuy/master                   71faf0f C1, line-feeds for .sh and scripts
```

-r = remote 
-v = verbosely

### Push and Branch

```bash
git push origin master
$ git branch dev_11900-Garth_as_Moe WiseGuy/dev_11900-Garth_as_Larry
Branch 'dev_11900-Garth_as_Moe' set up to track remote branch 'dev_11900-Garth_as_Larry' from 'WiseGuy'.

$ ls -lah
total 9.0K
drwxr-xr-x 1 morte 197609  0 Oct  7 11:33 ./
drwxr-xr-x 1 morte 197609  0 Oct  7 11:11 ../
drwxr-xr-x 1 morte 197609  0 Oct  7 11:37 .git/
-rw-r--r-- 1 morte 197609 12 Oct  7 11:33 .gitattributes
drwxr-xr-x 1 morte 197609  0 Oct  7 11:33 scripts/
```

Continue on...

```bash
git checkout dev_11900-Garth_as_Moe
$ ls -lah
total 10K
drwxr-xr-x 1 morte 197609  0 Oct  7 11:39 ./
drwxr-xr-x 1 morte 197609  0 Oct  7 11:11 ../
drwxr-xr-x 1 morte 197609  0 Oct  7 11:39 .git/
-rw-r--r-- 1 morte 197609 12 Oct  7 11:33 .gitattributes
-rw-r--r-- 1 morte 197609 55 Oct  7 11:39 poem.txt
drwxr-xr-x 1 morte 197609  0 Oct  7 11:33 scripts/
```

Edit the poem in npp, ensuring you use only line feeds and not carriage returns.

Change "your to you're" and add ","

Push changes.

```bash
git status
git add .
git status
git commit -m "C6 - fixed grammatical error"
git push origin dev_11900-Garth_as_Moe
```

Now if Curly were on a different computer, he could push all his changes and zip his bare repo, which can be shared via email, zip, etc. Let's do this. 

**Switch to Curly. Going back to redo this, which was originally ran as Moe**

Go to the repo directory.

```bash
morte@Cyberfuchi5 MINGW64 /c/gdrive/01_StThomas/10_DataWarehousing/08_hw/02_git_repo/HandsOn/Curly/repo
$ 7z a 11900-Garth_Curly.zip 11900-Garth_Curly.git
7-Zip 19.00 (x64) : Copyright (c) 1999-2018 Igor Pavlov : 2019-02-21
Scanning the drive:
32 folders, 41 files, 27447 bytes (27 KiB)
Creating archive: 11900-Garth_Curly.zip
Add new data to archive: 32 folders, 41 files, 27447 bytes (27 KiB)
Files read from disk: 41
Archive size: 31903 bytes (32 KiB)
Everything is Ok

$ ls -lah
total 36K
drwxr-xr-x 1 morte 197609   0 Oct  7 11:48 ./
drwxr-xr-x 1 morte 197609   0 Oct  4 17:19 ../
drwxr-xr-x 1 morte 197609   0 Oct  5 18:38 11900-Garth_Curly.git/
-rw-r--r-- 1 morte 197609 32K Oct  7 11:48 11900-Garth_Curly.zip
```

List the content in the zip to see what's in there.

```bash
$ 7z l 11900-Garth_Curly.zip
   Date      Time    Attr         Size   Compressed  Name
------------------- ----- ------------ ------------  ------------------------
2020-10-05 18:38:54 D....            0            0  11900-Garth_Curly.git
2020-10-04 17:22:50 ....A          104           84  11900-Garth_Curly.git\config
2020-10-04 17:22:50 ....A           73           65  11900-Garth_Curly.git\description
2020-10-04 17:22:50 ....A           23           23  11900-Garth_Curly.git\HEAD
etc
etc
```

So even if Moe didn't have the .git directory initially, Curly could zip and share it.

**Switch to Moe**

**What is this???**

```bash
morte@Cyberfuchi5 MINGW64 /c/gdrive/01_StThomas/10_DataWarehousing/08_hw/02_git_repo/HandsOn/Moe/work (dev_11900-Garth_as_Moe)
$ ls -lag "$PWD/../../Curly/repo"
total 40
drwxr-xr-x 1 197609     0 Oct  7 19:42 ./
drwxr-xr-x 1 197609     0 Oct  4 17:19 ../
drwxr-xr-x 1 197609     0 Oct  5 18:38 11900-Garth_Curly.git/
-rw-r--r-- 1 197609 31903 Oct  7 19:42 11900-Garth_Curly.zip

$ pushd "$PWD/../../Curly/repo"
/c/gdrive/01_StThomas/10_DataWarehousing/08_hw/02_git_repo/HandsOn/Curly/repo /c/gdrive/01_StThomas/10_DataWarehousing/08_hw/02_git_repo/HandsOn/Curly/repo

$ ls -lah
total 36K
drwxr-xr-x 1 morte 197609   0 Oct  7 11:48 ./
drwxr-xr-x 1 morte 197609   0 Oct  4 17:19 ../
drwxr-xr-x 1 morte 197609   0 Oct  5 18:38 11900-Garth_Curly.git/
-rw-r--r-- 1 morte 197609 32K Oct  7 11:48 11900-Garth_Curly.zip
```

Verify that all the files in the current directory are what we saw before.

```bash
$ mv 11900-Garth_Curly.git SAVE_11900-Garth_Curly.git
morte@Cyberfuchi5 MINGW64 /c/gdrive/01_StThomas/10_DataWarehousing/08_hw/02_git_repo/HandsOn/Curly/repo

$ ls -lah
total 40K
drwxr-xr-x 1 morte 197609   0 Oct  7 19:46 ./
drwxr-xr-x 1 morte 197609   0 Oct  4 17:19 ../
-rw-r--r-- 1 morte 197609 32K Oct  7 19:42 11900-Garth_Curly.zip
drwxr-xr-x 1 morte 197609   0 Oct  5 18:38 SAVE_11900-Garth_Curly.git/  # new name
```

Verify the bare repo directory name changed.

Now simulate (something???). Recreate the bare repo dir by extracting the zip.

```bash
7z x 11900-Garth_Curly.zip
7-Zip 19.00 (x64) : Copyright (c) 1999-2018 Igor Pavlov : 2019-02-21
Scanning the drive for archives:
1 file, 31903 bytes (32 KiB)
Extracting archive: 11900-Garth_Curly.zip
--
Path = 11900-Garth_Curly.zip
Type = zip
Physical Size = 31903
Everything is Ok
Folders: 32
Files: 41
Size:       27447
Compressed: 31903

$ ls -lah
total 44K
drwxr-xr-x 1 morte 197609   0 Oct  7 11:59 ./
drwxr-xr-x 1 morte 197609   0 Oct  4 17:19 ../
drwxr-xr-x 1 morte 197609   0 Oct  5 18:38 11900-Garth_Curly.git/
-rw-r--r-- 1 morte 197609 32K Oct  7 11:48 11900-Garth_Curly.zip
drwxr-xr-x 1 morte 197609   0 Oct  5 18:38 SAVE_11900-Garth_Curly.git/
```

This renaming and saving is abnormal.

User popd to move back to Moe's working directory.

```bash
morte@Cyberfuchi5 MINGW64 /c/gdrive/01_StThomas/10_DataWarehousing/08_hw/02_git_repo/HandsOn/Curly/repo
$ popd
/c/gdrive/01_StThomas/10_DataWarehousing/08_hw/02_git_repo/HandsOn/Moe/work
```

Connect to Curly's bare repo. 

```bash
$ git remote add KnuckleHead "$PWD/../../Curly/repo/11900-Garth_Curly.git"

$ ls -lah
total 10K
drwxr-xr-x 1 morte 197609  0 Oct  7 11:39 ./
drwxr-xr-x 1 morte 197609  0 Oct  7 11:11 ../
drwxr-xr-x 1 morte 197609  0 Oct  7 19:51 .git/
-rw-r--r-- 1 morte 197609 12 Oct  7 11:33 .gitattributes
-rw-r--r-- 1 morte 197609 58 Oct  7 11:42 poem.txt
drwxr-xr-x 1 morte 197609  0 Oct  7 11:33 scripts/

$ git fetch KnuckleHead
remote: Enumerating objects: 6, done.
remote: Counting objects: 100% (6/6), done.
remote: Compressing objects: 100% (5/5), done.
remote: Total 5 (delta 1), reused 0 (delta 0)
Unpacking objects: 100% (5/5), done.
From C:/gdrive/01_StThomas/10_DataWarehousing/08_hw/02_git_repo/HandsOn/Moe/work/../../Curly/repo/11900-Garth_Curly
 * [new branch]      dev_11900-Garth_as_Curly -> KnuckleHead/dev_11900-Garth_as_Curly
 * [new branch]      master     -> KnuckleHead/master
```

Moe now wants to merge from Curly, which will cause a problem. Curly added content to the poem and also changed the file's name.

```bash
$ git merge KnuckleHead/dev_11900-Garth_as_Curly
CONFLICT (modify/delete): poem.txt deleted in KnuckleHead/dev_11900-Garth_as_Curly and modified in HEAD. Version HEAD of poem.txt left in tree.
Automatic merge failed; fix conflicts and then commit the result.
```

Display content.

```bash
$ ls -lah
total 15K
drwxr-xr-x 1 morte 197609   0 Oct  7 19:56 ./
drwxr-xr-x 1 morte 197609   0 Oct  7 11:11 ../
drwxr-xr-x 1 morte 197609   0 Oct  7 19:56 .git/
-rw-r--r-- 1 morte 197609  12 Oct  7 11:33 .gitattributes
-rw-r--r-- 1 morte 197609 111 Oct  7 19:56 Great_Poem.txt  # poem 2
-rw-r--r-- 1 morte 197609  58 Oct  7 11:42 poem.txt  # poem 1
drwxr-xr-x 1 morte 197609   0 Oct  7 11:33 scripts/
```

Moe needs to manually fix this.

Edit the great poem in the same was as earlier (your -> you're, .)

```bash
$ git status
On branch dev_11900-Garth_as_Moe
Your branch is ahead of 'WiseGuy/dev_11900-Garth_as_Larry' by 1 commit.
  (use "git push" to publish your local commits)
You have unmerged paths.
  (fix conflicts and run "git commit")
  (use "git merge --abort" to abort the merge)
Changes to be committed:
        new file:   Great_Poem.txt
Unmerged paths:
  (use "git add/rm <file>..." as appropriate to mark resolution)
        deleted by them: poem.txt
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   Great_Poem.txt

$ rm poem.txt

$ git add .

$ git status
On branch dev_11900-Garth_as_Moe
Your branch is ahead of 'WiseGuy/dev_11900-Garth_as_Larry' by 1 commit.
  (use "git push" to publish your local commits)
All conflicts fixed but you are still merging.
  (use "git commit" to conclude merge)
Changes to be committed:
        renamed:    poem.txt -> Great_Poem.txt  # interesting, rename successful
```

Commit and push.

```bash
git commit -m "C7 - fixed grammar in Great Poem"
[dev_11900-Garth_as_Moe 5bde560] C7 - fixed grammar in Great Poem

git push origin dev_11900-Garth_as_Moe
morte@Cyberfuchi5 MINGW64 /c/gdrive/01_StThomas/10_DataWarehousing/08_hw/02_git_repo/HandsOn/Moe/work (dev_11900-Garth_as_Moe)
$ git push origin dev_11900-Garth_as_Moe
Enumerating objects: 10, done.
Counting objects: 100% (10/10), done.
Delta compression using up to 4 threads
Compressing objects: 100% (8/8), done.
Writing objects: 100% (8/8), 979 bytes | 489.00 KiB/s, done.
Total 8 (delta 2), reused 0 (delta 0)
To C:/gdrive/01_StThomas/10_DataWarehousing/08_hw/02_git_repo/HandsOn/Moe/work/../repo/11900-Garth_Moe.git
   ebbd7a6..5bde560  dev_11900-Garth_as_Moe -> dev_11900-Garth_as_Moe
```

This pushed origin to dev.

Moe should now create a "final release" branch. That means commits in the branch are intended to the final version and shareable with others.

```bash
$ git branch Team_99_Asgn_2_Final_11900-Garth

$ git push origin Team_99_Asgn_2_Final_11900-Garth
Total 0 (delta 0), reused 0 (delta 0)
To C:/gdrive/01_StThomas/10_DataWarehousing/08_hw/02_git_repo/HandsOn/Moe/work/../repo/11900-Garth_Moe.git
 * [new branch]      Team_99_Asgn_2_Final_11900-Garth -> Team_99_Asgn_2_Final_11900-Garth
```

Finally, in order for Moe to share his work, he must zip it up. Zip the bare repo.

```bash
7z a 11900-Garth_Moe.zip 11900-Garth_Moe.git
7-Zip 19.00 (x64) : Copyright (c) 1999-2018 Igor Pavlov : 2019-02-21
Scanning the drive:
37 folders, 48 files, 28314 bytes (28 KiB)
Creating archive: 11900-Garth_Moe.zip
Add new data to archive: 37 folders, 48 files, 28314 bytes (28 KiB)
Files read from disk: 48
Archive size: 35080 bytes (35 KiB)
Everything is Ok

7z l 11900-Garth_Moe.zip
7-Zip 19.00 (x64) : Copyright (c) 1999-2018 Igor Pavlov : 2019-02-21
Scanning the drive for archives:
1 file, 35080 bytes (35 KiB)
Listing archive: 11900-Garth_Moe.zip
Path = 11900-Garth_Moe.zip
Type = zip
Physical Size = 35080
   Date      Time    Attr         Size   Compressed  Name
------------------- ----- ------------ ------------  ------------------------
2020-10-07 11:37:29 D....            0            0  11900-Garth_Moe.git
2020-10-07 11:12:08 ....A          104           84  11900-Garth_Moe.git\config
2020-10-07 11:12:08 ....A           73           65  11900-Garth_Moe.git\description
```

The end.











## History

```bash
  291  git username
  292  git user
  293  git user.name
  294  clear
  295  git config user.name
  296  git config user.email
  297  git config --global user.name xxx
  298  git config --global user.email xxx
  299  git config --global core.autocrlf false
  300  git config --global core.eol lf
  301  mkdir HandsOn
  302  ls
  303  mkdir HandsOn/Larry
  304  mkdir HandsOn/Larry/repo
  305  mkdir HandsOn/Larry/work
  306  cd HandsOn/Larry/repo/
  307  clear
  308  git init --bare 11900-Garth_Larry.git
  309  ls -la
  310  cd ../work/
  311  git init
  312  hist
  313  history
  314  tree
  315  clear
  316  ls -lah "$PWD/../repo/11900-Garth_Larry.git
  317  ls -lah "$PWD/../repo/11900-Garth_Larry.git"
  318  git remote add origin "$PWD/../repo/11900-Garth_Larry.git"
  319  git config --local user.name 11900-Garth_as_Larry
  320  git config --local user.name xxx
  321  git config --local core.autocrlf false
  322  git config --local core.eol lf
  323  echo '*.sh eol=lf' > .gitattributes
  324  git add .
  325  git status
  326  mkdir scripts
  327  chmod +x scripts/*.sh
  328  git status
  329  git add .
  330  scripts/110_verify_basic_dir_struct.sh
  331  clear
  332  scripts/120_verify_repo_dirs.sh
  333  scripts/130_verify_remotes.sh
  334  scripts/140_verify_git_cfg.sh
  335  scripts/150_verify_no_bad_names.sh
  336  scripts/120_verify_repo_dirs.sh
  337  git config --local user.name 11900-Garth_as_Larry
  338  scripts/140_verify_git_cfg.sh
  339  git add .
  340  git log
  341  gitk -all
  342  git status
  343  git commit -m "C1, line-feeds for .sh and scripts"
  344  git status
  345  git log
  346  gitk --all
  347  git push origin master
  348  git branch dev_11900-Garth_as_Larry
  349  git checkout dev_11900-Garth_as_Larry
  350  cd scripts/
  351  ls
  352  110_verify_basic_dir_struct.sh
  353  ls
  354  cd ../
  355  ls
  356  echo "twinkle, twinkle, little bat" > poem.txt
  357  git add .
  358  git status
  359  git commit -m "C2 - start my poem"
  360  git status
  361  git log
  362  gitk --all
  363  echo "how I wonder what your at" >> poem.txt
  364  git status
  365  git add .
  366  git commit -m "C3 - completed 1st verse"
  367  git status
  368  git log
  369  git push origin dev_11900-Garth_as_Larry
  370  git diff HEAD~1
  371  git diff master
  372  git diff HEAD~2
  373  git reset --hard HEAD~1
  374  git status
  375  git log
  376  gitk --all
  377  git merge --ff-only origin/dev_11900-Garth_as_Larry
  378  exit
  379  mkdir HandsOn/Curly
  380  mkdir HandsOn/Curly/repo
  381  mkdir HandsOn/Curly/work
  382  cd HandsOn/Curly/repo/
  383  git init --bare 11900-Garth_Curly.git
  384  cd ../work/
  385  git init
  386  git config --local user.name 11900-Garth_as_Curly
  387  ls -lah "$PWD/../repo/11900-Garth_Curly.git"
  388  git remote add origin "$PWD/../repo/11900-Garth_Curly.git"
  389  git remote add Mine "$PWD/../repo/11900-Garth_Curly.git"
  390  ls -lah "$PWD/../../Larry/repo/11900-Garth_Larry.git"
  391  git remote add Hey_Larry "$PWD/../../Larry/repo/11900-Garth_Larry.git"
  392  git branch
  393  git fetch Hey_Larry
  394  git branch
  395  git branch -r
  396  git branch -rv
  397  ls -lah
  398  git merge --ff-only Hey_Larry/master
  399  git branch -v
  400  git branch -rv
  401  git push Mine master
  402  git branch dev_11900-Garth_as_Curly Hey_Larry/dev_11900_Garth_as_Larry
  403  git branch dev_11900-Garth_as_Curly Hey_Larry/dev_11900-Garth_as_Larry
  404  ls -lah
  405  git checkout dev_11900-Garth_as_Curly
  406  echo "Up above the world you fly," >> poem.txt
  407  echo "Like a tea tray in the sky." >> poem.txt
  408  git add .
  409  git status
  410  git commit -m "C4 - added another verse"
  411  git log
  412  it status
  413  git status
  414  gitk --all
  415  git mv poem.txt Great_Poem.txt
  416  git status
  417  git commit -m "C5 - Great Poem completed"
  418  git push Mine dev_11900-Garth_as_Curly
  419  cd ../
  420  cd mkdir HandsOn/Moe
  421  mkdir HandsOn/Moe/repo
  422  mkdir HandsOn/Moe/work
  423  cd HandsOn/Moe/repo/
  424  cd HandsOn/Moe
  425  mkdir HandsOn/Moe/repo
  426  mkdir HandsOn/Moe/work
  427  exit
  428  mkdir HandsOn/Moe/repo
  429  mkdir HandsOn/Moe/work
  430  cd ../
  431  mkdir HandsOn/Moe/repo
  432  mkdir HandsOn/Moe/work
  433  cd HandsOn/
  434  mkdir Moe/repo
  435  mkdir HandsOn/Moe
  436  mkdir HandsOn/Moe/repo
  437  mkdir HandsOn/Moe/work
  438  cd ../
  439  mkdir HandsOn/Moe
  440  mkdir HandsOn/Moe/repo
  441  mkdir HandsOn/Moe/work
  442  cd HandsOn/Moe/repo/
  443  git init --bare 11900-Garth_Moe.git
  444  cd ../work/
  445  git init
  446  git config --local user.name 11900-Garth_as_Moe
  447  ls -lah "$PWD/../repo/11900-Garth_Moe.git"
  448  git remote add origin "$PWD/../repo/11900-Garth_Moe.git"
  449  ls -lah "$PWD/../../Larry/repo/11900-Garth_Larry.git"
  450  git remote add WiseGuy "$PWD/../../Larry/repo/11900-Garth_Larry.git"
  451  git fetch WiseGuy
  452  git branch -v
  453  git branch -rv
  454  git branch -av
  455  ls -lah
  456  git merge --ff-only WiseGuy/master
  457  git branch -av
  458  git push origin master
  459  git branch dev_11900-Garth_as_Moe WiseGuy/dev_11900-Garth_as_Larry
  460  ls -lag
  461  ls -lah
  462  git checkout dev_11900-Garth_as_Moe
  463  ls -lah
  464  git status
  465  git add .
  466  git commit -m "C6 - fixed grammatical error"
  467  git push origin dev_11900-Garth_as_Moe
  468  cd ../
  469  cd ../
  470  cd Curly/
  471  cd repo/
  472  ls -la
  473  7z a 11900-Garth_Curly.zip 11900-Garth_Curly.git
  474  ls -lah
  475  7z l 11900-Garth_Curly.zip
  476  ls -lah "$PWD/../../Curly/repo"
  477  pushd "$PWD/../../Curly/repo"
  478  ls -lah
  479  mv 11900-Garth_Curly.git SAVE_11900-Garth_Curly.git
  480  ls -lah
  481  7z x 11900-Garth_Curly.zip
  482  ls -lah
  483  git remote add KnuckleHead "$PWD/../../Curly/repo/11900-Garth_as_Curly.git"
  484  ls -lah "$PWD/../../Curly/repo/11900-Garth_Curly.git"
  485  git remote add KnuckleHead "$PWD/../../Curly/repo/11900-Garth_Curly.git"
  486  git remote add KnuckleHead "$PWD/../../Curly/repo/11900-Garth_Curly.git"
  487  exit
  488  git status
  489  exit
  490  git status
  491  git user.name
  492  git config user.name
  493  cd ../
  494  cd repo/
  495  $ 7z a 11900-Garth_Curly.zip 11900-Garth_Curly.git
  496  7z a 11900-Garth_Curly.zip 11900-Garth_Curly.git
  497  ls -lah
  498  7z l 11900-Garth_Curly.zip
  499  exit
  500  git status
  501  git config user.name
  502  ls -lag "$PWD/../../Curly/repo"
  503  pushd "$PWD/../../Curly/repo"
  504  ls -lah
  505  mv 11900-Garth_Curly.git SAVE_11900-Garth_Curly.git
  506  ls -lah
  507  7z x 11900-Garth_Curly.zip
  508  ls -lah
  509  popd
  510  git config user.name
  511  git remote add KnuckleHead "$PWD/../../Curly/repo/11900-Garth_Curly.git"
  512  ls -lah
  513  git fetch KnuckleHead
  514  gitk --all
  515  gitk --all
  516  git config user.name
  517  git merge KnuckleHead/dev_11900-Garth_as_Curly
  518  ls -lah
  519  git config user.name
  520  git status
  521  rm poem.txt
  522  git status
  523  rm poem.txt
  524  git status
  525  git add .
  526  git status
  527  git commit -m "C7 - fixed grammar in Great Poem"
  528  git push origin dev_11900-Garth_as_Moe
  529  git config user.name
  530  git branch Team_99_Asgn_2_Final_11900-Garth
  531  git push origin Team_99_Asgn_2_Final_11900-Garth
  532  git status
  533  cd ../
  534  ls
  535  cd repo
  536  ls -lah
  537  7z a 11900-Garth_Moe.zip 11900-Garth_Moe.git
  538  7z l 11900-Garth_Moe.zip
  539  hist
  540  history
```

