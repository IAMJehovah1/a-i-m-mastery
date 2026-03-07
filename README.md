# A-I-M Mastery — GitHub Sandbox

> **AI · Implementation · Mastery** — a sandboxed environment for workflow
> automation, multi-agent system design, and Cloudflare Workers development.

[![Sandbox CI](https://github.com/IAMJehovah1/a-i-m-mastery/actions/workflows/sandbox.yml/badge.svg)](https://github.com/IAMJehovah1/a-i-m-mastery/actions/workflows/sandbox.yml)
[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://github.com/codespaces/new?repo=IAMJehovah1/a-i-m-mastery)

---

## 🚀 Quickstart

The fastest way to explore this repository is via **GitHub Codespaces** — a
fully configured sandbox spins up in seconds:

1. Click **Open in GitHub Codespaces** above (or the badge).
2. Wait ~60 s for the container to build and run `setup.sh`.
3. In the integrated terminal run:
   ```sh
   aim-serve   # serves the sandbox dashboard at http://localhost:3000
   ```
4. The gorgeous sandbox dashboard (`sandbox/index.html`) opens automatically.

---

## 📦 What's in the Sandbox

| Layer | Tool | Purpose |
|---|---|---|
| Runtime | Node.js LTS + Python 3.12 | Script execution & tooling |
| Deploy | Cloudflare Wrangler | `wrangler dev` on port 8787 |
| Format | Prettier | `aim-fmt` — formats all files |
| Lint | markdownlint-cli2 | `aim-lint` — lints Markdown |
| Editor | VS Code (One Dark Pro + Copilot) | Beautiful, AI-enhanced editing |
| Dashboard | `sandbox/index.html` | Gorgeous visual overview |
| CI | `.github/workflows/sandbox.yml` | Auto-validates on every push |

### Shell aliases (available in every terminal)

```sh
aim-serve    # http-server sandbox/ -p 3000  (opens in browser)
aim-fmt      # Prettier over all JS/TS/JSON/MD/HTML/CSS
aim-lint     # markdownlint-cli2 over all *.md
aim-status   # git status --short with emoji prefix
```

---

## 🏗 Multi-Agent Hierarchy of Needs

The core architecture (`WorkFlowMastery.txt`) implements a 5-layer
multi-agent pipeline targeting Cloudflare Workers:

```
1. Safety       — validate + bound task input
2. Coordination — route to planner / researcher / executor / reviewer
3. Capability   — run role tools with timeouts & retries
4. Memory       — persist state in Cloudflare KV (MULTI_AGENT_STATE)
5. Outcome      — score, resolve conflicts, return final response
```

See `sandbox/index.html` for a visual walkthrough and the full reference
implementation with syntax highlighting.

---

## 🗂 Repository Structure

```
.devcontainer/
  devcontainer.json   — Codespaces config (Node, Python, extensions, ports)
  setup.sh            — First-run setup (installs tools, configures Zsh)
.github/
  workflows/
    sandbox.yml       — CI: validates HTML, JSON, and Markdown on push
sandbox/
  index.html          — Gorgeous visual sandbox dashboard
WorkFlowMastery.txt   — Multi-agent design + Cloudflare Workers reference code
Siri Skill.txt        — Siri automation notes
SpecificAppOrderFlow.txt — App binding configuration guide
README.md             — This file
```

---

## ☁️ Deploying to Cloudflare Workers

```sh
# Inside the Codespace
wrangler login
wrangler deploy multi-agent-worker.js
```

Add a KV namespace binding in `wrangler.toml`:

```toml
[[kv_namespaces]]
binding = "MULTI_AGENT_STATE"
id      = "<your-kv-namespace-id>"
```

---

## 📄 License

This repository is personal knowledge base content owned by
[@IAMJehovah1](https://github.com/IAMJehovah1).
