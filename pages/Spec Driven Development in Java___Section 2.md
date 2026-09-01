public:: true
filters:: {"templates" false}
type::
alias::
tags::

- # [[Claude Code]] Basics
- ## Introduction
    - ### Terminal based AI Assistant
        - Lives in the terminal, integrated directly into the development workflow
    - ### Full Project Access
        - Reads and Writes your project commands, runs shell commands, executes tests, all from natural language instructions
    - ### Context Aware
        - Understands full project structure, not just pasted code snippets.
- ## [[Tokens]] #[[Claude Code]]
    - "Calculate Cashback"
        - 3 tokens
    - A typical java `class`
        - 200-500 tokens
    - Full project context
        - 10,000 - 50,000+ tokens
    - ## [[Context Window]]
        - ### Typical context window usage
          collapsed:: true
            - |Component|Typical Context window usage|
              |--|--|
              |CLAUDE.md|5-10 %|
              |Source files|20-40 %|
              |Conversation|30-50 %|
              |Response|10-20 %|
        - #+BEGIN_QUOTE
          As you fill up context window, eventually there won't be enough space for Claude to do both, remember the conversations and create new responses to your questions
          #+END_QUOTE
            - This is why `/compact` exists, to compact the conversation. #[[Claude Code command]]
            - Also `/clear` to wipe the context window clean. #[[Claude Code command]]
            - `/context` will display the context window usage. Example output #[[Claude Code command]]
              collapsed:: true
                - ```
                    ⎿  Context Usage
                       ⛁ ⛁ ⛁ ⛀ ⛀ ⛶ ⛶ ⛶ ⛶ ⛶   Sonnet 5
                       ⛶ ⛶ ⛶ ⛶ ⛶ ⛶ ⛶ ⛶ ⛶ ⛶   claude-sonnet-5
                       ⛶ ⛶ ⛶ ⛶ ⛶ ⛶ ⛶ ⛶ ⛶ ⛶   32.2k/967k tokens (3%)
                       ⛶ ⛶ ⛶ ⛶ ⛶ ⛶ ⛶ ⛶ ⛶ ⛶
                       ⛶ ⛶ ⛶ ⛶ ⛶ ⛶ ⛶ ⛶ ⛶ ⛶   Estimated usage by category
                       ⛶ ⛶ ⛶ ⛶ ⛶ ⛶ ⛶ ⛶ ⛶ ⛶   ⛁ System prompt: 9.4k tokens (1.0%)
                       ⛶ ⛶ ⛶ ⛶ ⛶ ⛶ ⛶ ⛶ ⛶ ⛶   ⛁ System tools: 20.4k tokens (2.1%)
                       ⛶ ⛶ ⛶ ⛶ ⛶ ⛶ ⛶ ⛶ ⛶ ⛶   ⛁ Skills: 2.5k tokens (0.3%)
                       ⛶ ⛶ ⛶ ⛶ ⛶ ⛶ ⛶ ⛶ ⛶ ⛶   ⛁ Messages: 8 tokens (0.0%)
                       ⛶ ⛶ ⛶ ⛶ ⛶ ⛶ ⛶ ⛝ ⛝ ⛝   ⛶ Free space: 901.8k (93.3%)
                                             ⛝ Autocompact buffer: 33k tokens (3.4%)
                  
                       Auto-compact window: 967k tokens
                  
                       MCP tools · /mcp (loaded on-demand)
                       └ 2 tools · 0 tokens
                  
                       Skills · /skills
                       └ 16 skills · 2.5k tokens
                  ```
- ## Choosing the right model
    - ### [[Sonnet]]
        - Default model, handles 95% of tasks
        - Fast, capable, cost effective
    - ### [[Opus]]
        - when you need deeper reasoning, deeper planning, complex business logic, multi-step calculations, subtle edge cases, requirements analysis
        - Slower, costs more
    - ### [[Haiku]]
        - Simple boilerplate, renaming variables, tasks that require little reasoning
        - Fast and cheap
    - Switching models:
        - `/model` helps switch the model. Example Output: #[[Claude Code command]]
          collapsed:: true
            - ```
               Select model
                 Switch between Claude models. Your pick becomes the default for new sessions. For other/previous model names, specify with --model.
              
                   1. Default (recommended)  Sonnet 5 · Efficient for routine tasks
                 ❯ 2. Sonnet ✔               Sonnet 5 · Efficient for routine tasks
                   3. Fable                  Fable 5 · Most capable for your hardest and longest-running tasks · Requires usage credits
                   4. Opus                   Opus 5 · Best for everyday, complex tasks · ~2× usage vs Sonnet
                   5. Haiku                  Haiku 4.5 · Fastest for quick answers
              ```
- ## How hard should model try (Model effort)
    - Effort is the depth that the LLM goes into when it thinks about the request. **It influences LLM request cost**
    - `/effort` Example output: #[[Claude Code command]]
      collapsed:: true
        - ```
          ▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔
             Effort
          
                                          Faster                             Smarter
                                          ────────────────────▲─────────────────────
                                          low     medium     high     xhigh      max
          ```
    - For example, after `/effort low` a person gives a prompt like this:
      ```
      Explain the class CashbackService
      ```
      The output will be brief and arguably concise. This is in contrast with `/effort high` where the response may be very very detailed and almost verbose.
- ## Understanding costs - [[Claude Code]] Plans
    - [Plans & Pricing | Claude by Anthropic](https://claude.com/pricing) Check this for updated information
    - |Plan|Best For|
      |--|--|
      |Free|Hobby / trying out claude for the first time|
      |Pro|Personal AI use|
      |Max 5x|Daily Professional use|
      |Max 20x|Heavy Professional use|
      |API Console|Per token pricing. Teams, CI/CD|
    - ### What drives cost up?
        - Large Project context
          collapsed:: true
            - Every code file Claude code reads, counts
        - Long conversations
        - High effort / extended thinking
          collapsed:: true
            - > Don't leave it on `/effort high` for simple tasks
            -
- ## Interactive shortcuts
    - Common Shortcuts
        - |Short cut|Purpose|
          |--|--|
          |`@`|File mention. Autocomplete File paths in your prompt|
          |!|Bash mode. Run shell commands directly. It won't consume tokens|
          |ESC ESC|Rewind. Undo Claude's changes or revert to a previous state in context window -- Safety net, kinda like `git reset --hard` but for conversation history with claude|
          |/btw|Side Question. Quick question without adding to history. Useful because every side question you ask takes space in context window and makes future requests costlier|
- ## Mitigating AI's unpredictability
    - |Problem|Mitigated by|Why it works|
      |--|--|--|
      |AI lies|Tests|Verify every generated code, if the code is wrong, the test fails|
      |AI over-extends|Workflow|Small steps, forced validation. One TDD cycle at a time. Review before accepting|
      |Unknown unknowns|CLAUDE.md + Specs|Inject domain knowledge Claude is blissfully ignorant of|
    -