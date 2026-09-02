public:: true
filters:: {"templates" false}
type::
alias::
tags::

- # The CLAUDE.md file
- **Objectives**
    - Explain what `CLAUDE.md` is and why it's essential for disciplined AI assisted development
    - Write a `CLAUDE.md` that enforces [[TDD]]  / [[ATDD]] workflow, [[Hexagonal Architecture]] and [[Spring Boot]] best practices
    - Identify common risks in AI generated code and encode guardrails against them.
    - Understand `CLAUDE.md` as a living document that evolves with the project.
- ## What is CLAUDE.md
    - A markdown file at the root of your project that [[Claude Code]] **reads every time it starts a session.**
        - > It can be used to tell the AI how to behave, what standards to follow and what workflow to use.
    - ### `CLAUDE.md` Best practices
        - #### Keep it concise
          collapsed:: true
            - 100-150 lines is ideal. Never more than 200.
            - If it grows beyond that, split into `.claude/rules/` files.
        - #### WHAT to do, not WHY
          collapsed:: true
            - Skip explanations. All Claude needs here is clear instructions.
        - #### Instructions, not descriptions
          collapsed:: true
            - "Use records for value objects", not "The project uses records"
            - Imperative voice. Tell Claude what to DO.
        - #### NEVER / ALWAYS rules are the strongest
          collapsed:: true
            - "NEVER use Double for money."
            - Claude treats absolute rules as hard constraints
        - #### Structure with clear ## headers
          collapsed:: true
            - Architecture, Testing, Convention, Workflow -- one section per concern.
        - #### Living Document -- Evolve as you code
          collapsed:: true
            - Every time Claude does something you don't like, add a rule to prevent it
            - Your Claude.md gets smarter over time
- ## The `/init` command #[[Claude Code command]]
    - Can be used to generate the initial `CLAUDE.md` file.
    - It may generate technical details of the project, but it won't contain coding style, architectural rules, testing strategy, or workflow information. This is because this command  follows a descriptive approach (ie. it describes what it finds)
    - You have to enhance it with more rules, some may be obvious or necessary at start. And some may be added based on the undesirable behaviors you observe from Claude Code.
    - ### What you may need to add yourself
        - #### Coding standards
            - Records or POJOs? Naming Conventions?
        - #### Architecture rules
            - Layer boundaries, package structure or where things go.
        - #### Testing Strategy
            - TDD? Which Test types? how to structure tests?
        - #### Workflow
            - Step by Step process for Claude to follow
        - #### Instructions
            - Other general instructions
- ## Fully Formed `CLAUDE.md`
    - [raw.githubusercontent.com/serenity-dojo/cashback-rewards/refs/heads/section-5-solution/CLAUDE.md](https://raw.githubusercontent.com/serenity-dojo/cashback-rewards/refs/heads/section-5-solution/CLAUDE.md)
    - https://github.com/amrullah/spec_driven_development_practice/commit/862d61ffc5d34437c0f8ad2f9ae950ddd61bef5f
- # Scoped Rules
    - As your project grows `CLAUDE.md` gets longer. Scoped rules keep it focused.
    - Disadvantage of large `CLAUDE.md`
        - Claude loads all rules on EVERY prompt. Even if the change was only upon a single file.
            - This will eat up space in context window.
    - Solution
        - Scoped rules files in `.claude/rules/` dir.
        - Each rule file is scoped to a file path pattern. Claude reads only the rules that match the file you're editing.
    - Fully formed rule files
        - [cashback-rewards/.claude/rules at section-5-solution · serenity-dojo/cashback-rewards](https://github.com/serenity-dojo/cashback-rewards/tree/section-5-solution/.claude/rules)
        - [add scoped rules · amrullah/spec_driven_development_practice@d8b7f2c](https://github.com/amrullah/spec_driven_development_practice/commit/d8b7f2c59252867fa92942e3aca847f1136c11b1)
        -