# Project: Secure Static Site (v2)

Rebuilding the original static site deploy, but using everything learned since then instead of the original account-key approach.

## Steps
1. Create a fresh storage account for static website hosting.
2. Deploy `index.html` using `--auth-mode login` (RBAC), not account keys — connects directly to the original `deploy.sh` warning from week 1.
3. Grant the right role via `az role assignment create` (real construction practice, not copy-paste).
4. Discuss: does a Private Endpoint make sense here? This is a *public* website — reason through why disabling public network access would actually break the intended use case. Real "when NOT to use a security control" lesson.
5. Tear down cleanly, cost hygiene check.

## Status
**Executed once, 2026-09-18, with heavy step-by-step guidance — NOT yet retained, NOT to be treated as "learned."** When asked to recall the sequence unaided immediately afterward, could only produce "we created a site and took it down." Real run details below happened, but reproducing this independently is the actual bar, not yet met:
- Created `securesite736378` (Standard_LRS, northeurope).
- Enabled static website hosting.
- Granted own account `Storage Blob Data Contributor` via a real `az role assignment create` — assembled from a resource ID looked up with `--query id`, not hand-typed from memory.
- Uploaded `index.html` with `--auth-mode login` — zero account keys used anywhere, fixing the exact warning seen in week 1's original `deploy.sh`.
- Verified the site live in a browser.
- Reasoned through the Private Endpoint question correctly both ways: disabling public access would break the site (it needs to be public), but a Private Endpoint *without* disabling public access is a valid hybrid pattern (internal resources get a private route, public visitors still reach it normally) — the real switch is public-access-disabled, not "has a Private Endpoint" alone.
- Torn down cleanly (`az storage account delete`), verified only the free resources remain in `rg-vm-learning`.
