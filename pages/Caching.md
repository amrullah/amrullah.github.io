filters:: {"templates" false}
type:: [[Concept]] 
alias:: cache
tags:: System Design, Software Architecture

- ## The cost of Caching and mitigation strategies
    - ### Invalidation
        - The right approach would depend on how fresh the data needs to be.
    - ### Stampede / Thundering Herd
        - Locking (only one entry generates cache entry)
        - Early recomputation
        - staggering [[TTL]]s so the entries don't all expire at once.
    - ### Cache outage
        - circuit breakers
        - small in-process fall-back cache
        - graceful degradation of UI features until cache recovers
        -