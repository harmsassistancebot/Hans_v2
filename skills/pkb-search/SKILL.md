---
name: pkb-search
description: Search Jan's personal knowledge base (Obsidian vault) using semantic search. Use when the conversation involves Jan's past decisions, projects, concepts, notes, people, or work context — anything that might live in the vault. Triggers on phrases like "what do I know about", "do I have notes on", "what did I decide about", "remind me about my", "look up in my vault", or when answering a question would benefit from grounding in Jan's personal knowledge. Also use proactively when context about a topic would clearly improve the response.
---

# PKB Search

Search Jan's Obsidian vault via the local MCP server (pkb-mcp-server).

## How to Search

Use `exec` to call the MCP server over stdio:

```bash
echo '{"jsonrpc":"2.0","id":1,"method":"tools/call","params":{"name":"search_vault","arguments":{"query":"<QUERY>","limit":5}}}' \
  | node /Users/hans/projects/pkb-mcp-server/dist/index.js 2>/dev/null
```

Parse the JSON response: `result.content[0].text` contains numbered excerpts.

## Optional Filters

Add to `arguments` as needed:

| Filter | Values | When to use |
|---|---|---|
| `domain` | `"work"`, `"self"`, `"family"` | When context is clearly scoped to one domain |
| `category` | `"projects"`, `"concepts"`, `"references"`, `"memos"` | When looking for a specific note type |
| `focus_only` | `true` | When looking for Jan's current priorities |
| `limit` | 1–20 (default 5) | Increase for broad topics, decrease for specific lookups |

## Using Results

- Results are ranked by semantic similarity (score 0–1; >0.4 is strong, 0.25–0.4 is relevant, <0.25 use with caution)
- Each result shows the source file name — cite it when summarising
- If no results found or scores are low, say so rather than guessing

## When the Server is Unavailable

If the exec call fails or returns an error, continue without vault context and note that the PKB search is unavailable. Do not block the response.
