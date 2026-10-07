public:: true

- # [[Hexagonal Architecture]]
    - > Separate What your Application Does from how it talks to the outside world
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
        - > Dependencies flow **inwards**. Domain never imports from Application or Adapters layer
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
        - Outbound ports. repository contracts
        - Describes the operations the Domain needs to perform on other components (Databases/external API's)
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
    - <div style="display: flex;"> 
      <div> <b>HTTP POST</b> <br /> <code>/cashback</code> <br /> Web Adapter</div> 
      <div> --> </div> 
      <div> <b>Use Case</b> <br /> <code>orchestrate</code> <br /> Application</div> 
      <div> --> </div> 
      <div> <b>Domain Logic</b> <br /> <code>calculate</code> <br /> Domain</div> 
      <div> --> </div> 
      <div> <b>Port Interface</b> <br /> <code>load data</code> <br /> Application</div> 
      <div> --> </div> 
      <div> <b>JPA Query</b> <br /> <code>fetch rows</code> <br /> Persistence Adapter</div> 
      </div>
    - Each layer only knows it's immediate neighbour inward.
    - #+BEGIN_PINNED
      Inward here means in the request journey. So Domain layer will depend on outbound ports for example and this is not contradicting the principles of Hexagonal architecture
      #+END_PINNED
    - **Results flow outward**
      Domain Result --> Use Case --> Controller --> HTTP 201 Response
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
    - > Adapters are the only classes that know about the outside world
- ### Command
    - A Simple Data Object carrying input for a [[use case]].
    - Example: `CashbackCommand` Created by Controller and Consumed by Application Service class (use case class) without knowing who created it.
- ## Tests in each layer
    - something will come here soon once I absorb the knowledge in more depth.
- ## Enforcing Hexagonal architecture rules using Claude
    - Domain Never imports org.springframework, jakarta.persistence or adapter packages
    - Controllers never contain business logic, not even simple conditionals on domain data
    - Business rules belong in the domain layer, - prefer model methods, use domain services only for cross aggregate logic
    - Dependencies flow inward: adapter -> application -> domain
    - Port Naming: LoadXxxPort / SaveXxxPort for outbound; XxxUseCase for inbound
    - Repo link: https://github.com/amrullah/spec_driven_development_practice/blob/main/CLAUDE.md#architecture-hexagonal-ports--adapters
- ## Enforcing boundaries using ArchUnit
    - Since [[LLM]]'s are non-deterministic (especially when [[Context Window]] grows large), we also need a deterministic way to enforce architectural boundaries
    - ```
      Read the Architecture boundaries in @CLAUDE.md 
      
      Generate an ArchUnit Test class under src/test/java that enforces:
      
      1. no org.springframework or jakarta.persistence in domain
      2. Layered Architecture: adapter -> application -> domain
      
      Use archunit-junit5 version 1.4.2 	
      ```
    - Code: [Enforce Hex Arch Layer boundaries using ArchUnit (at this commit all … · amrullah/spec_driven_development_practice@183926c](https://github.com/amrullah/spec_driven_development_practice/commit/183926c961726dba88625d9aa3ee478e2b3e78ac)
    -