filters:: {"templates" false}
type:: [[Internet Resource]] 
alias:: 
link:: https://eminent-croissant-92f.notion.site/HLD-1e85855731e080e1b2c7edcd18709b9d
tags:: Software Architecture, System Design

- ## **1. Fundamentals of HLD**
- **Scalability** (Horizontal vs Vertical Scaling)
- **Latency vs Throughput**
- **Load Balancing** (DNS-based, L4 vs L7 Load Balancing)
- **Caching** (CDN, Application, Database Caching)
- **CAP Theorem** (Consistency, Availability, Partition Tolerance)
- **Database Sharding & Replication**
- **Consistency Models** (Strong, Eventual, Read-after-write, etc.)
- **Message Queues & Event-Driven Architecture**
-
- ## **2. Networking & System Communication**
- **DNS Resolution** (Recursive, Iterative Queries)
- **TCP vs UDP** (When to use each?)
- **HTTP vs WebSockets vs gRPC vs SSE**
- **Reverse Proxy & Forward Proxy**
- **CDNs & Edge Caching & POP**
- **API Gateways** (Rate limiting, Authentication, Logging)
-
- ## **3. Databases & Storage**
- ### **Relational Databases (SQL)**
    - **RDBMS vs NoSQL** (When to use?)
    - **ACID Properties**
    - **Indexing Strategies (B-Trees, Hash Index, GIN, BRIN)**
    - **Partitioning (Range, Hash, List, Composite)**
    - **Query Optimization & Joins**
    - **Replication (Master-Slave, Master-Master)**
    - **Database Failover Strategies**
- ### **NoSQL Databases**
    - **Key-Value Stores (Redis, DynamoDB)**
    - **Document Stores (MongoDB, CouchDB)**
    - **Columnar Stores (Cassandra, BigTable)**
    - **Graph Databases (Neo4j, Amazon Neptune)**
    - **Eventual Consistency vs Strong Consistency**
    - **Data Modeling in NoSQL**
    - **NoSQL Scaling (Auto-sharding, Consistent Hashing)**
- ### **Storage Systems**
    - **Block Storage vs Object Storage (EBS vs S3)**
    - **Distributed File Systems (HDFS, Ceph, Lustre)**
    - **Data Compression & Deduplication**
    - **Blob Storage (AWS S3, Azure Blob)**
- ## **4. Caching Strategies**
- **Client-side vs Server-side Caching**
- **Cache Eviction Policies (LRU, LFU, TTL, FIFO)**
- **Write-through vs Write-back vs Write-around**
- **Distributed Caching (Redis Cluster, Memcached)**
- **CDN Strategies (Cloudflare, Akamai)**
- **Cache Invalidation Strategies**
- **Hot vs Cold Cache Management**
- ## **5. Load Balancing & Traffic Management**
- **Types of Load Balancers (L4 vs L7)**
- **Round Robin, Weighted, Least Connections**
- **Health Checks & Failover**
- **Global Load Balancing (GeoDNS, Anycast)**
- **Sticky Sessions & Connection Pooling**
- **Rate Limiting Strategies**
- ## **6. Microservices & Event-Driven Architecture**
- **Monolith vs Microservices**
- **Service Discovery (Eureka, Consul, Zookeeper)**
- **API Gateway & BFF Pattern**
- **Synchronous vs Asynchronous Communication**
- **Message Brokers (Kafka, RabbitMQ, SQS)**
- **Event Sourcing vs CQRS**
- **Saga Pattern for Distributed Transactions**
- **Observability (Tracing, Metrics, Logging with ELK, Prometheus)**
- ## **7. Distributed Systems & Consistency**
- **Leader Election Algorithms (Paxos, Raft, Zookeeper)**
- **Consensus Protocols (2PC, 3PC, Gossip Protocols)**
- **Vector Clocks & Logical Clocks**
- **Distributed Transactions & Idempotency**
- **Circuit Breakers (Resilience4j, Hystrix)**
- **Shadow Traffic Testing**
-
- ## **8. Security & Authentication**
- **OAuth 2.0, JWT, OpenID Connect**
- **Session Management & CSRF Protection**
- **SSL/TLS, mTLS**
- **Zero Trust Architecture**
- **DDoS Protection & Rate Limiting**
- **HSTS, CSP, CORS**
- **Secrets Management (Vault, AWS Secrets Manager)**
-
- ## **9. Logging, Monitoring & Observability**
- **Centralized Logging (ELK Stack, Graylog)**
- **Distributed Tracing (Jaeger, OpenTelemetry)**
- **Metrics & Monitoring (Prometheus, Grafana, New Relic)**
- **Alerting & Incident Management (PagerDuty, OpsGenie)**
- **Log Aggregation Techniques**
- **Blue-Green Deployment Monitoring**
-
- ## **10. System Design Patterns & Real-World Applications**
- **Rate Limiting Design (API Throttling)**
- **Distributed Locking Mechanisms**
- **Quorum-Based Consistency**
- **Designing Large-scale Data Pipelines**
- **Streaming Systems (Kafka, Flink, Spark Streaming)**
- **Designing a URL Shortener**
- **Designing a Notification System**
- **Designing a Rate-Limited API Gateway**
- **Designing a High-Throughput Chat Application**
- **Designing a Ride-Sharing System (Uber, Ola)**
- **Designing a Search Autocomplete System**
- **Designing a Video Streaming Service (YouTube, Netflix)**
- **Designing an E-commerce Checkout System**
- **Designing a Distributed Web Crawler**
-
- ## **🔥 Final Steps to FAANG-Level HLD Mastery 🚀**
  
  🔹 **Focus on Scalability & Distributed Systems (More than Just APIs & Databases)**
  
  🔹 **Understand Real-World Architectures (Google, Uber, Netflix, Amazon)**
  
  🔹 **Practice System Design Mock Interviews (Explain Trade-offs, Draw Diagrams, Justify Decisions)**
  
  🔹 **Analyze How to Scale a System Step-by-Step (1 Million → 100 Million Users)**
-
- ### **🔥 Estimations**
  
  ✅ **Yes, estimations are crucial for FAANG interviews** because:
  
  1️⃣ **They help define system scale and constraints** (e.g., how much storage, how many servers).
  
  2️⃣ **They guide architectural decisions** (e.g., SQL vs NoSQL, caching strategies, replication).
  
  3️⃣ **They show your ability to think in terms of real-world trade-offs.**
-
- ## **🔥 What Estimations Should You Know?**
- ### **1️⃣ Traffic Estimations**
  
  🔹 **Requests per second (RPS)** → How many requests hit your system every second?
  
  🔹 **Peak Traffic vs Average Traffic** → Does traffic spike during certain hours?
  
  🔹 **Read vs Write Ratio** → Are reads more frequent than writes? (e.g., 90% read, 10% write)
  
  🔹 **Concurrency** → How many users are using the system at the same time?
  
  ✔ **Example:**
- **Twitter:** 500M tweets per day → ~5,800 RPS
- **WhatsApp:** 100B messages per day → ~1.2M RPS
- ### **2️⃣ Storage Estimations**
  
  🔹 **Data size per request** → How much data does each request store?
  
  🔹 **Retention period** → How long do we need to store the data?
  
  🔹 **Replication factor** → How many copies of data are kept for redundancy?
  
  ✔ **Example:**
- Each tweet is **280 characters (~300 bytes)**
- 500M tweets/day → **150GB/day**
- Retention for **5 years** → **273TB total storage**
- ### **3️⃣ Bandwidth & Network Estimations**
  
  🔹 **How much data flows in and out per second?**
  
  🔹 **Upload/download speed required?**
  
  🔹 **Impact on load balancers & CDN?**
  
  ✔ **Example:**
- A YouTube 1080p video is **5MB/min**
- If **1M users stream at once**, total bandwidth = **83Gbps**
- ### **4️⃣ Database Estimations**
  
  🔹 **How many rows/documents are inserted per second?**
  
  🔹 **Sharding strategy based on data size?**
  
  🔹 **Index size impact on queries?**
  
  ✔ **Example:**
- If 1M users log in daily and store **100KB** of metadata each,
    - DB grows by **100GB/day**
    - Need **partitioning or sharding after a few TB**
- ### **5️⃣ Cache & CDN Estimations**
  
  🔹 **How much cache memory is needed to store hot data?**
  
  🔹 **Cache hit ratio (e.g., 80% cache hits)?**
  
  🔹 **Latency impact if cache misses?**
  
  ✔ **Example:**
- If a website serves **10M requests/day**
- 80% cache hit rate → only **2M requests go to DB**
-
- ## **🔥 Do FAANG Interviews Ask for Estimations?**
  
  ✅ **Yes!** If you're designing systems like **Twitter, Netflix, or Uber**, you must estimate:
  
  1️⃣ **How many users?**
  
  2️⃣ **How much data per second?**
  
  3️⃣ **How many machines are needed?**
-
- ## **🔥 Practice Estimation Problems**
  
  🔹 Estimate storage needs for a **video streaming service** like YouTube
  
  🔹 Estimate **RPS for a messaging app** like WhatsApp
  
  🔹 Estimate **bandwidth required for a real-time game server**
  
  🔹 Estimate **cache size needed for a social media feed**
-
- ## For Interviews:
  
  List of High Level Design (HLD) questions for SDE1/SDE2 roles at FAANG-level companies:
-
- ## **Core System Design Fundamentals**
  
  **Basic Systems (SDE1 focused)**
- Design a URL shortener (like [bit.ly](http://bit.ly/) or tinyurl)
- Design a key-value store (like Redis)
- Design a simple cache system
- Design a basic chat application
- Design a file storage system
- Design a basic recommendation system
- Design a simple load balancer
- Design a web crawler
- Design a basic search engine
- Design a simple notification system
  
  **Intermediate Systems (SDE1/SDE2 bridge)**
- Design a distributed cache system
- Design a message queue system
- Design a basic social media feed
- Design a simple video streaming service
- Design a basic e-commerce platform
- Design a simple ride-sharing service
- Design a basic payment system
- Design a simple booking system
- Design a basic photo sharing service
- Design a simple email service
-
- ## **Advanced Systems (SDE2 focused)**
  
  **Social Media & Communication**
- Design Twitter/X with timeline generation
- Design Facebook newsfeed
- Design Instagram with photo/video sharing
- Design WhatsApp messaging system
- Design LinkedIn professional network
- Design TikTok short video platform
- Design Discord chat with voice/video
  
  **E-commerce & Marketplace**
- Design Amazon product catalog and search
- Design Flipkart with inventory management
- Design Uber/Ola ride-sharing platform
- Design Swiggy/Zomato food delivery
- Design BookMyShow ticket booking
- Design Airbnb property rental platform
  
  **Content & Media**
- Design YouTube video streaming platform
- Design Netflix content delivery
- Design Spotify music streaming
- Design Medium blogging platform
- Design Pinterest image discovery
- Design Zoom video conferencing
- **Financial & Payment Systems**
- Design PayPal payment processing
- Design Paytm wallet system
- Design stock trading platform
- Design cryptocurrency exchange
- Design expense tracking application
- ## **Infrastructure & Platform Systems**
  
  **Core Infrastructure**
- Design a Content Delivery Network (CDN)
- Design a distributed database system
- Design a monitoring and alerting system
- Design a distributed logging system
- Design a service discovery system
- Design a configuration management system
- Design a distributed file system
- Design an API gateway
- Design a container orchestration system
  
  **Analytics & Data Processing**
- Design Google Analytics
- Design a real-time analytics system
- Design a data warehouse solution
- Design a recommendation engine
- Design a search analytics platform
- Design a A/B testing platform
-
- ## **Gaming & Entertainment**
- Design a multiplayer online game backend
- Design a gaming leaderboard system
- Design a live streaming platform for gaming
- Design a fantasy sports platform
-
- ## **Enterprise & Productivity**
- Design Google Drive file sharing
- Design Slack workspace communication
- Design Jira project management
- Design Google Calendar scheduling
- Design Dropbox file synchronization
-
- ## **Location & Maps**
- Design Google Maps navigation
- Design location-based services
- Design a GPS tracking system
- Design a geocoding service
-
- ## **Key Focus Areas for Indian Market**
  
  **India-Specific Considerations**
- Handle diverse language support (i18n)
- Design for intermittent connectivity
- Optimize for low-end devices
- Handle massive scale (India's population)
- Design for price-sensitive markets
- Consider regional regulations and compliance
  
  **Practice Strategy Tips**
- **Start with requirements gathering** - Always clarify functional and non-functional requirements
- **Estimate scale** - Calculate DAU, QPS, storage requirements
- **High-level architecture** - Draw major components and data flow
- **Deep dive into components** - Explain databases, caching, load balancing
- **Scale considerations** - Discuss bottlenecks and scaling strategies
- **Trade-offs** - Explain consistency vs availability, latency vs throughput
-
- **Common Technical Concepts to Master**
- Database sharding and partitioning
- Caching strategies (Redis, Memcached)
- Load balancing techniques
- Microservices architecture
- Message queues (Kafka, RabbitMQ)
- NoSQL vs SQL databases
- CDN and edge computing
- Monitoring and observability
- Security and authentication
- Rate limiting and throttling
  
  Focus on 2-3 systems per week, practice drawing them out, and be ready to discuss trade-offs and scaling strategies.
-