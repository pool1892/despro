# Deskriptive Programmierung

bitte nicht auf master arbeiten. Vorgeschlagener workflow:


git checkout master
git pull


git checkout -b <name-exersice>

... happy coding ...

git add <yourfile|.>
git commit -m 'fancy haskell stuff'


git checkout master
git pull
git merge <name-exersice> --no-ff (the "no-fast-forward" makes reversing merges a lot easier")

git push

to publish working branch
git push --set-upstream origin <name-exersice>

to create local branch from remote branch
git checkout -b <name-exersice> origin/<name-exersice>


git branch -> list branches ( -r for remote branches, -a for both)
git branch -d <name-exersice> -> remove branch 
(use -D instead of -d only if you're really sure. this is a failsafe to not kill unmerged code, use it.)


git log -> see history
git diff <commit-hash|branch> see changes since ...
