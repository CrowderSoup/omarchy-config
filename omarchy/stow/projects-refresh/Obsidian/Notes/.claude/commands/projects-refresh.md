---
description: Refresh the project notes in Projects/ from a facts file gathered by ~/.local/bin/projects-refresh
argument-hint: <path to facts.md>
allowed-tools: Read, Glob, Grep, Edit(~/Obsidian/Notes/Projects/**)
---

Refresh the project notes in this vault so they reflect the current state of each project. Your only source of truth is the facts file at `$ARGUMENTS`. Read it first. If no path was given, read `~/.local/state/projects-refresh/facts.md`. Don't guess at anything the facts don't support.

Only edit notes under `Projects/`. Never touch daily notes, blog posts, specs (`type: spec`), or anything outside `Projects/`.

## For each project in the facts file

Open its note (the facts heading is the note's path relative to the vault) and update only these parts:

1. **Frontmatter `last_activity`.** Set it to the most recent of the local last-commit date and the GitHub last push, as `"YYYY-MM-DD"`. Leave it alone if neither is known.
2. **Frontmatter `status`.** Change it only between `active` and `dormant`:
   - `active` → `dormant` when there have been no commits for 60+ days
   - `dormant` → `active` when there are commits in the last 14 days
   - Never change `maintained`, `idea`, `parked`, or any other value.
3. **The `## Current state …` section.** Rename its heading to `## Current state (YYYY-MM-DD)` with today's date and rewrite its body. Keep the existing style: short bullets in plain prose that say what changed and why it matters, not raw git output. Cover:
   - total commits and the date range of recent activity
   - what the last ~2 weeks of commits accomplished, grouped into themes rather than listed one by one (if nothing happened, say "No commits since <date>.")
   - working-tree problems: a checked-out branch whose PR is already merged, uncommitted changes, unpushed commits, no remote, or not a git repo
   - open PRs and issues, briefly (numbers and titles)
   - prunable merged local branches, if there are more than 3

   Keep any ⚠️ warnings that are still true and drop the ones the facts show are resolved.

Leave every other section exactly as it is: **What it is**, **Stack**, **Where it runs**, **Next up**, embedded `base` blocks, and **Related**. The one exception: if the facts show that a **Next up** item clearly shipped, strike it through (`~~item~~`) and add ` (done YYYY-MM-DD)`.

Notes with no `path` and no `repo` (ideas, parked research) get no facts. Skip them.

## Then update `Projects/Projects.md`

- Rewrite the `## Housekeeping (as of …)` section as a checklist built from the current facts: missing remotes or no git, merged branches still checked out, uncommitted work, stale branches, dependency PRs, and new folders. Update the date in the heading.
- If the facts list folders under `~/Projects` with no project note, add a line for each to the checklist: `- [ ] New folder \`<path>\`: create a project note`. Don't create the notes yourself.
- Update the parenthetical status words in **By area** only if a note's status changed.

## Finish

Print a short summary of at most 8 lines: which notes changed and the most important thing in each, plus any new folders found. This summary is shown as a desktop notification and kept in the log.
