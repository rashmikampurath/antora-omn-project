# Demo C — new git repo reuses specified pages (passes)

`existing-docs` is one git repo (old playbook + existing + shared).
`new-site` is a second git repo (new playbook + new-product pages + new UI).

The new playbook uses `url: ../existing-docs` and `start_paths: [content/shared]` only.

`playbook-too-broad.yml` is the anti-pattern: it also includes `content/existing`, so old-only pages appear on the new site.
