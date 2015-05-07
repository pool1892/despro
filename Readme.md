# Deskriptive Programmierung

bitte nicht auf master arbeiten. Vorgeschlagener workflow:


git checkout master
git pull


git checkout -b &lt;name-exersice&gt;

... happy coding ...

git add &lt;yourfile|.&gt;
git commit -m 'fancy haskell stuff'


git checkout master
git pull
git merge &lt;name-exersice&gt; --no-ff (the "no-fast-forward" makes reversing merges a lot easier")

git push

to publish working branch
git push --set-upstream origin &lt;name-exersice&gt;

to create local branch from remote branch
git checkout -b &lt;name-exersice&gt; origin/&lt;name-exersice&gt;


git branch -> list branches ( -r for remote branches, -a for both)
git branch -d &lt;name-exersice&gt; -> remove branch
(use -D instead of -d only if you're really sure. this is a failsafe to not kill unmerged code, use it.)


git log -> see history
git diff &lt;commit-hash|branch&gt; see changes since ...
