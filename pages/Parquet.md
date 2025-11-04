filters:: {"templates" false}
type:: [[File Format]] 
alias::
tags::

- https://parquet.apache.org/docs/concepts/
- Stores all the data of a column sequentially in the [[Disk]], for maximum [[Data Locality]]. This is of great advantage in [[OLAP]] queries
    - Non-contiguous storage of data can lead to frequent [[Disk]] head movements and the associated [[Performance]] penalty.
    -