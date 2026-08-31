public:: true

- # What are System Design Interviews
    - [[System Design]] Interviews are a way to assess your ability to take an ambiguously defined, high level problem and break it down into pieces of infrastructure that you'll need to solve it. #definition
    - These interviews are **not** about **getting to a single correct answer**.
    - **Rather your interviewer is looking to:** #[[System Design]]
        - Assess your ability to navigate a complex problem
        - Reason about trade-offs
        - Communicate your Thinking clearly
- # Assessment
    - Each company will have a different rubric for system design, but they will usually have these themes in common
    - ## Problem Navigation
      collapsed:: true
        - The interviewer is looking to assess your ability to **navigate a complex, under-specified problem**. This means you should be able to:
            - **Break down** the problem into smaller, more manageable pieces
            - **Prioritize** the most important ones, and
            - **Navigate** those pieces to a solution
        - The most common ways candidates fail with this competency:
          collapsed:: true
            - **Insufficiently** exploring the problem and gathering requirements.
            - Focusing on the **uninteresting/trivial aspects** of the problem vs. the most important ones.
            - Getting **stuck** on a particular piece of the problem and not being able to move forward.
            - **Failing** to deliver a **working** system
    - ## Solution Design
      collapsed:: true
        - With a problem broken down, the interviewer would assess how you can solve each of the pieces of the problem. Your knowledge about System Design core concepts comes into play here.
        - #+BEGIN_QUOTE
          You should be able to describe how you would solve each piece of the problem, and how those pieces fit together into a cohesive whole.
          #+END_QUOTE
        - The most common ways candidates fail with this competency:
          collapsed:: true
            - Not having a strong enough understanding of the core concepts to solve the problem.
            - Ignoring scaling and performance considerations.
            - Sphagetti design
    - ## Technical Excellence
      collapsed:: true
        - To be able to design a great system, you'll need to know about best practices, current technologies and how to apply them. This is where your knowledge of key technologies and well-recognized patterns comes into picture.
        - The most common ways candidates fail with this competency:
          collapsed:: true
            - Not knowing about the available technologies.
            - Using antiquated approaches or being constrained by outdated hardware constraints.
            - Not knowing how to apply the technologies to the problem at hand.
            - Not recognizing common patterns and best practices.
    - ## Communication and Collaboration
      collapsed:: true
        - This includes your ability to communicate complex concepts, respond to feedback and questions, and in some cases work together with the interviewer to solve the problem.
        - The most common ways candidates fail with this competency:
          collapsed:: true
            - Not being able to communicate complex concepts clearly.
            - Being defensive or argumentative when receiving feedback.
            - Getting lost in the weeds and not being able work with the interviewer to solve the problem
- # Delivery Framework
    - Diagram
      collapsed:: true
        - {{renderer :drawio, 1787236710108.svg}}
    - ## 1. Requirements (~5 min)
      collapsed:: true
        - ### Functional Requirements
            - They are your **"Users should be able to ..."** statements. These are the core features of your system and should be the first thing to discuss with your interviewer.
            - #+BEGIN_IMPORTANT
              Ask Targeted questions as if you were talking to a client, customer or product manager, to arrive at a prioritized list of core features.
              #+END_IMPORTANT
            - #+BEGIN_IMPORTANT
              The main objective in the remaining part of the interview is to develop a system that meets the requirements you have identified. Identify and prioritize top 3. Sometimes even your ability to prioritize is evaluated.
              #+END_IMPORTANT
        - ### [[Non Functional Requirements]]
            - These are statements about system qualities that are important to the users of the system. These can be phrased as **"The System should be able to ..."**. For Example:
                - The system should be highly available, prioritizing [[Availability]] over Consistency
                - The system should be able to scale to support 100M+ [[DAU]]
                - The system should be low latency, rendering feeds under 200ms
            - #+BEGIN_QUOTE
              It's important that [[NFR]]s are put in the context of the system and where possible, are quantified. 
              #+END_QUOTE
            - Coming up with [[NFR]]s can be challenging, here's a checklist of things to consider that might help you identify the most important ones. You'll want to identify top 3-5 that are most relevant.
                - **[[CAP Theorem]]:** Should your system prioritize Consistency or [[Availability]], given partition tolerance.
                  logseq.order-list-type:: number
                - **Environment Constraints:** Are there any constraints on the environment in which your system will run? For example, mobile device with low battery or Streaming video on 3G/2G network.
                  logseq.order-list-type:: number
                - **[[Scalability]]:** All systems need to scale, but what are the unique scaling requirements of this system? Does it have bursty traffic at a specific time of the day? Are there events like holidays, that will cause significant increase in the traffic? Also consider the read-vs-write ratio here. Is it a write-heavy vs read-heavy system?
                  logseq.order-list-type:: number
                - **[[Latency]]:** How quickly the system needs to respond to the user requests?
                  logseq.order-list-type:: number
                - **[[Durability]]:** How important is it that the data in your system is not lost? For example a Social network might be able to tolerate some loss of data but a bank cannot.
                  logseq.order-list-type:: number
                - **[[Security]]:** How secure the system needs to be? Consider Data Protection, Access Control and Compliance with regulations.
                  logseq.order-list-type:: number
                - **[[Fault Tolerance]]:** How well does the system need to handle failures? Consider redundancy, failover and recovery mechanisms
                  logseq.order-list-type:: number
                - **[[Compliance]]:** Are there legal or regulatory requirements the system needs to meet? Consider industry, data protection laws and other regulations
                  logseq.order-list-type:: number
        - ### Capacity Estimation
            - The authors of the course suggest not to delve into arithmetic just yet, do it in the design phase.
    - ## 2. Core Entities (~2 min)
      collapsed:: true
        - Next, you should take a moment to identify and list the core entities of your system.
            - This helps you define terms, understand the data central to your design and gives you a foundation to build on.
        - Early on, you'd want to jot down an initial list of obvious entities. And explicitly mention to your interviewer that this is a first-draft.
            - This is because, as you design your system, you'll discover new entities and relationships.
                - Starting with a small list helps you quickly move to next steps and iteratively  add new entities / relationships as they are discovered (Especially in the API's and HLD stages)
        - A couple of questions to help identify the core entities:
            - Who are the actors in the system? Are they overlapping?
            - What are the nouns or resources necessary to satisfy the functional requirements?
    - ## 3. API or System Interface (~5 min)
      collapsed:: true
        - Before you get into HLD, you'd want to define the contract between your system and it's users.
            - Often, this maps directly to the functional requirements you have directly identified. (but not always)
        - You'll use this contract to guide your High Level Design and ensure you are meeting the requirements you have identified
        - You generally have options between: REST, gRPC or GraphQL.
            - Usually, REST is the right answer most of the time.
    - ## 4. [[High Level Design]] (~10 min)
      collapsed:: true
        - Now that you have clear understanding of requirements, entities and API contracts of your system, you can start designing the High Level architecture.
        - #+BEGIN_QUOTE
          Your primary goal in this stage is to design an architecture that satisfies the API you have designed, thus, the requirement you have identified.
          #+END_QUOTE
        - #+BEGIN_WARNING
          Focus on a relatively simple design that meets the core functional requirements then layer on complexity to satisfy the NFR in your deep dives stage.
          #+END_WARNING
        - When your request reaches database, it's a great time to start documenting the **relevant** columns / fields for each entity.
    - ## 5. Deep Dives (~10 min)
      collapsed:: true
        - Now that you have High Level Design ready, you'll spend the remaining time in hardening the design by:
            - Ensuring it meets all your [[NFR]]s
            - Addressing Edge cases
            - Identifying and addressing issues and bottlenecks
            - Improving the design based on the probes from your interviewer
        - #+BEGIN_QUOTE
          The degree to which you're proactive in leading deep-dives is a function of your seniority.
          #+END_QUOTE