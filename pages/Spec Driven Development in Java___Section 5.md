public:: true

- # [[Hexagonal Architecture]]
- ## Brief Introduction
- ### Key Idea
    - #+BEGIN_QUOTE
      **1. Domain at the core**
      Pure business logic, no database, not HTTP. Unit tests for the code here runs in milliseconds
      #+END_QUOTE
    - #+BEGIN_QUOTE
      **2. Ports are interfaces**
      The application declares what it needs. It doesn't need to know how.
      #+END_QUOTE
    - #+BEGIN_QUOTE
      **3. Adapters plug-in**
      JPA, REST controller, message queue..
      #+END_QUOTE
    - Diagram
      collapsed:: true
        - ![Hex Architecture](..assets/hex_architecture.png)
          collapsed:: true
            - {{renderer :drawio, 1788887937363.svg}}
        -
- ### Another look
- #### Domain (Pure Java)
    - `model/`
      collapsed:: true
        - entities and value objects
    - `service/`
      collapsed:: true
        - business rules
        - I would have liked the name `business_logic/`. Due to the insights that I have from [[The Design of Everyday Things]] #me
        -
    - No Spring, No JPA, No HTTP.
- ##### Testing strategy:
    - Plain JUnit5 + AssertJ. No Spring, no `@SpringBootTest`
    - Majority of tests live here.
- #### Application
    - `port/in/`
      collapsed:: true
        - Inbound ports. [[Use case]] interfaces
            - Services users need to perform on the Application Or business needs them done. Example: `CalculateCashback`, `ProcessTransaction`
    - `port/out/`
      collapsed:: true
        - Outbound ports. repository contracts
        - interacting with components that we need to interact with to get the job done
        - Example, LoadTransactions, SaveCashback that eventually interact with databases or REST API's
    - Key points:
      collapsed:: true
        - [[I think]] the difference between Inbound and outbound ports is:
            - Inbound Ports shall contain interfaces that represent Use cases that reflect Stakeholder Requirements.
            - Outbound Ports contain  "capabilities" that the use cases depend on.
            - Example, In E-Commerce, inbound would be Place Order and Outbound would be Save Order
        - `@Service` **orchestrates** actions that need to achieve some **business outcome**. No rules
        - > **Dependencies flow inward**
          > Adapter --> Application --> Domain
- ##### Testing Strategy
    - Plain JUnit. Mock the ports
- #### Adapters
    - **Web Adapter** (inbound)
        - `@RestController`, DTO's, HTTP
        - Delegates to Application layer Services
        - ##### Testing Strategy
            - `@WebMvcTest`. Request Validation, JSON Mapping, Status Codes
    - **Persistence Adapter** (outbound)
        - implements outbound ports
        - JPA repositories / JPA entities
        - ##### Testing Strategy
            - `@DataJpaTest`. JPA Queries, mappings, DB Constraints
- > **Test pyramid**
  > Many fast domain tests, few adapter tests, one acceptance test per business rule.
- ## A Request's walk through the Hexagonal Architecture
    -
    - > **Results flow outward**
      > Domain Result --> Use Case --> Controller --> HTTP 201 Response
- ## Hexagonal Architecture Vocabulary
- ### [[Use Case]]
    - An interface describing one thing the system can do.
    - For example `CalculateCashbackUseCase`
    - The Controller
- ### Port
    - An interface at the application boundary.
    - Inbound ports (use cases) let the outside in.
    - Outbound ports let the inside reach out.
        - For example you can have an outbound port called `LoadTransactions` which lets your application reach out for data without knowing where that data actually lives.
- ### Adapter
    - A concrete class that plugs into a port.
    - REST Controllers are inbound adapters.
    - JPA repositories are outbound adapters.
- ### Command
    - A Simple Data Object carrying input for a [[use case]].
    - Example: `CashbackCommand` Created by Controller and Consumed by Application Service class (use case class) without knowing who created it.
-