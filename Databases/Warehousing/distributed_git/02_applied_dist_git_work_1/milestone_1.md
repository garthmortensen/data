# # Distributed git work, first

## Milestone 1

Garth Mortensen
2020.11.21

These are the steps for completing Milestone 1.

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

```cmd
touch Readme.md
```

And add a simple line of text.

```bash
git add .
git commit -m "initializing repo, creating simple readme file so that i can branch off of master."
```

### Create branches

1. We need a special branch which will contain the official "final version" of the submitted work for the whole team. This branch **must** contain content that is merged from the latest version of all the per-team-member work that represents the final version of merged work for the team. It **must not** contain period commits.

   This will be named `Team_09_M1_Final_Submission`. 

```bash
git branch Team_09_M1_Final_Submission
```

2. We need our own branches to contain changes that we're working on - `dev-11900-Garth`. You could create additional branches by adding words to the end of this branch name - `dev-11900-Garth-ETL-Phase1`. *Note this doesn't use underscores, like the other branch.*

   I'll need to commit significant work to this branch. The changed files and directories must be added to the staging index and committed to the branch I'm currently working on.

   When I go to **share my work**, I should commit changes to the dev branch, and push all of my dev branches containing my commits to my bare repo. Zip the bare repo and email it.

   When **receiving others' repos**, unzip the bare repo, create a remote for it, and fetch the commits in the changed branch. These changes can be merged into a local branch (the master branch or your dev branch).

   Create the dev branch.

   ```bash
   git branch dev-11900-Garth
   ```

**Commits** should be quite descriptive. 

> "This was a set of changes to files X, Y, and Z, for the purpose of updating the dimensional attributes in the Customer and Product Dimensions. The Customer changes are complete, but the Product changes have only been made for the Make description and Model name. Need to revisit the other Product DATTs after coordinating with rest of the team about questions with Class and Color."

### Prepare Files

Checkout the dev branch before getting to work.

```bash
git checkout dev-11900-Garth
```

Create files per requirements.

Then stage and commit them.

```bash
$ git add .
$ git status
On branch dev-11900-Garth
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        new file:   Team_09_M1_Final_Submission/Team_09_M1_CoverSheet.pdf
        new file:   Team_09_M1_Final_Submission/Team_09_M1_D1_Version_Control_Policy.pdf
        new file:   Team_09_M1_Final_Submission/Team_09_M1_D3_Submission_Coordinator.pdf
        new file:   Team_09_M1_Final_Submission/Team_09_M1_D4_Liaison.pdf
        new file:   Team_09_M1_Final_Submission/Team_09_M1_ReadMe.pdf
        new file:   Team_09_M1_Final_Submission/Team_09_M1_Support_Files/Team_09_M1_CoverSheet.txt
        new file:   Team_09_M1_Final_Submission/Team_09_M1_Support_Files/Team_09_M1_D1_Version_Control_Policy.txt
        new file:   Team_09_M1_Final_Submission/Team_09_M1_Support_Files/Team_09_M1_D3_Submission_Coordinator.txt
        new file:   Team_09_M1_Final_Submission/Team_09_M1_Support_Files/Team_09_M1_D4_Liaison.txt
        new file:   Team_09_M1_Final_Submission/Team_09_M1_Support_Files/Team_09_M1_ReadMe.md

$ git commit -m "added folder structure and deliverables assigned to me, in both supporting document original formats and deliverable pdf formats. Next, i'll need to incorporate group member files, update the signoff xlsx and the readme as well."
[dev-11900-Garth ac68865] added folder structure and deliverables assigned to me, in both supporting document original formats and deliverable pdf formats. Next, i'll need to incorporate group member files, update the signoff xlsx and the readme as well.
 10 files changed, 53 insertions(+)
 create mode 100644 Team_09_M1_Final_Submission/Team_09_M1_CoverSheet.pdf
 create mode 100644 Team_09_M1_Final_Submission/Team_09_M1_D1_Version_Control_Policy.pdf
 create mode 100644 Team_09_M1_Final_Submission/Team_09_M1_D3_Submission_Coordinator.pdf
 create mode 100644 Team_09_M1_Final_Submission/Team_09_M1_D4_Liaison.pdf
 create mode 100644 Team_09_M1_Final_Submission/Team_09_M1_ReadMe.pdf
 create mode 100644 Team_09_M1_Final_Submission/Team_09_M1_Support_Files/Team_09_M1_CoverSheet.txt
 create mode 100644 Team_09_M1_Final_Submission/Team_09_M1_Support_Files/Team_09_M1_D1_Version_Control_Policy.txt
 create mode 100644 Team_09_M1_Final_Submission/Team_09_M1_Support_Files/Team_09_M1_D3_Submission_Coordinator.txt
 create mode 100644 Team_09_M1_Final_Submission/Team_09_M1_Support_Files/Team_09_M1_D4_Liaison.txt
 create mode 100644 Team_09_M1_Final_Submission/Team_09_M1_Support_Files/Team_09_M1_ReadMe.md
```

Having committed my changes, I'll check the log.

```bash
$ git log
commit ac68865aa30dfdaa219ca6ca74ddda56827afe49 (HEAD -> dev-11900-Garth)
Author: 11900-Garth <xxx@email.com>
Date:   Sat Nov 21 10:52:12 2020 -0600

    added folder structure and deliverables assigned to me, in both supporting document original formats and deliverable pdf formats. Next, i'll need to incorporate group member files, update the signoff xlsx and the readme as well.

commit 4c4ab8c523c363cf61455b96842d3ea5ef480dbc (master, Team_09_M1_Final_Submission)
Author: 11900-Garth <xxx@email.com>
Date:   Sat Nov 21 10:02:34 2020 -0600

    initializing repo, creating simple readme file so that i can branch off of master.
```

Looks good.

### Push files and zip bare repo

I need to push from dev to bare.

```bash
$ git push --set-upstream origin dev-11900-Garth
Enumerating objects: 17, done.
Counting objects: 100% (17/17), done.
Delta compression using up to 4 threads
Compressing objects: 100% (15/15), done.
Writing objects: 100% (17/17), 237.85 KiB | 2.97 MiB/s, done.
Total 17 (delta 0), reused 0 (delta 0)
To C:/gdrive/01_StThomas/10_DataWarehousing/06_project/M1/work/../repo/Team-09-11900-Garth.git
 * [new branch]      dev-11900-Garth -> dev-11900-Garth
Branch 'dev-11900-Garth' set up to track remote branch 'dev-11900-Garth' from 'origin'.
```

I'll zip bare and email it, and await to receive.

---

Now that I've received the .zip bare repo, I need to: 

1. unzip it
2. create a remote for it
3. fetch the commits in the changed branch
4. these changes can then be merged into a local branch (e.g. the master branch or that team member's dev branch)

Connect to the bare repo. Start with a test.

```bash
$ ls -lah "$PWD/../Team-09-11200-Ethan.git"
total 19K
drwxr-xr-x 1 morte 197609   0 Nov 21 12:06 ./
drwxr-xr-x 1 morte 197609   0 Nov 21 13:12 ../
-rw-r--r-- 1 morte 197609 104 Nov 21 10:58 config
-rw-r--r-- 1 morte 197609  73 Nov 21 10:58 description
-rw-r--r-- 1 morte 197609  23 Nov 21 10:58 HEAD
drwxr-xr-x 1 morte 197609   0 Nov 21 10:58 hooks/
drwxr-xr-x 1 morte 197609   0 Nov 21 10:58 info/
drwxr-xr-x 1 morte 197609   0 Nov 21 12:06 objects/
drwxr-xr-x 1 morte 197609   0 Nov 21 10:58 refs/
```

The command worked. Let's git remote add & fetch.

```bash
git remote add ethan_remote "$PWD/../Team-09-11200-Ethan.git"
```

This remote now points to the bare repo, just like it does for Ethan.

* origin is my bare repo(?)
* ethan_remote is Ethan's bare repo

### Fetch

Fetch all objects (commits, blobs, etc) from Ethan's bare repo (Team-09-11200-Ethan.git). Also, it will create a "remote branch" for my local repo, for each branch in Ethan's bare repo.

```bash
$ git fetch ethan_remote
remote: Enumerating objects: 10, done.
remote: Counting objects: 100% (10/10), done.
remote: Compressing objects: 100% (7/7), done.
remote: Total 7 (delta 3), reused 0 (delta 0)
Unpacking objects: 100% (7/7), done.
From C:/gdrive/01_StThomas/10_DataWarehousing/06_project/M1/work/../Team-09-11200-Ethan
 * [new branch]      dev-11200-Ethan -> ethan_remote/dev-11200-Ethan
 * [new branch]      master          -> ethan_remote/master
```

Verify branches.

```bash
$ git branch -rv
  ethan_remote/dev-11200-Ethan d31babc Added the communication policy supprt document and PDF. Added the sign off Excle file and signed of
  ethan_remote/master          ac68865 added folder structure and deliverables assigned to me, in both supporting document original formats and deliverable pdf formats. Next, i'll need to incorporate group member files, update the signoff xlsx and the readme as well.
  origin/dev-11900-Garth       ac68865 added folder structure and deliverables assigned to me, in both supporting document original formats and deliverable pdf formats. Next, i'll need to incorporate group member files, update the signoff xlsx and the readme as well.
```

-rv lists remote branches verbosely.

I still need to update my local master branch, **because we're using fetch instead of pull**, i think.

**git fetch "asked" Ethan's bare repo "what commit is your 'master' branch pointed at now?"** and stored the answer in my local repo in a branch named ethan_remote/master.

Merge local with my dev.

```bash
$ git merge ethan_remote/dev-11200-Ethan
Updating ac68865..d31babc
Fast-forward
 .../Team_09_M1_D2_Communication_Policy.pdf              | Bin 0 -> 48010 bytes
 .../Team_09_M1_D2_Communication_Policy.txt              |   8 ++++++++
 .../Team_09_M1_D5_Install_Signoff.xlsx                  | Bin 0 -> 9984 bytes
 3 files changed, 8 insertions(+)
 create mode 100644 Team_09_M1_Final_Submission/Team_09_M1_D2_Communication_Policy.pdf
 create mode 100644 Team_09_M1_Final_Submission/Team_09_M1_Support_Files/Team_09_M1_D2_Communication_Policy.txt
 create mode 100644 Team_09_M1_Final_Submission/Team_09_M1_Support_Files/Team_09_M1_D5_Install_Signoff.xlsx
```

This updates my local master branch to match the remote we fetched from Ethan's bare (ethan_remote/master), and updates the work directory.

Display content.

```bash
$ cd Team_09_M1_Final_Submission/
$ ls -lah
total 308K
drwxr-xr-x 1 morte 197609   0 Nov 21 13:32 ./
drwxr-xr-x 1 morte 197609   0 Nov 21 10:31 ../
-rw-r--r-- 1 morte 197609 55K Nov 21 08:31 Team_09_M1_CoverSheet.pdf
-rw-r--r-- 1 morte 197609 64K Nov 21 10:32 Team_09_M1_D1_Version_Control_Policy.pdf
-rw-r--r-- 1 morte 197609 47K Nov 21 13:32 Team_09_M1_D2_Communication_Policy.pdf
-rw-r--r-- 1 morte 197609 58K Nov 21 10:33 Team_09_M1_D3_Submission_Coordinator.pdf
-rw-r--r-- 1 morte 197609 52K Nov 21 10:34 Team_09_M1_D4_Liaison.pdf
-rw-r--r-- 1 morte 197609 17K Nov 21 10:46 Team_09_M1_ReadMe.pdf
drwxr-xr-x 1 morte 197609   0 Nov 21 13:32 Team_09_M1_Support_Files/

$ cd Team_09_M1_Support_Files/
$ ls -lah
total 38K
drwxr-xr-x 1 morte 197609    0 Nov 21 13:32 ./
drwxr-xr-x 1 morte 197609    0 Nov 21 13:32 ../
-rw-r--r-- 1 morte 197609  125 Nov 21 08:27 Team_09_M1_CoverSheet.txt
-rw-r--r-- 1 morte 197609 1.3K Nov 20 18:53 Team_09_M1_D1_Version_Control_Policy.txt
-rw-r--r-- 1 morte 197609  525 Nov 21 13:32 Team_09_M1_D2_Communication_Policy.txt
-rw-r--r-- 1 morte 197609  496 Nov 20 19:07 Team_09_M1_D3_Submission_Coordinator.txt
-rw-r--r-- 1 morte 197609   60 Nov 20 19:06 Team_09_M1_D4_Liaison.txt
-rw-r--r-- 1 morte 197609 9.8K Nov 21 13:32 Team_09_M1_D5_Install_Signoff.xlsx
-rw-r--r-- 1 morte 197609 1.1K Nov 21 10:46 Team_09_M1_ReadMe.md
```

I see the newly added files. Excellent.

I'll inspect the new files...

- Updating Team_09_M1_D5_Install_Signoff.xlsx
  - Export as pdf
- Updating Team_09_M1_ReadMe.md
  - Export as pdf

Stage and commit files.

```bash
$ git status
On branch dev-11900-Garth
Your branch is ahead of 'origin/dev-11900-Garth' by 1 commit.
  (use "git push" to publish your local commits)

Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        deleted:    ../../Readme.md
        modified:   ../Team_09_M1_ReadMe.pdf
        modified:   Team_09_M1_D5_Install_Signoff.xlsx
        modified:   Team_09_M1_ReadMe.md

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        ../Team_09_M1_D5_Install_Signoff.pdf

no changes added to commit (use "git add" and/or "git commit -a")

$ git add .

$ git commit -m "merged Ethans files into my repo, updated readme and signoff, exported pdfs and deleted unwanted readme file in parent folder. Ready to be verified then submitted"
[dev-11900-Garth e7bffd2] merged Ethans files into my repo, updated readme and signoff, exported pdfs and deleted unwanted readme file in parent folder. Ready to be verified then submitted
 2 files changed, 8 insertions(+), 1 deletion(-)
 rewrite Team_09_M1_Final_Submission/Team_09_M1_Support_Files/Team_09_M1_D5_Install_Signoff.xlsx (64%)
 
 $ git push
```

My dev branch is now up to date.

I already created the "final release" branch. Commits in this branch are intended to the final version and shareable with others.

This bare repository must also contain **all** per-team-member dev branches.

```bash
$ git push origin Team_09_M1_Final_Submission
Total 0 (delta 0), reused 0 (delta 0)
To C:/gdrive/01_StThomas/10_DataWarehousing/06_project/M1/work/../repo/Team-09-11900-Garth.git
 * [new branch]      Team_09_M1_Final_Submission -> Team_09_M1_Final_Submission
```

*That did not work.*

You must submit a bare repo that clearly shows each team member committing their own work to their own branch, and then merging (as a team) these results together and placing the final version in the final submission branch.

- We have each committed our own work to our own branch.
- I have merged our results together.
- I need to place the final version in the final submission branch.

----

It seems like I prematurely created the final branch. I will remove it and recreate it (hoping this creates a branch which contains all the latest changes).

```bash
$ git branch -d Team_09_M1_Final_Submission
Deleted branch Team_09_M1_Final_Submission (was 4c4ab8c).

$ git branch Team_09_M1_Final_Submission
$ ls -lah
total 12K
drwxr-xr-x 1 morte 197609 0 Nov 21 14:15 ./
drwxr-xr-x 1 morte 197609 0 Nov 21 14:18 ../
drwxr-xr-x 1 morte 197609 0 Nov 21 14:18 .git/
drwxr-xr-x 1 morte 197609 0 Nov 21 14:15 Team_09_M1_Final_Submission/
```

Yes, that worked. 

Now I push this to remote.

```bash
$ git push --set-upstream origin Team_09_M1_Final_Submission
Total 0 (delta 0), reused 0 (delta 0)
To C:/gdrive/01_StThomas/10_DataWarehousing/06_project/M1/work/../repo/Team-09-11900-Garth.git
   4c4ab8c..c330eb1  Team_09_M1_Final_Submission -> Team_09_M1_Final_Submission
Branch 'Team_09_M1_Final_Submission' set up to track remote branch 'Team_09_M1_Final_Submission' from 'origin'.
```

It's ready to be zipped then verified then posted.

```bash
$ cd repo/
$ 7z a Team_09_M1_Final_Submission.zip Team-09-11900-Garth.git

7-Zip 19.00 (x64) : Copyright (c) 1999-2018 Igor Pavlov : 2019-02-21
Scanning the drive:
42 folders, 53 files, 555009 bytes (543 KiB)
Creating archive: Team_09_M1_Final_Submission.zip
Add new data to archive: 42 folders, 53 files, 555009 bytes (543 KiB)
Files read from disk: 53
Archive size: 564697 bytes (552 KiB)
Everything is Ok
7z a Team_09_M1_Final_Submission.zip Team-09-11900-Garth.git
```

Zipped and ready to share.

When Ethan views my bare repo, he doesn't see his own commits. I am going to checkout an earlier commit to step back in time and try to redo the process, correctly. I use [this](https://stackoverflow.com/a/4114122/5825523) guide to do so.

```bash
$ git log
commit c330eb124a0fe6ba49bd94241a8b62a3238dd0fd (HEAD -> dev-11900-Garth, origin/dev-11900-Garth, origin/Team_09_M1_Final_Submission, Team_09_M1_Final_Submission)
Author: 11900-Garth <xxx@email.com>
Date:   Sat Nov 21 13:53:59 2020 -0600

    my branch was ahead by 2 commits, and i needed to add delete modified and add files, then recommit

commit e7bffd26f6996721da967d0bdc615fd4a52f6268
Author: 11900-Garth <xxx@email.com>
Date:   Sat Nov 21 13:50:03 2020 -0600

    merged Ethans files into my repo, updated readme and signoff, exported pdfs and deleted unwanted readme file in parent folder. Ready to be verified then submitted

commit d31babc193389d0ef27c97662110df979f7aecfa (ethan_remote/dev-11200-Ethan)
Author: 11200-Ethan <fros2171@stthomas.edu>
Date:   Sat Nov 21 12:02:01 2020 -0600

    Added the communication policy supprt document and PDF. Added the sign off Excle file and signed of

commit ac68865aa30dfdaa219ca6ca74ddda56827afe49 (ethan_remote/master)
Author: 11900-Garth <xxx@email.com>
Date:   Sat Nov 21 10:52:12 2020 -0600

    added folder structure and deliverables assigned to me, in both supporting document original formats and deliverable pdf formats. Next, i'll need to incorporate group member files, update the signoff xlsx and the readme as well.

commit 4c4ab8c523c363cf61455b96842d3ea5ef480dbc (master)
Author: 11900-Garth <xxx@email.com>
Date:   Sat Nov 21 10:02:34 2020 -0600

    initializing repo, creating simple readme file so that i can branch off of master.
```

I'll revert back to the original commit.

```bash
$ git revert c330 e7bff d31bab ac688
```

Write an explanation in the commit...

```bash
morte@Cyberfuchi5 MINGW64 /c/gdrive/01_StThomas/10_DataWarehousing/06_project/M1/work ((88eda4b...)|REVERTING)
$ git status
HEAD detached from c330eb1
Revert currently in progress.
  (run "git revert --continue" to continue)
  (use "git revert --skip" to skip this patch)
  (use "git revert --abort" to cancel the revert operation)

nothing to commit, working tree clean
```

I am going to continue...but I need to fix my detached head as seen here:

```bash
morte@Cyberfuchi5 MINGW64 /c/gdrive/01_StThomas/10_DataWarehousing/06_project/M1/work ((ca5b97f...))
$ git commit
HEAD detached from c330eb1
```

I'll use [this](https://stackoverflow.com/a/10229202/5825523) post.

```bash
$ git branch tmp
morte@Cyberfuchi5 MINGW64 /c/gdrive/01_StThomas/10_DataWarehousing/06_project/M1/work ((ca5b97f...))
$ git checkout master
Previous HEAD position was ca5b
```

Now ow incorporate the changes you made into `master`. Run `git merge tmp` from the `master` branch. I should be on the `master` branch after running `git checkout master`.

```bash
morte@Cyberfuchi5 MINGW64 /c/gdrive/01_StThomas/10_DataWarehousing/06_project/M1/work (master)
$ git merge tmp
Updating 4c4ab8c..ca5b97f
Fast-forward
```

Ok, I should be back in business...

```bash
morte@Cyberfuchi5 MINGW64 /c/gdrive/01_StThomas/10_DataWarehousing/06_project/M1/work (master)
$ git branch
  Team_09_M1_Final_Submission
  dev-11900-Garth
* master
  tmp
```

Not good. My dev branch contains all my previous dev work...Ok...it seems like all that just created useless history and a branch. 

My problem is that my branch contains the latest files. So I need to revert to something earlier. I'll revert and create an old-state branch, per [this](https://stackoverflow.com/questions/4114095/how-do-i-revert-a-git-repository-to-a-previous-commit/4114122#4114122) same post as before.

```bash
morte@Cyberfuchi5 MINGW64 /c/gdrive/01_StThomas/10_DataWarehousing/06_project/M1/work (dev-11900-Garth)
$ git checkout -b old-state 4c4ab
Switched to a new branch 'old-state'
```

Nice! I see the files in the directory are reverted. I'm going to remove the unwanted branches.

```bash
morte@Cyberfuchi5 MINGW64 /c/gdrive/01_StThomas/10_DataWarehousing/06_project/M1/work (old-state)
$ git branch -d dev-11900-Garth
warning: deleting branch 'dev-11900-Garth' that has been merged to
         'refs/remotes/origin/dev-11900-Garth', but not yet merged to HEAD.
Deleted branch dev-11900-Garth (was c330eb1).

morte@Cyberfuchi5 MINGW64 /c/gdrive/01_StThomas/10_DataWarehousing/06_project/M1/work (old-state)
$ git branch -d Team_09_M1_Final_Submission
warning: deleting branch 'Team_09_M1_Final_Submission' that has been merged to
         'refs/remotes/origin/Team_09_M1_Final_Submission', but not yet merged to HEAD.
Deleted branch Team_09_M1_Final_Submission (was c330eb1).

morte@Cyberfuchi5 MINGW64 /c/gdrive/01_StThomas/10_DataWarehousing/06_project/M1/work (old-state)
$ git branch -d tmp
error: The branch 'tmp' is not fully merged.
If you are sure you want to delete it, run 'git branch -D tmp'.

morte@Cyberfuchi5 MINGW64 /c/gdrive/01_StThomas/10_DataWarehousing/06_project/M1/work (old-state)
$ git branch -D tmp
Deleted branch tmp (was ca5b97f).

morte@Cyberfuchi5 MINGW64 /c/gdrive/01_StThomas/10_DataWarehousing/06_project/M1/work (old-state)
$ git branch
  master
* old-state
```

Now I'll delete old-state and recreate dev.

```bash
morte@Cyberfuchi5 MINGW64 /c/gdrive/01_StThomas/10_DataWarehousing/06_project/M1/work (old-state)
$ git checkout master
Switched to branch 'master'

morte@Cyberfuchi5 MINGW64 /c/gdrive/01_StThomas/10_DataWarehousing/06_project/M1/work (master)
$ git branch -d old-state
Deleted branch old-state (was 4c4ab8c).

morte@Cyberfuchi5 MINGW64 /c/gdrive/01_StThomas/10_DataWarehousing/06_project/M1/work (master)
$ git branch
* master

morte@Cyberfuchi5 MINGW64 /c/gdrive/01_StThomas/10_DataWarehousing/06_project/M1/work (master)
$ git branch dev-11900-Garth

morte@Cyberfuchi5 MINGW64 /c/gdrive/01_StThomas/10_DataWarehousing/06_project/M1/work (master)
$ git checkout dev-11900-Garth
Switched to branch 'dev-11900-Garth'
```

### Begin Anew

Think I'm back to square one, thankfully. 

Move on in a forward direction.

I need to:

> YOU fetch from his bare repository, create LOCAL branches for all of his branches (which are now represented by REMOTE branches in your local repository). You need to merge these LOCAL branches with "his remote" branches. Then, as needed, you need to merge from the local branches representing his work into your local branches (if you are working on the same thing, like the sign-off spreadsheet).

Fetch it in the way outlined in the Git assignment. Then moved his to my working folder. Then create a new branch.

### Fetch

Fetch from his bare repo.

```bash
git fetch ethan_remote
```

**Create local branches for all of his branches (which are now represented by REMOTE branches in your local repository).**

This fetches all the objects (commits, blobs, etc.) from Ethan's bare repo.
It creates a "remote branch" in my local repo (work/.git) for each of the branches in Ethan's bare repository

```bash
$ git branch -r
  ethan_remote/dev-11200-Ethan
  ethan_remote/master
  origin/Team_09_M1_Final_Submission
  origin/dev-11900-Garth
```

I now see his remote branch in my local repo.

Now I must merge with local master. The git fetch "asked" Ethan's bare repo, "what commit is your 'master' branch pointed at now?", and stored the answer in my local repo in a branch named ethan_remote/master.

```bash
$ git merge --ff-only ethan_remote/master
Already up to date.
```

This updated my local master branch to match the remote master branch I fetched from Ethan's bare repo (ethan_remote/master) and updated the work directory too.

--ff-only = we can only merge by 'fast-forward'

Now I need to push to my bare repo "origin".

```bash
$ git push origin master
Enumerating objects: 23, done.
Counting objects: 100% (23/23), done.
Delta compression using up to 4 threads
Compressing objects: 100% (15/15), done.
Writing objects: 100% (17/17), 19.79 KiB | 450.00 KiB/s, done.
Total 17 (delta 9), reused 0 (delta 0)
To C:/gdrive/01_StThomas/10_DataWarehousing/06_project/M1/work/../repo/Team-09-11900-Garth.git
 * [new branch]      master -> master
```

This pushed all the changes to my bare repository.

Now all branches should agree.

My branches don't contain any files.

When I checkout origin/master, it switched current repo from master to a sha1 value, due to a detached head state. If I were working alone, I'd just delete this repo and start over. Not an option since Ethan's repo contains my historical repo. So how do I make this work?

C:\gdrive\01_StThomas\10_DataWarehousing\06_project\M1\repo\Team-09-11900-Garth.git\refs\heads

does not contain Ethan's branches...

**Create my dev branch based on my local repo's remembered value for "what Ethan's dev branch pointed to the last time we fetched"**

**This is what I probably messed up the first time around????**

```bash
$ git branch dev-11900-Garth-merging ethan_remote/dev-11200-Ethan
Branch 'dev-11900-Garth-merging' set up to track remote branch 'dev-11200-Ethan' from 'ethan_remote'.

git checkout dev-11900-Garth-merging 

$ ls -lah
total 13K
drwxr-xr-x 1 morte 197609  0 Nov 23 16:11 ./
drwxr-xr-x 1 morte 197609  0 Nov 23 16:12 ../
drwxr-xr-x 1 morte 197609  0 Nov 23 16:11 .git/
-rw-r--r-- 1 morte 197609 38 Nov 23 13:29 Readme.md
drwxr-xr-x 1 morte 197609  0 Nov 23 16:11 Team_09_M1_Final_Submission/
```

Looking good. Add the updated files in the directory.

```bash
git add .

git commit -m "somehow corrected and returned to a good branch. adding file updates"
[dev-11900-Garth-merging bb11235] somehow corrected and returned to a good branch. adding file updates
 4 files changed, 8 insertions(+), 1 deletion(-)
 create mode 100644 Team_09_M1_Final_Submission/Team_09_M1_D5_Install_Signoff.pdf
 rewrite Team_09_M1_Final_Submission/Team_09_M1_ReadMe.pdf (86%)
 rewrite Team_09_M1_Final_Submission/Team_09_M1_Support_Files/Team_09_M1_D5_Install_Signoff.xlsx (64%)
```

push.

```bash
git push origin dev-11900-Garth-merging
Enumerating objects: 14, done.
Counting objects: 100% (14/14), done.
Delta compression using up to 4 threads
Compressing objects: 100% (8/8), done.
Writing objects: 100% (8/8), 223.94 KiB | 3.50 MiB/s, done.
Total 8 (delta 5), reused 0 (delta 0)
To C:/gdrive/01_StThomas/10_DataWarehousing/06_project/M1/work/../repo/Team-09-11900-Garth.git
 * [new branch]      dev-11900-Garth-merging -> dev-11900-Garth-merging
```

I shouldn't have done that, but no way am I going to revert again. That seemed to be the wrong move at the time. I'll merge the new branch back into dev.

```bash
git checkout dev-11900-Garth
Switched to branch 'dev-11900-Garth'

git merge dev-11900-Garth-merging
CONFLICT (modify/delete): Team_09_M1_Final_Submission/Team_09_M1_Support_Files/Team_09_M1_ReadMe.md deleted in HEAD and modified in dev-11900-Garth-merging. Version dev-11900-Garth-merging of Team_09_M1_Final_Submission/Team_09_M1_Support_Files/Team_09_M1_ReadMe.md left in tree.
CONFLICT (modify/delete): Team_09_M1_Final_Submission/Team_09_M1_Support_Files/Team_09_M1_D5_Install_Signoff.xlsx deleted in HEAD and modified in dev-11900-Garth-merging. Version dev-11900-Garth-merging of Team_09_M1_Final_Submission/Team_09_M1_Support_Files/Team_09_M1_D5_Install_Signoff.xlsx left in tree.
CONFLICT (modify/delete): Team_09_M1_Final_Submission/Team_09_M1_ReadMe.pdf deleted in HEAD and modified in dev-11900-Garth-merging. Version dev-11900-Garth-merging of Team_09_M1_Final_Submission/Team_09_M1_ReadMe.pdf left in tree.
Automatic merge failed; fix conflicts and then commit the result.
```

Trying [git mergetool](https://stackoverflow.com/a/163659/5825523).

```bash
$ git mergetool

This message is displayed because 'merge.tool' is not configured.
See 'git mergetool --tool-help' or 'git help config' for more details.
'git mergetool' will now attempt to use one of the following tools:
opendiff kdiff3 tkdiff xxdiff meld tortoisemerge gvimdiff diffuse diffmerge ecmerge p4merge araxis bc codecompare smerge emerge vimdiff
Merging:
Team_09_M1_Final_Submission/Team_09_M1_ReadMe.pdf
Team_09_M1_Final_Submission/Team_09_M1_Support_Files/Team_09_M1_D5_Install_Signoff.xlsx
Team_09_M1_Final_Submission/Team_09_M1_Support_Files/Team_09_M1_ReadMe.md

Deleted merge conflict for 'Team_09_M1_Final_Submission/Team_09_M1_ReadMe.pdf':
  {local}: deleted
  {remote}: modified file
Use (m)odified or (d)eleted file, or (a)bort? m

Deleted merge conflict for 'Team_09_M1_Final_Submission/Team_09_M1_Support_Files/Team_09_M1_D5_Install_Signoff.xlsx':
  {local}: deleted
  {remote}: modified file
Use (m)odified or (d)eleted file, or (a)bort? m

Deleted merge conflict for 'Team_09_M1_Final_Submission/Team_09_M1_Support_Files/Team_09_M1_ReadMe.md':
  {local}: deleted
  {remote}: modified file
Use (m)odified or (d)eleted file, or (a)bort? m
```

doing stuff.

```bash
$ git status
On branch dev-11900-Garth
All conflicts fixed but you are still merging.
  (use "git commit" to conclude merge)

Changes to be committed:
        new file:   Team_09_M1_Final_Submission/Team_09_M1_D5_Install_Signoff.pdf
        new file:   Team_09_M1_Final_Submission/Team_09_M1_ReadMe.pdf
        new file:   Team_09_M1_Final_Submission/Team_09_M1_Support_Files/Team_09_M1_D5_Install_Signoff.xlsx
        new file:   Team_09_M1_Final_Submission/Team_09_M1_Support_Files/Team_09_M1_ReadMe.md

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        Team_09_M1_Final_Submission/Team_09_M1_ReadMe.pdf.orig
        Team_09_M1_Final_Submission/Team_09_M1_Support_Files/Team_09_M1_D5_Install_Signoff.xlsx.orig
        Team_09_M1_Final_Submission/Team_09_M1_Support_Files/Team_09_M1_ReadMe.md.orig


morte@Cyberfuchi5 MINGW64 /c/gdrive/01_StThomas/10_DataWarehousing/06_project/M1/work (dev-11900-Garth|MERGING)
$ git commit
Error in /usr/share/nano/git.nanorc on line 1: Regex strings must begin and end with a " character
" not understoodare/nano/git.nanorc on line 2: Command "
" not understoodare/nano/git.nanorc on line 10: Command "
" not understoodare/nano/git.nanorc on line 15: Command "
Error in /usr/share/nano/git.nanorc on line 19: Regex strings must begin and end with a " character
" not understoodare/nano/git.nanorc on line 20: Command "
" not understoodare/nano/git.nanorc on line 23: Command "
" not understoodare/nano/git.nanorc on line 26: Command "
" not understoodare/nano/git.nanorc on line 33: Command "
" not understoodare/nano/git.nanorc on line 36: Command "
" not understoodare/nano/git.nanorc on line 42: Command "
" not understoodare/nano/git.nanorc on line 44: Command "
" not understoodare/nano/git.nanorc on line 47: Command "
" not understoodare/nano/git.nanorc on line 50: Command "
" not understoodare/nano/git.nanorc on line 51: Command "
Error in /usr/share/nano/git.nanorc on line 53: Regex strings must begin and end with a " character
" not understoodare/nano/git.nanorc on line 54: Command "
" not understoodare/nano/git.nanorc on line 57: Command "
" not understoodare/nano/git.nanorc on line 60: Command "
" not understoodare/nano/git.nanorc on line 74: Command "
" not understoodare/nano/git.nanorc on line 77: Command "
" not understoodare/nano/git.nanorc on line 80: Command "
[dev-11900-Garth 68be42d] Merge branch 'dev-11900-Garth-merging' into dev-11900-Garth. I'm utterly lost at this point.
```

I no longer have any of the pre merge files.

How about trying to push Ethan's branch to bare?

```bash
morte@Cyberfuchi5 MINGW64 /c/gdrive/01_StThomas/10_DataWarehousing/06_project/M1/work (dev-11900-Garth)
$ git status
On branch dev-11900-Garth
Untracked files:
  (use "git add <file>..." to include in what will be committed)
        Team_09_M1_Final_Submission/Team_09_M1_ReadMe.pdf.orig
        Team_09_M1_Final_Submission/Team_09_M1_Support_Files/Team_09_M1_D5_Install_Signoff.xlsx.orig
        Team_09_M1_Final_Submission/Team_09_M1_Support_Files/Team_09_M1_ReadMe.md.orig

nothing added to commit but untracked files present (use "git add" to track)

morte@Cyberfuchi5 MINGW64 /c/gdrive/01_StThomas/10_DataWarehousing/06_project/M1/work (dev-11900-Garth)
$ git branch -r
  ethan_remote/dev-11200-Ethan
  ethan_remote/master
  origin/Team_09_M1_Final_Submission
  origin/dev-11900-Garth
  origin/dev-11900-Garth-merging
  origin/master

morte@Cyberfuchi5 MINGW64 /c/gdrive/01_StThomas/10_DataWarehousing/06_project/M1/work (dev-11900-Garth)
$ git checkout ethan_remote/dev-11200-Ethan
Note: switching to 'ethan_remote/dev-11200-Ethan'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by switching back to a branch.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -c with the switch command. Example:

  git switch -c <new-branch-name>

Or undo this operation with:

  git switch -

Turn off this advice by setting config variable advice.detachedHead to false

HEAD is now at d31babc Added the communication policy supprt document and PDF. Added the sign off Excle file and signed of

morte@Cyberfuchi5 MINGW64 /c/gdrive/01_StThomas/10_DataWarehousing/06_project/M1/work ((d31babc...))
$ git push
fatal: You are not currently on a branch.
To push the history leading to the current (detached HEAD)
state now, use

    git push origin HEAD:<name-of-remote-branch>


morte@Cyberfuchi5 MINGW64 /c/gdrive/01_StThomas/10_DataWarehousing/06_project/M1/work ((d31babc...))
$ git push origin HEAD:ethan_remote/dev-11200-Ethan
error: The destination you provided is not a full refname (i.e.,
starting with "refs/"). We tried to guess what you meant by:

- Looking for a ref that matches 'ethan_remote/dev-11200-Ethan' on the remote side.
- Checking if the <src> being pushed ('HEAD')
  is a ref in "refs/{heads,tags}/". If so we add a corresponding
  refs/{heads,tags}/ prefix on the remote side.

Neither worked, so we gave up. You must fully qualify the ref.
hint: The <src> part of the refspec is a commit object.
hint: Did you mean to create a new branch by pushing to
hint: 'HEAD:refs/heads/ethan_remote/dev-11200-Ethan'?
error: failed to push some refs to 'C:/gdrive/01_StThomas/10_DataWarehousing/06_project/M1/work/../repo/Team-09-11900-Garth.git'

morte@Cyberfuchi5 MINGW64 /c/gdrive/01_StThomas/10_DataWarehousing/06_project/M1/work ((d31babc...))
$ git push origin HEAD:dev-11900-Garth
To C:/gdrive/01_StThomas/10_DataWarehousing/06_project/M1/work/../repo/Team-09-11900-Garth.git
 ! [rejected]        HEAD -> dev-11900-Garth (non-fast-forward)
error: failed to push some refs to 'C:/gdrive/01_StThomas/10_DataWarehousing/06_project/M1/work/../repo/Team-09-11900-Garth.git'
hint: Updates were rejected because a pushed branch tip is behind its remote
hint: counterpart. Check out this branch and integrate the remote changes
hint: (e.g. 'git pull ...') before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.
```

hmm.

```bash
morte@Cyberfuchi5 MINGW64 /c/gdrive/01_StThomas/10_DataWarehousing/06_project/M1/work ((d31babc...))
$ git pull
You are not currently on a branch.
Please specify which branch you want to merge with.
See git-pull(1) for details.

    git pull <remote> <branch>


morte@Cyberfuchi5 MINGW64 /c/gdrive/01_StThomas/10_DataWarehousing/06_project/M1/work ((d31babc...))
$ git pull ethan_remote
You are not currently on a branch.
Please specify which branch you want to merge with.
See git-pull(1) for details.

    git pull <remote> <branch>


morte@Cyberfuchi5 MINGW64 /c/gdrive/01_StThomas/10_DataWarehousing/06_project/M1/work ((d31babc...))
$ git pull ethan_remote/master
fatal: 'ethan_remote/master' does not appear to be a git repository
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.

morte@Cyberfuchi5 MINGW64 /c/gdrive/01_StThomas/10_DataWarehousing/06_project/M1/work ((d31babc...))
$ git pull ethan_remote/
fatal: 'ethan_remote/' does not appear to be a git repository
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.

morte@Cyberfuchi5 MINGW64 /c/gdrive/01_StThomas/10_DataWarehousing/06_project/M1/work ((d31babc...))
$ git pull ethan_remote/dev-11200-Ethan
fatal: 'ethan_remote/dev-11200-Ethan' does not appear to be a git repository
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
```

Access rights?

Try to pull again.

```bash
morte@Cyberfuchi5 MINGW64 /c/gdrive/01_StThomas/10_DataWarehousing/06_project/M1/work ((d31babc...))
$ git pull ethan_remote/dev-11200-Ethan
fatal: 'ethan_remote/dev-11200-Ethan' does not appear to be a git repository
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.

morte@Cyberfuchi5 MINGW64 /c/gdrive/01_StThomas/10_DataWarehousing/06_project/M1/work ((d31babc...))
$ git checkout ethan_remote/dev-11200-Ethan
HEAD is now at d31babc Added the communication policy supprt document and PDF. Added the sign off Excle file and signed of

morte@Cyberfuchi5 MINGW64 /c/gdrive/01_StThomas/10_DataWarehousing/06_project/M1/work ((d31babc...))
$ git pull
You are not currently on a branch.
Please specify which branch you want to merge with.
See git-pull(1) for details.

    git pull <remote> <branch>
```

I can't pull from these branches...

Trying to simply merge everything and push to remote bare.

```bash
morte@Cyberfuchi5 MINGW64 /c/gdrive/01_StThomas/10_DataWarehousing/06_project/M1/work (dev-11900-Garth-merging)
$ git checkout Team_09_M1_Final_Submission --
Switched to a new branch 'Team_09_M1_Final_Submission'
Branch 'Team_09_M1_Final_Submission' set up to track remote branch 'Team_09_M1_Final_Submission' from 'origin'.

morte@Cyberfuchi5 MINGW64 /c/gdrive/01_StThomas/10_DataWarehousing/06_project/M1/work (Team_09_M1_Final_Submission)
$ git merge dev-11900-Garth-merging
Error in /usr/share/nano/git.nanorc on line 1: Regex strings must begin and end with a " character
" not understoodare/nano/git.nanorc on line 2: Command "
" not understoodare/nano/git.nanorc on line 10: Command "
" not understoodare/nano/git.nanorc on line 15: Command "
Error in /usr/share/nano/git.nanorc on line 19: Regex strings must begin and end with a " character
" not understoodare/nano/git.nanorc on line 20: Command "
" not understoodare/nano/git.nanorc on line 23: Command "
" not understoodare/nano/git.nanorc on line 26: Command "
" not understoodare/nano/git.nanorc on line 33: Command "
" not understoodare/nano/git.nanorc on line 36: Command "
" not understoodare/nano/git.nanorc on line 42: Command "
" not understoodare/nano/git.nanorc on line 44: Command "
" not understoodare/nano/git.nanorc on line 47: Command "
" not understoodare/nano/git.nanorc on line 50: Command "
" not understoodare/nano/git.nanorc on line 51: Command "
Error in /usr/share/nano/git.nanorc on line 53: Regex strings must begin and end with a " character
" not understoodare/nano/git.nanorc on line 54: Command "
" not understoodare/nano/git.nanorc on line 57: Command "
" not understoodare/nano/git.nanorc on line 60: Command "
" not understoodare/nano/git.nanorc on line 74: Command "
" not understoodare/nano/git.nanorc on line 77: Command "
" not understoodare/nano/git.nanorc on line 80: Command "
Merge made by the 'recursive' strategy.

morte@Cyberfuchi5 MINGW64 /c/gdrive/01_StThomas/10_DataWarehousing/06_project/M1/work (Team_09_M1_Final_Submission)
$ git status
On branch Team_09_M1_Final_Submission
Your branch is ahead of 'origin/Team_09_M1_Final_Submission' by 2 commits.
  (use "git push" to publish your local commits)

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        Team_09_M1_Final_Submission/Team_09_M1_ReadMe.pdf.orig
        Team_09_M1_Final_Submission/Team_09_M1_Support_Files/Team_09_M1_D5_Install_Signoff.xlsx.orig
        Team_09_M1_Final_Submission/Team_09_M1_Support_Files/Team_09_M1_ReadMe.md.orig
        
morte@Cyberfuchi5 MINGW64 /c/gdrive/01_StThomas/10_DataWarehousing/06_project/M1/work (Team_09_M1_Final_Submission)
$ git push --set-upstream origin Team_09_M1_Final_Submission
Enumerating objects: 1, done.
Counting objects: 100% (1/1), done.
Writing objects: 100% (1/1), 321 bytes | 321.00 KiB/s, done.
Total 1 (delta 0), reused 0 (delta 0)
To C:/gdrive/01_StThomas/10_DataWarehousing/06_project/M1/work/../repo/Team-09-11900-Garth.git
   c330eb1..79a04e1  Team_09_M1_Final_Submission -> Team_09_M1_Final_Submission
Branch 'Team_09_M1_Final_Submission' set up to track remote branch 'Team_09_M1_Final_Submission' from 'origin'.

morte@Cyberfuchi5 MINGW64 /c/gdrive/01_StThomas/10_DataWarehousing/06_project/M1/work (Team_09_M1_Final_Submission)
$ git checkout dev-11900-Garth
Switched to branch 'dev-11900-Garth'

morte@Cyberfuchi5 MINGW64 /c/gdrive/01_StThomas/10_DataWarehousing/06_project/M1/work (dev-11900-Garth)
$ git checkout Team_09_M1_Final_Submission
Switched to branch 'Team_09_M1_Final_Submission'
Your branch is up to date with 'origin/Team_09_M1_Final_Submission'.
```

Zip this and share it. See what Ethan sees.

Wait first correct the branch names.

```bash
$ git branch -D dev-11900-Garth
Deleted branch dev-11900-Garth (was 68be42d).

$ git branch -m dev-11900-Garth-merging dev-11900-Garth

$ git branch
* Team_09_M1_Final_Submission
  dev-11200-Ethan
  dev-11900-Garth
  master
```

zip it.

```bash
$ cd ../repo/

$ 7z a Team_09_M1_Final_Submission.zip Team-09-11900-Garth.git
```

Upload it and done.

## History

```bash
  155  git config
  156  git config user.name
  157  git config user.email
  158  exit
  159  mkdir work
  160  mkdir bare
  161  git init --bare Team-09-11900-Garth.git
  162  git status
  163  exit
  164  mkdir repo
  165  cd repo
  166  git init --bare Team-09-11900-Garth.git
  167  git status
  168  git status
  169  cd Team-09-11900-Garth.git/
  170  git status
  171  exit
  172  ls -lah
  173  mkdir work
  174  cd work
  175  git init
  176  cd ../repo/
  177  ls -la
  178  ls -la
  179  cd ../
  180  cd work/
  181  ls -la
  182  cd ../
  183  cd repo/
  184  ls
  185  cd Team-09-11900-Garth.git/
  186  ls -lah
  187  cd ../
  188  cd ../
  189  cd work/
  190  cd .git/
  191  ls -lah
  192  $PWD/../repo/Team-09-11900-Garth.git ls
  193  ls $PWD/../repo/Team-09-11900-Garth.git
  194  $PWD/../../repo/Team-09-11900-Garth.git ls
  195  cd ../
  196  $PWD/../../repo/Team-09-11900-Garth.git ls
  197  $PWD/../repo/Team-09-11900-Garth.git ls
  198  ls -lah "$PWD/../repo/11900-Garth_Larry.git"
  199  ls -lah "$PWD/../repo/Team-09-11900-Garth.git"
  200  git remote add origin "$PWD/../repo/Team-09-11900-Garth.git"
  201  git branch Team_09_M1_Final_Submission
  202  git branch
  203  git branch Team_09_M1_Final_Submission
  204  ls -la
  205  git status
  206  git add .
  207  git commit -m "initializing repo, creating simple readme file so that i can branch off of master."
  208  git branch
  209  git branch Team_09_M1_Final_Submission
  210  git branch dev-11900-Garth
  211  git status
  212  git checkout dev-11900-Garth
  213  ls -la
  214  tree
  215  git status
  216  git add .
  217  git status
  218  git commit -m "added folder structure and deliverables assigned to me, in both supporting document original formats and deliverable pdf formats. Next, i'll need to incorporate group member files, update the signoff xlsx and the readme as well."
  219  git log
  220  git status
  221  git push
  222  git push --set-upstream origin dev-11900-Garth
  223  exit
  224  git status
  225  ls -lah "$PWD/../Team-09-11200-Ethan.git"
  226  git remote add Hey_Larry "$PWD/../Team-09-11200-Ethan.git"
  227  git remote add add_Ethan "$PWD/../Team-09-11200-Ethan.git"
  228  git remote
  229  git remote remove Hey_Larry
  230  git remote remove add_Ethan
  231  git remote add ethan_remote "$PWD/../Team-09-11200-Ethan.git"
  232  git fetch ethan_remote
  233  git branch -rv
  234  git merge --ff-only ethan_remote/master
  235  git status
  236  git merge ethan_remote/master
  237  git merge ethan_remote/dev-11200-Ethan
  238  ls -lah
  239  cd Team_09_M1_Final_Submission/
  240  ls lah
  241  ls
  242  ls -lah
  243  cd Team_09_M1_Support_Files/
  244  ls -lah
  245  git branch
  246  git status
  247  git status
  248  git add .
  249  git commit -m "merged Ethans files into my repo, updated readme and signoff, exported pdfs and deleted unwanted readme file in parent folder. Ready to be verified then submitted"
  250  git status
  251  cd ../
  252  ls
  253  git status
  254  git add ../Readme.md
  255  git status
  256  git add Team_09_M1_ReadMe.pdf
  257  git status
  258  git add Team_09_M1_D5_Install_Signoff.pdf
  259  git status
  260  git commit -m "my branch was ahead by 2 commits, and i needed to add delete modified and add files, then recommit"
  261  git status
  262  git push
  263  git branch
  264  git branch
  265  git push origin Team_09_M1_Final_Submission
  266  git checkout Team_09_M1_Final_Submission
  267  git checkout dev-11900-Garth
  268  git branch
  269  cd ../
  270  git status
  271  git branch
  272  git checkout dev-11900-Garth
  273  git status
  274  git checkout Team_09_M1_Final_Submission
  275  git checkout dev-11900-Garth
  276  git status
  277  git branch -d Team_09_M1_Final_Submission
  278  git status
  279  ls -la
  280  git branch Team_09_M1_Final_Submission
  281  git status
  282  ls -la
  283  git checkout Team_09_M1_Final_Submission
  284  ls -la
  285  cd Team_09_M1_Final_Submission/
  286  ls -la
  287  cd ../
  288  ls -lah
  289  exit
  290  git status
  291  git push
  292  git push --set-upstream origin Team_09_M1_Final_Submission
  293  cd ../
  294  ls
  295  cd Team-09-11200-Ethan.git
  296  ls -la
  297  cd ../
  298  ls -la
  299  7z a Team_09_M1_Final_Submission.zip Team-09-11900-Garth.git
  300  cd repo/
  301  7z a Team_09_M1_Final_Submission.zip Team-09-11900-Garth.git
  302  exit
  303  git status
  304  git branch
  305  git checkout dev-11900-Garth
  306  git branch
  307  git checkout Team_09_M1_Final_Submission
  308  git branch
  309  git checkout dev-11900-Garth
  310  git branch
  311  git logk
  312  git branch -rv
  313  git checkout  Team_09_M1_Final_Submission
  314  git branch -rv
  315  git branch -r
  316  git branch -v
  317  git branch -rv
  318  git branch
  319  git status
  320  git branch
  321  git status
  322  git branch
  323  git checkout dev-11900-Garth
  324  git branch
  325  git checkout Tea
  326  git checkout Team_09_M1_Final_Submission
  327  git branch -rv
  328  git checkout dev-11900-Garth
  329  git branch
  330  git branch -rv
  331  git granch
  332  git branch
  333  git branch -rv
  334  git checkout Team_09_M1_Final_Submission
  335  git branch
  336  git branch -r
  337  git branch -rv
  338  git branch -r
  339  git status
  340  cd Team-09-11900-Garth.git/
  341  git status
  342  git branch
  343  git branch -r
  344  git status
  345  git branch
  346  git branch -rv
  347  git checkout dev-11900-Garth
  348  git status
  349  git branch
  350  git log
  351  git log
  352  git checkout 4c4ab8c
  353  git checkout c330
  354  git log
  355  git revert c330 e7bff d31bab ac688
  356  git status
  357  git revert --continue
  358  git status
  359  git revert --continue
  360  git status
  361  git revert --continue
  362  git status
  363  git revert --continue
  364  git status
  365  git branch
  366  git commit
  367  git branch tmp
  368  git checkout master
  369  git merge tmp
  370  git branch
  371  git checkout dev-11900-Garth
  372  git remote
  373  git fetch ethan_remote
  374  git fetch origin
  375  git checkout -b old-state 4c4ab
  376  git branch
  377  git branch -d dev-11900-Garth
  378  git branch -d Team_09_M1_Final_Submission
  379  git branch -d tmp
  380  git branch -D tmp
  381  git branch
  382  git checkout master
  383  git branch -d old-state
  384  git branch
  385  git branch dev-11900-Garth
  386  git checkout dev-11900-Garth
  387  git remote add ethan_remote "$PWD/../Team-09-11200-Ethan.git"
  388  git fetch ethan_remote
  389  git branch
  390  git branch -rv
  391  git clone origin ethan_remote
  392  git fetch
  393  git status
  394  git branch -r
  395  git merge --ff-only ethan_remote/master
  396  git branch -r
  397  git push origin master
  398  git branch
  399  git branch -r
  400  git checkout master
  401  git checkout ethan_remote/dev-11200-Ethan
  402  git checkout origin/dev-11900-Garth
  403  git checkout master
  404  git branch
  405  git checkout dev-11900-Garth
  406  git logk
  407  git log
  408  git branch
  409  ls
  410  cd work/
  411  git branch
  412  git branch -r
  413  git checkout master
  414  git checkout dev-11900-Garth
  415  git branch -rv
  416  git branch -rv
  417  git branch -rv
  418  git checkout ethan_remote/dev-11200-Ethan
  419  git branch
  420  git checkout master
  421  git checkout dev-11200-Ethan
  422  git checkout dev-11900-Garth
  423  git merge dev-11900-Garth
  424  git merge dev-11200-Ethan
  425  hist
  426  history
  427  git status
  428  gitk
  429  git checkout origin/master
  430  git checkout master
  431  git push origin master
  432  git branch dev-11900-Garth ethan_remote/dev-11200-Ethan
  433  git branch dev-11900-Garth-merging ethan_remote/dev-11200-Ethan
  434  git checkout dev-11900-Garth-merging
  435  ls -lah
  436  git branch -rv
  437  git branch
  438  git status
  439  git add .
  440  git commit -m "somehow corrected and returned to a good branch. adding file updates"
  441  git push origin dev-11900-Garth-merging
  442  git log
  443  git checkout dev-11900-Garth
  444  git merge dev-11900-Garth-merging
  445  git mergetool
  446  git status
  447  git commit
  448  git status
  449  exit
  450  git status
  451  git branch -r
  452  git checkout ethan_remote/dev-11200-Ethan
  453  git push
  454  git push origin HEAD:ethan_remote/dev-11200-Ethan
  455  git push origin HEAD:dev-11900-Garth
  456  git pull
  457  git pull ethan_remote
  458  git pull ethan_remote/master
  459  git pull ethan_remote/
  460  git pull ethan_remote/dev-11200-Ethan
  461  git checkout ethan_remote/dev-11200-Ethan
  462  git pull
  463  git push
  464  git branch
  465  git checkout dev-11200-Ethan
  466  git push
  467  git fetch ethan_remote
  468  git status
  469  git commit
  470  git rm Team_09_M1_Final_Submission/Team_09_M1_ReadMe.pdf,orig
  471  gitk
  472  git branch
  473  git checkout dev-11900-Garth-merging
  474  git push
  475  git push ethan_remote HEAD
  476  git status
  477  git push
  478  gitk
  479  git checkout Team_09_M1_Final_Submission
  480  git checkout Team_09_M1_Final_Submission --
  481  git merge dev-11900-Garth-merging
  482  git status
  483  git status
  484  git push --set-upstream origin Team_09_M1_Final_Submission
  485  git status
  486  git checkout dev-11900-Garth
  487  git checkout Team_09_M1_Final_Submission
  488  cd ,,.
  489  cd ../
  490  cd repo/
  491  7z a Team-09-11900-Garth.zip Team-09-11900-Garth.git/
  492  exit
  493  git branch
  494  git branch -d dev-11900-Garth
  495  git branch -D dev-11900-Garth
  496  git branch
  497  git branch -m dev-11900-Garth-merging dev-11900-Garth
  498  git branch
  499  cd ../repo/
  500  7z a Team_09_M1_Final_Submission.zip Team-09-11900-Garth.git
  501  history
```

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

My history from working with Frank:

```bash
  501  git branch -r
  502  git branch -a
  503  gitk --all
  504  git branch
  505  git checkout master
  506  gitk --all
  507  git reset --hard 88eda4
  508  gitk --all
  509  gitk --alll
  510  gitk --all
  511  git branch
  512  git branch -r
  513  git branch -a
  514  git checkout dev-11200-Ethan
  515  git push origin dev-11200-Ethan
  516  git branch -a
  517  git branch -av
  518  git branch -av
  519  git branch -a
  520  history
  521  git branch -a
  522  git branch dev-11900-Garth-merging origin/dev-11900-Garth-merging
  523  git branch -a
  524  git branch -av
  525  git branch -av
  526  git status
  527  git checkout dev-11900-Garth
  528  git status
  529  git branch -a
  530  history
```

in the above, notice the steps

```bash
git branch -a 
```

shows you contents of the local, ethans remote, and my remote. Those should all be equal.

now see how i checkout a branch, and push it to origin? 

```bash
git push origin dev-11200-Ethan
```

Here, I push the branch (explicitly called, not necassary but nice) to origin. Now, origin has that branch.

in the below, i am creating a new local branch named dev-11900-Garth-merging, copied from the existing branch origin/dev-11900-Garth-merging

```bash
git branch dev-11900-Garth-merging origin/dev-11900-Garth-merging
```

This was bc my local didn't have the dev-11900-Garth-merging branch that was in my own remote (i was doing crazy stuff and messed things up).

**you push to remotes, you merge to local**

