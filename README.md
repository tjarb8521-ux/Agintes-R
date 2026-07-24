<div align="center">
  <img src="https://raw.githubusercontent.com/tjarb8521-ux/Agintes-R/main/assets/agintes-logo.png" alt="Agintes R Logo" width="200" onerror="this.src='https://placehold.co/400x200/222222/00ffa3?text=Agintes+R&font=Montserrat';"/>
  <h1>🚀 Agintes R</h1>
  <p><b>The Ultimate Multi-Agent Swarm Orchestrator for Developers</b></p>
  
  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
  [![Built with Bun](https://img.shields.io/badge/Built_with-Bun-black.svg?logo=bun)](https://bun.sh)
  [![TypeScript](https://img.shields.io/badge/Language-TypeScript-blue.svg)](https://www.typescriptlang.org/)
  [![Platform](https://img.shields.io/badge/Platform-Windows%20%7C%20Linux%20%7C%20macOS-lightgrey.svg)]()
</div>

<br/>

## 🌟 What is Agintes R?

Unlike standard single-model AI tools, **Agintes R** is a **Multi-Agent Swarm Orchestrator**. Built on the robust core of *OpenCode*, it brings together multiple AI models from different providers (e.g., OpenAI, Anthropic, Google, Ollama) to collaborate in a single workspace and complete complex software projects as a **unified team**.

When you give a prompt, Agintes R doesn't just reply—it **plans, delegates, codes, and reviews**:
1. 🧩 **The Planner:** Analyzes your request and breaks it down into sub-tasks.
2. 🧑‍💻 **The Coder:** Uses specialized models (like Anthropic Claude 3.5 Sonnet) to write the code.
3. 🕵️ **The Reviewer:** Uses logic models (like OpenAI GPT-4o) to review for security and performance.
4. 🤖 **The Unified Result:** Delivered directly into your local terminal workspace.

---

## ⚡ Quick Installation (One-Click)

Agintes R features a smart, auto-installing script that configures everything you need in seconds.

### 🪟 Windows (PowerShell)
Copy and paste this into your PowerShell (Run as Administrator for best results):
```powershell
irm https://raw.githubusercontent.com/tjarb8521-ux/Agintes-R/main/win | iex
```

### 🍎 macOS & 🐧 Linux
Copy and paste this into your terminal:
```bash
curl -fsSL https://raw.githubusercontent.com/tjarb8521-ux/Agintes-R/main/install | bash
```

---

## 🚀 Getting Started

Once installed, simply type the following command in any terminal to launch your workspace:
```bash
agintes
```

### Configuring API Keys
Agintes R seamlessly merges keys from different providers to empower your Swarm. Configure them easily:

```bash
# 1. Setup OpenAI (For Planner & Reviewer agents)
agintes config set provider.openai.apiKey "sk-proj-..."

# 2. Setup Anthropic (For the Coder agent)
agintes config set provider.anthropic.apiKey "sk-ant-..."

# 3. Setup Ollama (For local, private models)
agintes config set provider.ollama.baseUrl "http://localhost:11434"
```

---

## 🏗️ Architecture & Stack

- **Core Engine:** Built upon the ultra-fast, robust `effect/ts` and `OpenCode` framework.
- **Runtime:** Powered entirely by [**Bun**](https://bun.sh) for lightning-fast execution and native TypeScript support.
- **Orchestration Layer:** Custom Directed Acyclic Graph (DAG) state machine intercepting standard LLM calls to spawn multi-agent environments.

## 🗑️ Uninstallation
Want to remove Agintes R?
- **Windows:** Run [`uninstall.bat`](https://raw.githubusercontent.com/tjarb8521-ux/Agintes-R/main/uninstall.bat)
- **Linux/macOS:** Remove `~/.agintes-r` and `~/.local/bin/agintes`.

---

<div align="center">
  <i>Developed with ❤️ by the Agintes R Team.</i>
</div>
