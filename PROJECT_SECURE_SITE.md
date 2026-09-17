# Project: Secure Static Site (v2)

Rebuilding the original static site deploy, but using everything learned since then instead of the original account-key approach.

## Steps
1. Create a fresh storage account for static website hosting.
2. Deploy `index.html` using `--auth-mode login` (RBAC), not account keys — connects directly to the original `deploy.sh` warning from week 1.
3. Grant the right role via `az role assignment create` (real construction practice, not copy-paste).
4. Discuss: does a Private Endpoint make sense here? This is a *public* website — reason through why disabling public network access would actually break the intended use case. Real "when NOT to use a security control" lesson.
5. Tear down cleanly, cost hygiene check.

## Status
Not started — planned 2026-09-17, execution begins next session.
