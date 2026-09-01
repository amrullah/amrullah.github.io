public:: true
filters:: {"templates" false}
type::
alias::
tags::

- # Three important pillars
    - **Discovery**
      collapsed:: true
        - Explore the requirements with AI before writing code.
            - Also turn the requirements to specification.
    - **[[ATDD]]**
      collapsed:: true
        - Turn requirements into acceptance tests / criteria
    - **[[TDD]]**
      collapsed:: true
        - Drive implementation in small, verifiable steps.
- # Problem with unguided AI code generation
    - Treating AI tools like a genie and providing vague instruction like ^^Create a cashback reward service with REST endpoints, entities and tests^^ may produce an apparently working code that passes the tests, but may have missing test cases, mistakes like using Float or Double to store money etc. Which may blow up in production
- # The Spec Driven Approach
    - ## 5 step workflow
        - #+BEGIN_QUOTE
          Repeated for every Feature
          #+END_QUOTE
        - ### Discover
          collapsed:: true
            - Before writing any code, we use AI to Explore our Requirements.
                - What are the edge cases?
                - What happens if the transaction is refunded.
                - Using a common [[BDD]] technique called [[Example Mapping]]
                    - Examples and counter-examples
                      id:: 6a95aa18-54ac-4e1e-9aee-e524fb8a97ad
        - ### Review
          collapsed:: true
            - Verify the spec is complete
                - Are the edge-cases covered, etc.
                - Crucial step which prevents bugs from being shipped to production
        - ### Acceptance Tests
          collapsed:: true
            - Write Failing Acceptance Test
                - ((6a95aa18-54ac-4e1e-9aee-e524fb8a97ad)) into acceptance test
        - ### [[TDD]]
          collapsed:: true
            - Red-Green-Refactor with AI
        - ### Review
          collapsed:: true
            - Check Coverage and Quality
                - AI smells, dead-code, useless tests etc.
            -
    - ## Why this approach works well with AI
        - ### Specifications constrain
            - AI works from concrete rules and examples, not vague intent.
        - ### Tests verify continuously
            - Every change is checked immediately.
        - ### Reviews catch drift
            - Architecture violations, over-engineering, superficial tests - caught before they accumulate.
    -
    -
    -