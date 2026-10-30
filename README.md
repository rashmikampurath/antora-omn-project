# antora-omn-project

Proof of concept for a second product/website that:

- reuses **only specified** pages from an existing Antora site
- keeps **new-product pages off** the existing published site
- uses a **different stylesheet** on the new website

Isolation comes from **playbooks + components**, not from adding a module under the existing `antora.yml`.

## Pages used in every demo

| Page | Meaning |
| --- | --- |
| Old-only | Existing site only |
| Shared A / Shared B | The specified pages both sites may publish |
| New-only | New product only — must never appear on the existing site |

## How to run

Port 5000 is often taken by macOS AirPlay. These demos use **5010–5015**. Use **http**, not https.

```bash
cd ~/antora-omn-project
nvm use
npm install
bash scripts/init-demo-git.sh   # needed after a fresh clone
npm run build                   # runs scripts/build-all.sh from each demo directory
npm run build:c-broad           # optional: too-broad new site on port 5015
```

Then preview (one command per terminal):

| Demo | Command | URL |
| --- | --- | --- |
| A existing site (leak) | `npm run preview:a` | http://localhost:5010/ |
| B existing site | `npm run preview:b-old` | http://localhost:5011/ |
| B new site | `npm run preview:b-new` | http://localhost:5012/ |
| C existing repo | `npm run preview:c-old` | http://localhost:5013/ |
| C new repo | `npm run preview:c-new` | http://localhost:5014/ |

Optional leak from taking too much of the old repo:

```bash
npx antora demo-c-new-repo/new-site/playbook-too-broad.yml
npx --yes serve demo-c-new-repo/new-site/build/site-too-broad -p 5015
```

## What to screenshot

### Demo A — new module in the existing component (**fails**)

http://localhost:5010/ — green “EXISTING WEBSITE UI”

You will see **New-only page** in the nav. That is the defect: the old playbook publishes the whole component, including the new module.

### Demo B — two components, two playbooks, same git repo (**passes**)

| Page | :5011 old | :5012 new |
| --- | --- | --- |
| Old-only | yes | **no** |
| Shared A/B | yes | yes |
| New-only | **no** | yes |
| Banner | green EXISTING | navy NEW |

### Demo C — second git repo (**passes**, same table as B)

Same page table at :5013 vs :5014.

The new playbook only has `start_paths: [content/shared]` from `existing-docs`. It does not copy those AsciiDoc files.

http://localhost:5015/ (too-broad playbook) shows **Old-only** on the new UI. That is why you cannot point the new site at the whole existing `ROOT`.

## Decision this repo supports

- Reject a new module inside the current component (Demo A).
- Extract reusable pages into a `shared` component; put new-product pages in their own component; give the other website its own playbook and UI (Demo B).
- Put that new playbook in a **new git repo** when the other product owns UI and releases (Demo C). Isolation is the same mechanism as B; the extra repo is ownership, not magic.
