public:: true

- # Implementing a full feature with the workflow
- ## User story
    - ```
      Feature: Basic Cashback Calculation
      
      As a Customer I want to earn cashback on my purchases, so that I am rewarded for shopping with partner merchants
      
      Acceptance Criteria:
      - Cashback is calculated as a percentage of the purchase amount
      - Each merchant has a configured cashback rate
      - Cashback is credited to the customer's rewards balance
      ```
    - Feed it to `/discover` command
- ## Acceptance Test command
    - [/acceptance command to generate failing acceptance tests · amrullah/spec_driven_development_practice@557fa19](https://github.com/amrullah/spec_driven_development_practice/commit/557fa1983c94cd3a75045630308d02695d7e8429)
- ## Generating Acceptance tests
    - ```
      /acceptance Must calculate cashback as purchase amount × the merchant's rate, rounded down to the cent
        @doc/specs/basic-cashback-calculation.md
      ```
    - [Acceptance Test generated for basic-cashback-calculation.md Rule 1 · amrullah/spec_driven_development_practice@10f75d1](https://github.com/amrullah/spec_driven_development_practice/commit/10f75d149f828f3462e97d0215158766b57559fb)
- ## Generating Unit Tests
- ### Classic TDD cycle
    - <div style="display: flex;"> 
      <div style="border: 1px solid black; padding: 5px;"> <span style="font-weight: bold; color: red;">Red</span> <br /> Write one failing Unit Test</div> 
      <div style="padding: 20px; font-size: 25px;"> → </div> 
      <div style="border: 1px solid black; padding: 5px;"> <span style="font-weight: bold; color: green;">Green</span><br /> Minimum Code to make it pass</div>
      <div style="padding: 20px; font-size: 25px;"> → </div> 
      <div style="border: 1px solid black; padding: 5px;"> <span style="font-weight: bold; color: blue;">Refactor</span><br /> Clean up. Run all Tests</div>
      </div>
- ### TDD with AI
    - <div style="display: flex;"> 
      <div style="border: 1px solid black; padding: 5px;"> <span style="font-weight: bold; color: red;">Red</span> <br /> Write one failing unit test</div> 
      <div style="padding: 20px; font-size: 25px;"> → </div> 
      <div style="border: 1px solid black; padding: 5px;"> <span style="font-weight: bold; color: green;">Green</span> <br /> Minimum code to make it pass</div> 
      <div style="padding: 20px; font-size: 25px;"> → </div> 
      <div style="border: 1px solid black; padding: 5px;"> <span style="font-weight: bold; color: blue;">Refactor</span> <br /> Clean up. Run all tests</div> 
      <div style="padding: 20px; font-size: 25px;"> → </div> 
      <div style="border: 1px solid black; padding: 5px;"> <span style="font-weight: bold; color: #ff9f00;"> Challenge </span> <br /> What edge case could break this?</div> 
      <div style="padding: 20px; font-size: 25px;"> → </div> 
      <div style="border: 1px solid black; padding: 5px;"> <span style="font-weight: bold; color: purple;">Stop</span> <br /> Report and wait for instruction</div> 
      </div>
    - Why it matters:
        - One test per cycle
        - Minimum code to pass
        - CHALLENGE drives out edge cases
        - Prevent Claude from going on and on with unguided code generation.
    - [/tdd command to implement an acceptance rule · amrullah/spec_driven_development_practice@5be0cac](https://github.com/amrullah/spec_driven_development_practice/commit/5be0cac5006b5bfc50deac487f913ebf302e7107)
    -
- ## Why Review AI code
    - #+BEGIN_CAUTION
      Blindly trust AI at your own peril
      #+END_CAUTION
    - Passing Tests don't mean the code is right. A few more things require a review:
        - Changes overview
          collapsed:: true
            - What files, classes and behaviors were introduced? Which layer? Which spec rules?
        - Architecture Compliance
          collapsed:: true
            - Domain free of Spring? Dependencies flow inward?
        - Test Quality:
          collapsed:: true
            - Concrete assertions? Testing for business outcomes? or fluff like isNotNull()?
        - API Contract
          collapsed:: true
            - Endpoints, field names, and status codes match OpenAPI Spec exactly?
        - Implementation Quality
          collapsed:: true
            - No TODO's, no dead code, swallowed exceptions, small readable methods etc.
        - Spec Traceability
          collapsed:: true
            - Every Rule → `@Nested` class? Every Example → @Test? Missing coverage?
    - You have to still manually check:
        - Does the Domain logic make sense?
        - Are the test scenarios the right ones?
        - Is the naming actually clear to humans?
        - Will this design hold for the next feature?
        - Are there implicit requirements not in the spec?
    - [/review command to review uncommitted code · amrullah/spec_driven_development_practice@6ba9666](https://github.com/amrullah/spec_driven_development_practice/commit/6ba9666ff7223e8bc40ac44d563392a6c1e5e93c)
    -