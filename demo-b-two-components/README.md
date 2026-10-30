# Demo B — two components, two playbooks, same git repo (passes)

Old playbook includes `existing` + `shared`.
New playbook includes `shared` + `new-product`.

**Expected:** new-only never on the old site; old-only never on the new site; shared on both; CSS differs.
