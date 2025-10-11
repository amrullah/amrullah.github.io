filters:: {"templates" false}
type:: [[Concept]] 
alias::
tags:: Data Engineering, Data Architecture

- [[Medallion Architecture Course/Day 1]]
    - Central Repository designed to store and serve large volumes of structured data #definition
        - The reason it gets huge is, you typically accumulate data over a period of time.
        - Typically analyses are done over a period of months and years
        - Typically, there is a provision to keep snapshots (daily/weekly/monthly) because you want to analyze the trends over the time.
        - Usually append-only, update in-place is discouraged
            - Accesses and actions are auditable
    - ((68971576-0d1c-453a-aa67-810a00432396))
    - Has Dimesions and Facts, through which you can slice and dice [[Star Schema]]
        - Examples
            - This consumer -> What are the different kinds of products that the consumer has bought over a period of time
            - What is buying-purchasing pattern
            - pivot on a day
                - On a particular date (festival/holiday) how purchases went,
            - pivot on a product
                - What kind of age groups are buying this product
        - Some Reports are fixed, some are ad-hoc
        - Traditionally Data warehouse has fixed schema and Large
        -