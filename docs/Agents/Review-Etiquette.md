# Review Etiquette

How to disagree well, how to keep reviews focused, and how to keep the loop converging.

## For the Reviewer

### Stay in scope

The PR delivers a specific issue. Suggestions that go beyond that issue are **new issues**, not blocking review comments. File the follow-up and link it from the comment.

### One concern per comment

Each thread is a scoped conversation. Bundling multiple unrelated nits into one comment makes it hard to resolve threads cleanly.

### Be clear about severity

Use explicit prefixes so the author knows what is blocking:

- `Blocking:` — must be addressed before merge.
- `Question:` — needs clarification; may or may not lead to a change.
- `Suggestion:` — improvement worth considering; the author can take or leave it with reasoning.
- `Nit:` — small style or preference issue; the author can dismiss freely.

### Reason from evidence

Cite the docs, the linter rule, the security advisory, the linked issue's Section 2. "It feels off" is rarely actionable. "This contradicts the decision in #N's Section 2" is.

### Don't review your own PR publicly

Self-review is fine and encouraged — but it goes to the terminal as a pre-flight report, not as GitHub comments on your own PR. (And by GitHub rules, you cannot `Request changes` on your own PR — submit a `Comment` review and use a blocking label if needed.)

### Distinguish bots from humans

Bot comments (linters, security scanners) tend to be factual. Human comments may carry context the bot can't infer — read them carefully and don't bulk-dismiss.

## For the Responder (the author)

### Reply before resolving

Every resolved thread has a reply explaining the action — what was fixed, why dismissed, which issue picked it up. Bulk-resolving without replies looks like avoidance.

### Forward progress over discussion

A valid concern that needs deep design discussion becomes a follow-up issue and a resolved thread, not an open thread that blocks the PR. Open threads are blockers — minimize them.

### Don't expand the PR

The Reviewer suggested a thing that's out of scope. It's still out of scope. Reply, file the issue, link, resolve. Don't merge the suggestion in just to be polite.

### Propagate fixes

If a reviewer found a problem in one place and the same pattern exists elsewhere, fix it everywhere consistently. A partial fix that leaves identical problems in similar files is incomplete.

### Test coverage gaps

When a reviewer finds a real bug existing tests didn't catch, the fix is incomplete without a new or corrected test that closes the gap. Fixing only the source means the next regression is just as silent as this one.

### Don't bulk-dismiss bot feedback

Linter and security findings have a reason. Address them or suppress them with explicit justification — don't just silence them.

## For both sides

### Tone

- Impersonal where possible. "This change does X" beats "You did X".
- No sarcasm in writing — it doesn't travel well across time zones, languages, or human-agent boundaries.
- Assume good intent. Both reviewer and author are trying to ship the right thing.

### Disagreements

When the Reviewer and Responder genuinely disagree:

1. Re-state the disagreement plainly in the thread.
2. Reference the relevant doc, decision, or principle.
3. If still stuck, escalate to a human maintainer or file a discussion issue. Don't loop on the same thread.

### Converge, don't diverge

Every change in a review round should move the PR closer to merge. Avoid introducing new code that itself needs another review round. If a fix introduces a new design choice, surface it in the response and let the Reviewer accept it before piling further changes on top.

### Stale comments

If the code referenced by a comment has been modified since, mention it in the reply. Don't silently let stale comments accumulate as open threads.

## What this is not

This is not a process gate. It is **shared etiquette** so the loop is fast, professional, and respectful — across human reviewers, human authors, and the agents working alongside them.
