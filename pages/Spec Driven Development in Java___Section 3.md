public:: true
filters:: {"templates" false}
type::
alias::
tags::

- # AI driven Requirements Discovery
- [[Claude Code]] can come in handy
- ## The problem with vague requirements
    - Typical [[User Story]] looks like:
      
      #+BEGIN_QUOTE
      As a customer I want to earn cashback on my purchases.
      #+END_QUOTE
        - Edge cases that require discovery:
            - What percentage? does it vary by product category?
            - Is there a cap? Per month, per transaction or per year?
            - When is cashback awarded? Immediately or after a holding period?
            - How is it rounded? to the nearest cent? in whose favor?
    - When coding manually, vague requirements lead to questions back to Product owner. But, When using AI, vague requirements lead to ^^progress in wrong direction^^.
- ## Collaborative Discovery
    - Some base tenets:
        - ### Requirements are discovered, not delivered.
            - Understanding emerges through conversation, not documentation
        - ### Ambiguity is a feature, not a bug.
            - Doesn't mean it's a bad [[user story]], it just means business hasn't decided on them yet. As an Engineer you have to surface these through questions.
        - ### Concrete Examples beat abstract rules.
            - "$100 purchase at 1% = $1 cashback" is much better than something vague like "cashback percentage applies"
        - ### Discovery before Development.
            - Work through examples, edge cases and variations to make sure you know what exactly you are building, and avoid frustrating rework.
- ## [[Three Amigos]]
    - ### [[Product Owner]]
        - > What do we need?
        - Defines the business intent and acceptance criteria.
    - ### Developer
        - > How will we build it?
        - Surfaces Technical constraints and implementation options
    - ### Tester
        - > What could go wrong?
        - Finds edge cases, boundary conditions and mismatches
- ## [[Example Mapping]]
    - When faced with an ambiguous or vague or summarized requirement or acceptance criterion from [[Product Owner]] , asking a simple question:
      > Can you give me an example of that?
        - That leads you down the track of hunting for edge-cases and variations and exposing assumptions you may have made
    - ![Example Mapping](..assets/example_mapping_export.png)
      collapsed:: true
        - {{renderer :drawio, 1788279867056.svg}}
    - #+BEGIN_TIP
      Name Example cards like this: "The one with..." or "The one where..."
      #+END_TIP
        - also known as "Friends episode notation"
        - Examples
          collapsed:: true
            - The one where a regular customer buys 100$ of groceries...
            - The one where premium member buys electronics...
            - The one where customer reaches their monthly cashback cap
        - Benefits
          collapsed:: true
            - Readable in conversation
            - Self documenting
            - Maps naturally to test names
            - AI understands intent
- ## The spec format (from cards to text)
    - ```markdown
      ## Feature: Cashback Rewards calculation
      
      > As a customer,
      > I want to earn cashback on my purchases,
      > So that I am rewarded for my loyalty
      
      ### Rule: Standard cashback rate is 1%
      - The one where a regular customer spends $100, then $1.00 cashback (Example)
      - The one where a customer buys $0.99, then $0.01 cashback
      
      ### Rule: Premium members earn 2% cashback
      - The one where a premium member spends $100, then $2.00 cashback
      
      ### Rule: Monthly cashback is capped at $50
      - The one where earned cashback reaches $50, then no cashback
      - The one where next purchase would exceed the cap, then capped at $50
      
      
      ### Question: Does the cap reset on calendar month or on anniversary?
      ```
    - Works best all [[Three Amigos]] collaboratively create this. But there is a way for a solo developer to prepare this with help of AI.
- ## Your first Discovery prompt
    - Naive Template:
      collapsed:: true
        - ```markdown
          You are a domain expert in {{industry name: like customer loyalty}}
          Based on User Story below, propose rules, examples, counter-examples and questions 
          using the Example Mapping approach.
          
          ###
          As a customer I want to earn cashback on purchases
          ###
          
          Your task is not to write Gherkin or Given/When/Then steps. Instead:
          1. Identify rules; each starts with "Should..." or "Must...".
          2. Give ≥2 examples per rule using "The one where..." notation.
          3. Give ≥1 counter-example per rule
          (a valid edge case, not a bug).
          4. List any open questions per rule.
          
          Output format:
          - Rule: ...
              - Example: The one where...
              - Counter-example: The one where...
              - Questions: ...
          
          Use plain business language. No Tech or UI/UX language.
          
          Save the results to doc/specs/<feature>.md
          (kebab-case the feature name from the story)
          
          ```
    - Better Template (Seed the prompt with what you already know, nudge it to use tables for displaying examples):
      collapsed:: true
        - ```markdown
          You are a domain expert in {{industry name: like customer loyalty}}
          Based on User Story below, propose rules, examples, counter-examples and questions 
          using the Example Mapping approach.
          
          ###
          {{User Story: like, As a customer I want to earn cashback on purchases }}
          ###
          
          ## Draft Rules (what we already know)
          - Standard Cashback is 1% of qualifying spend
          - Premium members earn 2%
          - Monthly cashback is capped at $50 per member
          (and so on)
          
          ## Known constraints
          - All amounts are in USD, round half-up to cent
          - "Month" is calendar month, in User timezone
          
          Your task is not to write Gherkin or Given/When/Then steps. Instead:
          1. Identify rules; each starts with "Should..." or "Must...".
          2. Give ≥2 examples per rule using "The one where..." notation.
          When a rule's inputs vary independently, give examples as a markdown table
          (one column per input, one column per output)
          3. Give ≥1 counter-example per rule
          (a valid edge case, not a bug).
          4. List any open questions per rule.
          
          Output format:
          - Rule: ...
              - Example: The one where...
              - Counter-example: The one where...
              - Questions: ...
          
          Quality checks:
           - Use plain business language. No UI steps.
           - Each example must cover a distinct business behaviour,
              rule boundary, or decision outcome.
           - Don't include examples that differ only in amount, wording,
              merchant, or channel if the outcome is the same.
           - Cover the normal case first, then boundaries only.
           - When a rule is a table, don't also list bullets for the same
              scenarios unless they add a new distinction.
           - Prefer one compact table + one counter-example over dupes.
           - Before finalising, merge duplicate examples.
          
          Save the results to doc/specs/<feature>.md
          (kebab-case the feature name from the story)
          
          ```
    - Back and forth starts. Answer the open questions in a rule and prompt something like:
      collapsed:: true
        - ```
          Update Rule: ... Based on these anwers:
          ...(paste the questions and anwers)
          ```
    - Since you are going to use the same prompt template for each user story, it's better to create a `slash command` out of it
        - It's done by adding a markdown file `<command name>.md` in `.claude/commands` directory.
        - Almost fully formed `/discover` command:
          collapsed:: true
            - ```markdown
              ---
              allowed-tools: Write
              description: Discover feature rules from a user story using Example Mapping
              argument-hint: "<user story in quotes>"
              ---
              You are a domain expert in customer loyalty.
              Propose rules, examples, counter-examples and questions
              using the Example Mapping approach.
              Treat the draft rules below as a starting point –
              refine, split, or challenge them as needed.
              
              ###
              $ARGUMENTS
              ###
              
              Your task is NOT to write Gherkin or Given/When/Then steps. Instead:
              1. Identify rules; each must start with "Should..." or "Must...".
              2. Give one or more examples per rule. Use "The one where..."
                 notation by default. When a rule's inputs vary independently,
                 use a markdown table instead (one column per input, one column
                 per output).
              3. Give at least one counter-example per rule where a meaningful
                 valid edge case exists. A counter-example should be a valid
                 business boundary or exclusion, not a bug. A boundary row in a
                 table satisfies the counter-example requirement for that rule —
                 don't restate it as a separate bullet.
              4. List any open questions per rule.
              
              QUALITY CHECKS:
              - Use plain business language. No UI steps.
              - Each example must cover a distinct business behaviour, rule
                boundary, or decision outcome.
              - Do not include examples that differ only in amount, wording,
                merchant name, or channel if the business outcome is the same.
              - Cover the normal case first, then only add examples for
                boundaries or genuinely different business outcomes.
              - When a rule is expressed as a table, don't also list the same
                scenarios as bullet examples — only add a bullet if it
                introduces a distinct rule, boundary, or business outcome the
                table doesn't capture.
              - Prefer one compact table plus one counter-example over several
                repetitive examples.
              - Before finalising, remove or merge duplicate examples so the
                final set is minimal but complete.
              
              OUTPUT FORMAT:
              - Rule: ...
                  - Example: The one where...
                  - Counter-example: The one where...
                  - Questions: ...
              
              Save the result to doc/specs/<feature>.md
              ```
            - Usage in claude code terminal
                - ```
                  /discover "As a customer, I want to earn cashback on my purchases
                  so that I am rewarded for my loyalty.
                  
                  Draft rules:
                  - Standard cashback is 1% of qualifying spend
                  - Premium members earn 2%
                  - Monthly cashback is capped at $50 per member
                  - Refunds must reverse any cashback earned
                  
                  Known constraints:
                  - All amounts in USD, round half-up to cent
                  - 'Month' = calendar month, customer timezone"
                  ```
        - Another useful thing to do. After Claude Code has generated the Spec file, Ask Claude to interactively ask the open questions from the spec like this:
          collapsed:: true
            - ```markdown
              Prompt me to answer each question in the spec. 
              Propose possible options and allow me to provide my own if required.
              Based on my anwers, you should do one of the below 3 actions:
              1. update the corresponding rule.
              2. Add or update examples
              3. Create a new rule with examples
              ```
        - Fully formed `/discover` command, with the above interactive question resolutions, built in
          collapsed:: true
            - ```markdown
              
              ---
              allowed-tools: Write
              description: Discover feature rules from a user story using Example Mapping
              argument-hint: "<user story in quotes>"
              ---
              You are a domain expert in customer loyalty.
              Propose rules, examples, counter-examples and questions
              using the Example Mapping approach.
              Treat the draft rules below as a starting point –
              refine, split, or challenge them as needed.
              
              ###
              $ARGUMENTS
              ###
              
              Your task is NOT to write Gherkin or Given/When/Then steps. Instead:
              1. Identify rules; each must start with "Should..." or "Must...".
              2. Give one or more examples per rule. Use "The one where..."
                 notation by default. When a rule's inputs vary independently,
                 use a markdown table instead (one column per input, one column
                 per output).
              3. Give at least one counter-example per rule where a meaningful
                 valid edge case exists. A counter-example should be a valid
                 business boundary or exclusion, not a bug. A boundary row in a
                 table satisfies the counter-example requirement for that rule —
                 don't restate it as a separate bullet.
              4. List any open questions per rule.
              
              QUALITY CHECKS:
              - Use plain business language. No UI steps.
              - Each example must cover a distinct business behaviour, rule
                boundary, or decision outcome.
              - Do not include examples that differ only in amount, wording,
                merchant name, or channel if the business outcome is the same.
              - Cover the normal case first, then only add examples for
                boundaries or genuinely different business outcomes.
              - When a rule is expressed as a table, don't also list the same
                scenarios as bullet examples — only add a bullet if it
                introduces a distinct rule, boundary, or business outcome the
                table doesn't capture.
              - Prefer one compact table plus one counter-example over several
                repetitive examples.
              - Before finalising, remove or merge duplicate examples so the
                final set is minimal but complete.
              
              OUTPUT FORMAT:
              - Rule: ...
                  - Example: The one where...
                  - Counter-example: The one where...
                  - Questions: ...
              
              After generating the rules, examples and questions:
              
              5. Present the open questions to the user, one at a time.
                 For each question, provide an interactive dropdown list of 3-4 sensible options, plus a final option: Something else
              6. When the user has answered the questions, fold the answers into rules and examples. Remove the questions section.
                 No unresolved questions in the final spec.
              7. Present the complete spec for review. Do not save until the user approves.
              
                
              Save the result to doc/specs/<feature>.md
              
              ```
        - Next spec generated using
          collapsed:: true
            - collapsed:: true
              ```markdown
              /discover "Feature: View Account History
              As a customer I want to view my cashback transaction history so that I can know where I earn the most cashbacks"
              ```
                - It generated this spec file: [spec_driven_development_practice/doc/specs/view-account-history.md at main · amrullah/spec_driven_development_practice](https://github.com/amrullah/spec_driven_development_practice/blob/main/doc/specs/view-account-history.md)
                -
- ## AI powered discovery, in a nutshell
    - ### You provide domain context
        - A role line and the user story tell [[Claude Code]] the business you are in and what the user wants
    - ### Claude proposes rules and examples
        - Using domain knowledge + general software patterns to surface candidates
    - ### You validate challenge and refine
        - Accept, reject or modify examples, answer questions. You are the authority, not Claude Code
    - ### Output becomes your specification
        - The refined spec drives Acceptance test and implementation.
- ## The complete workflow
    - ```
      /discover -> review spec -> /accept -> /tdd -> review code
      ```
- ## Code
    - Check on Github [Spring Boot project initialize | discover slash command created in Cl… · amrullah/spec_driven_development_practice@6b7f181](https://github.com/amrullah/spec_driven_development_practice/commit/6b7f1814d79a1e95b02016f6d9d4e3056d255cdd)
    -