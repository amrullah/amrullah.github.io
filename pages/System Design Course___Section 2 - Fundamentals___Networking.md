public:: true

- # Journey of a simple web request
- When you type a URL into your browser, several layers of networking protocols spring into action in a series of carefully orchestrated steps, like setting up a TCP connection over IP, send our HTTP request, get a response and teardown the connection. In detail:
    - **DNS Resolution:** The client starts by resolving the domain name of the website to an IP address using DNS
      logseq.order-list-type:: number
    - **TCP Handshake:** The client initiates a TCP connection with the server using a three-way handshake:
      logseq.order-list-type:: number
        - **SYN:** The client sends a SYN (synchronize) packet to the server to request a connection.
        - **SYN-ACK:** The server responds with an SYN-ACK to acknowledge the connection request.
        - **ACK:** The client sends ACK package to establish the connection.
    - **HTTP Request:** Once the TCP connection is established, the client sends an HTTP GET request to the server to request the web page.
      logseq.order-list-type:: number
    - **Server Processing**: The server processes the request, retrieves the requested web page, and prepares an HTTP response. (This is usually the only latency most SWE's think about and control!)
      logseq.order-list-type:: number
    - **HTTP Response**: The server sends the HTTP response back to the client, which includes the requested web page content.
      logseq.order-list-type:: number
    - **TCP Teardown**: After the data transfer is complete, the client and server close the TCP connection using a four-way handshake:
      logseq.order-list-type:: number
        - **FIN**: The client sends a FIN (finish) packet to the server to terminate the connection
        - **ACK**: The server acknowledges the FIN packet with an ACK.
        - **FIN**: The server sends a FIN packet to the client to terminate its side of the connection.
        - **ACK**: The client acknowledges the server's FIN packet with an ACK.
- # Transport Layer protocols
- ## UDP: Fast but unreliable
    - **Key Characteristics**
        - **Connectionless**: No handshake or connection setup
        - **No guarantee of delivery**: Packets may be lost without notification
        - **No ordering**: Packets may arrive in a different order than sent
        - **Lower latency**: Less overhead means faster transmission
    - collapsed:: true
      > UDP is perfect for applications where **speed is more important than reliability**, such as live video streaming, online gaming, VoIP, and DNS lookups.
        - In these cases the application or client is equipped to handle the occasional packet loss or out of order packet. For VOIP as an example, the client might just drop the occasional packet leading to a hiccup in the audio but overall the conversation is still intelligible. This is vastly preferable to retransmitting those lost packets and clogging up the network with ACKs.
        -
    - #+BEGIN_WARNING
      Browsers don't have widespread support for UDP yet outside of WebRTC (we'll get into it). If you're thinking about a design which could use UDP (like the spamming of hearts and reactions in Facebook Live Comments), think about what you'll do for your browser-based users. It might be that your app-based users get a real-time UDP stream of reactions while browser-based users a slower, batched HTTP stream which you spread out over time in the UI.
      #+END_WARNING
- ## TCP: Reliable but with Overhead
    - Transmission Control Protocol (TCP) is the workhorse of the internet. It provides reliable, ordered, and error-checked delivery of data.
    - **Key Characteristics**
        - **Connection-oriented**: Establishes a dedicated connection before data transfer
        - **Reliable delivery**: Guarantees that data arrives in order and without errors
        - **Flow control**: Prevents overwhelming receivers with too much data
        - **Congestion control**: Adapts to network congestion to prevent collapse
- ## TCP vs UDP comparison
    - | Feature | UDP | TCP |
      | ---- | ---- | ---- |
      | Connection | Connectionless | Connection-oriented |
      | Reliability | Best-effort delivery | Guaranteed delivery |
      | Ordering | No ordering guarantees | Maintains order |
      | Flow Control | No | Yes |
      | Congestion Control | No | Yes |
      | Header Size | 8 bytes | 20-60 bytes |
      | Speed | Faster | Slower due to overhead |
      | Use Cases | Streaming, gaming, VoIP | Everything Else |
- # Application Layer
- ## REST
    - REST is the most common API paradigm you'll use in system design interviews. It's a simple and flexible way to create APIs that are easy to understand and use. The core principle behind REST is that clients are often performing simple operations against **resources** (think of them like database tables or files on a server).
- ### Where to use it
    - Overall REST is very flexible for a wide variety of use-cases and applications. And is going to be the default choice for API design
    - REST is [not going to be the most performant solution](https://medium.com/@i.gorton/scaling-up-rest-versus-grpc-benchmark-tests-551f73ed88d4) for very high throughput services, and generally speaking JSON is a pretty inefficient format for serializing and deserializing data.
        - There is no universal requests-per-second threshold for "very high throughput" Start with REST and JSON, then consider gRPC only after measurements show serialization, network transfer, or connection overhead is a meaningful bottleneck.
        - A practical interview answer is that gRPC becomes worth exploring when an internal service handles sustained high volume with small, frequent messages and your latency or CPU budget is tight. You should be able to say what is saturated first. For instance, if profiling shows JSON parsing consumes a large share of service CPU at hundreds of thousands of internal requests per second, gRPC is a reasonable next step. If database work dominates latency, changing REST to gRPC will not help much.
    - Most applications aren't going to be bottlenecked by request serialization. You should reach for GraphQL, gRPC, SSE, or WebSockets if you have specific needs that REST can't meet.
- ## GraphQL
    - GraphQL is a more recent API paradigm (open-sourced circa 2015 by Facebook) that allows clients to request exactly the data they need.
    - Here's the problem GraphQL solves:
        - Frequently teams and systems are organized into frontend and backend. As an example, the frontend might be a mobile app and the backend a database-based API.
        - When the frontend team wants to display a new page, they can either (a) cobble together a bunch of different requests to backend endpoints (imagine querying 1 API for a list of users and making 10 API calls to get their details), (b) create huge aggregation APIs which are hard to maintain and slow to change, or (c) write brand new APIs for every new page they want to display. *None of these are particularly good solutions* but it's easy to run into them with a standard REST API.
        - The problem with under-fetching is that you may need multiple requests and round trips. This adds overhead and latency to the page load.
        - Over-fetching is the opposite: when we pack way more than we need in an API response to guard ourselves against future use-cases that we don't have today. It means that APIs take a long time to load and return too much data.
    - GraphQL solves these problems by allowing the frontend team to flexibly query the backend for exactly the data they need. The backend can then respond with the data in the shape that the frontend needs it. This is a great fit for mobile apps and other use-cases where you want to reduce the amount of data transferred.
- ### Where to use it
    - GraphQL is a great fit for use-cases where the frontend team needs to iterate quickly and adjust. They can flexibly query the backend for exactly the data they need.
    - In practice, GraphQL finds its sweet spot with complex clients and when multiple teams are making wide queries to overlapping data.
- ## gRPC
    - gRPC is a high-performance RPC (Remote Procedure Call) framework from Google that uses HTTP/2 and Protocol Buffers.
    - gRPC includes a bunch of features relevant for operating microservice architectures at scale like streaming, deadlines, client-side load balancing and more.
- ### Where to use it
    - gRPC shines in [[microservices]] architectures where services need to communicate efficiently. Its strong typing helps catch errors at compile time rather than runtime, and its binary protocol is more efficient than JSON over HTTP ([some benchmarks show a factor of 10x throughput!](https://medium.com/@i.gorton/scaling-up-rest-versus-grpc-benchmark-tests-551f73ed88d4)). Consider gRPC for internal service-to-service communication, especially when **performance is critical** or when **latencies** are dominated by the **network** rather than the work the server is doing.
    - That said, you generally won't use gRPC for public-facing APIs, especially for clients you don't control, because it's a binary protocol and the tooling for working with it is less mature than simple JSON over HTTP. Having internal APIs using gRPC and external APIs using REST is a great way to get the benefits of a binary protocol without the complexity of a public-facing API.
- ## Server-Sent Events (SSE):
    - Server-Sent Events (SSE) is a spec defined on top of HTTP that allows a server to push many messages to the client over a single HTTP connection.
    - SSE is a nice hack on top of HTTP that **allows a server to stream many messages, over time, in a single response from the server**.
    - With SSE, the server can push many messages as "chunks" in a single response from the server. Each line is received as a separate message from the server. The client can then process each message as it comes in. It's still one big HTTP response (same TCP connection), but it comes in over many smaller packets and clients are expected to process each line of the body individually to allow them to react to the data as it comes in.
- ### Where to use it
    - You'll find SSE useful in system design interviews in situations where you want clients to get notifications or events as soon as they happen. SSE is a great option for keeping bidders up-to-date on current price of auction, for example
- ### Limitations
    - Now with all good hacks, SSE comes with some acute limitations.
    - We can't keep an SSE connection open for too long because the server (or the load balancer, or a middle box proxy) will close down the connection. So the SSE standard defines the behavior of an `EventSource` object that, once the connection is closed, will automatically reconnect with the ID of the last message received. Servers are expected to keep track of prior messages that may have been missed while the client was disconnected and resend them.
- ## WebSockets
    - WebSockets provide a persistent, TCP-style connection between client and server, allowing for real-time, bidirectional communication with broad support (including browsers). Unlike HTTP's request-response model, WebSockets enable servers to **push** data to clients without being prompted by a new request. Similarly clients can push data back to the server without the same wait.
    - WebSockets are initiated via an HTTP "upgrade" protocol, which allows an existing TCP connection to change L7 protocols. This is super convenient because it means you can utilize some of the existing HTTP session information (e.g. cookies, headers, etc.) to your advantage.
    - Here's how it works:
        - Client initiates WebSocket handshake over HTTP (with a backing TCP connection)
        - Connection upgrades to WebSocket protocol, WebSocket takes over the TCP connection
        - Both client and server can send binary messages to each other over the connection
        - The connection stays open until explicitly closed.
- ### Where to use it
    - WebSockets come up in system design interviews when you need **high-frequency**, **persistent**, **bi-directional** communication between client and server. Think real-time applications, games, and other use-cases where you need to send and receive messages as soon as they happen.
- ### Limitations
    - WebSockets are powerful, but the infra required to support them can be expensive and the overhead of stateful connections (especially at scale) will require significant accommodations in your design. Hold off unless you really need them!
- ## WebRTC
    - WebRTC is ideal for audio/video calling and conferencing applications. It can also occasionally be appropriate for collaborative applications like document editors, especially if they need to scale to many clients.
    - In practice, most collaborative editors *don't* require scaling to thousands of clients. Additionally, you often need a central server anyways to store the document and coordinate between clients.
    - WebRTC is an absolute pain to get right and even the best implementations still suffer connection losses. It is a niche solution.
    - It's best sticking to WebRTC for video/audio calling and conferencing applications.
- # Load Balancing
- Types:
- ## Client Side Load Balancing
    - With client-side load balancing, the client itself decides which server to talk to. Usually this involves the client making a request to a service registry or directory which contains the list of available servers
    - Client-side load balancing can be very fast and efficient. Since the client is making the decision, it can choose the fastest server without any additional latency. Instead of using a full network hop to get routed to the right server on every request, we only need to (periodically) sync our list of servers with the server registry.
    - **Example: [[Redis]] Cluster**
        - Redis cluster nodes maintain a gossip protocol between each other to share information about the cluster: which nodes are present, their status, etc. Every node knows about every other node!
        - In order to connect to a Redis Cluster, the client will make a request to any of the nodes in the cluster and ask about both the nodes participating in the cluster and the shards of data they contain
        - When it comes time to read or write data, the client hashes the key to determine which shard to send the request to, then uses the locally retrieved node information to decide which node to talk to.
    - #### Where to use it
        - Client-side load balancing can work great in two different scenarios:
            - we have a small number of clients that we control, (e.g. the Redis Cluster client, or gRPC's client-side load balancing for internal services)  OR
              logseq.order-list-type:: number
            - we have a large number of clients but we can tolerate slow updates (e.g. DNS)
              logseq.order-list-type:: number
        - In an interview setting, client-side load balancing works remarkably well for internal microservices (it's actually built in to gRPC)
- ## Dedicated Load Balancers
    - We may not want our clients to have to refresh their list of servers or even know about the existence of multiple servers on the backend. Or we might have a large number of clients that we don't control but need to retrieve updates quickly.
    - In these cases, we'll use a dedicated load balancer: a server or hardware device that sits between the client and the backend servers and makes decisions about which server to send the request to.
    - These load balancers can operate at different layers of the protocol stack and which you choose will depend, in part, on what your application needs.
    - Having a dedicated load balancer implies an additional hop in each request: first to the load balancer, then to the server which needs to serve the request. But in exchange we get very fast updates to our list of servers and fine-grained control over how we route requests.
- ### Layer 4 Load Balancers
    - Layer 4 load balancers operate at the transport layer (TCP/UDP). They make routing decisions based on network information like IP addresses and ports, **without looking at the actual content of the packets**.
    - Layer 4 load balancers have some key characteristics. They ...
        - Maintain persistent TCP connections between client and server.
        - Are fast and efficient due to minimal packet inspection.
        - Cannot make routing decisions based on application data.
        - Are typically used when raw performance is the priority.
    - For example, if a client establishes a TCP connection through an L4 load balancer, that same server will handle all subsequent requests within that TCP session. This makes L4 load balancers particularly well-suited for protocols that require persistent connections, like WebSocket connections.
    - > At a conceptual level, *it's as if we have a direct TCP connection between client and server which we can use to communicate at higher layers*.
- #### Where to use it
    - L4 load balancers are great for **WebSocket** connections and other protocols that **require persistent connections**.
    - They're also great for high-performance applications that don't require much application-level processing.
    - For everything other than WebSocket, L7 is a better choice
- ### Layer 7 Load Balancers
    - Layer 7 load balancers operate at the application layer, understanding protocols like HTTP. They can **examine the actual content of each request and make more intelligent routing decisions**.
    - Layer 7 load balancers have some key characteristics. They ...
        - Terminate incoming connections and create new ones to backend servers.
        - Can route based on request content (URL, headers, cookies, etc.).
        - More CPU-intensive due to packet inspection.
        - Provide more flexibility and features.
        - Better suited for HTTP-based traffic.
- #### Where to use it
    - Layer 7 load balancers are great for HTTP-based traffic which is going to cover all of the protocols we've discussed so far except for Websockets.
- ### Choosing between Layer 4 and Layer 7
    - The choice between L4 and L7 load balancers often comes up in system design interviews when discussing real-time features. There are some L7 load balancers which explicitly support connection-oriented protocols like WebSockets, but generally speaking L4 load balancers are better for WebSocket connections, while L7 load balancers offer more flexibility for HTTP-based solutions like long polling.
- ### Health Checks and Fault Tolerance
    - While load balancers play a key role in distributing load and traffic, they are also responsible for monitoring the health of backend servers. If a server loses power or crashes, the load balancer stops routing traffic to it until it recovers.
    - This automatic failover capability is what makes load balancers essential for [[High Availability]]. They can detect and route around failures without user intervention.
      collapsed:: true
        - To do this, load balancers use **health checks**. Health checks are a way for the load balancer to determine if a server is healthy. They can be configured to check the server at different intervals and with different protocols.
          collapsed:: true
            - A common approach is to use a TCP health check, which is a simple and efficient way to check if a server is accepting new connections. A Layer 7 health check might make an HTTP request to the server and make sure the response is success (e.g. a 200 status code vs a 500 indicating internal failures or no response indicating a crash).
        -
- ### Load Balancing Algorithms
    - Several options are available with most load balancers:
    - **Round Robin**: Requests are distributed sequentially across servers
      collapsed:: true
        - Appropriate for most stateless applications
    - **Random**: Requests are distributed randomly across servers
      collapsed:: true
        - Appropriate for most stateless applications
    - **Least Connections**: Requests go to the server with the fewest active connections
      collapsed:: true
        - For services that require a persistent connection (e.g. those serving SSE or WebSocket connections)
            - because it avoids a situation where a single server gradually accumulates all of of the active connections.
    - **Least Response Time**: Requests go to the server with the fastest response time
    - **IP Hash**: Client IP determines which server receives the request (useful for session persistence)
- # Common Challenges
- ## Regionalization and Latency
    - For global services, you're typically going to have servers distributed across the world. And it does introduce new networking challenges.
    - The physical distance between clients and servers significantly impacts network latency. Speed of light limitations mean that a request from New York to London will always have higher latency than a request to a nearby server (<1ms vs >80ms).
      collapsed:: true
        - #+BEGIN_TIP
          Light travels through fiber optic cables at about 2/3 the speed of light in a vacuum, which is approximately 200,000 km/s. This means a round trip between New York and London (about 5,600 km) has a theoretical minimum latency of around 56ms just from the physics of signal propagation, before adding any processing time. This physical constraint is why geographic distribution is essential for low-latency applications.
          #+END_TIP
        -
    - In order to address this problem, we need to return to **[[data locality]]**. Across all of computing, we're going to have highest [[Performance]] when the data is as close as possible to the computations we need to do.
        - For a regional application, we want to try to keep all of the data we need to satisfy a query
            - (a) as close together, and
            - (b) as close to the user as possible.
- ### [[Content Delivery Networks]]
    - The most common strategy for reducing [[latency]] is to use a **Content Delivery Network (CDN)**. CDNs are networks of servers that are strategically located around the world. CDNs frequently boast hundreds or even thousands of different cities where they have servers
    - These servers make up what is commonly referred to as an "edge location". If that edge server can answer a user's request, the user is going to get lightning fast response times
    - In interviews, you'll see CDNs used frequently when we have data that is very cacheable (frequently accessed, updated not too frequently) and needs to be queried from across the globe.
- ### Regional partitioning
    - Another strategy common when we need to deal with regionalization is **regional partitioning**. If we have a lot of users in a single region, we can partition our data by region so that each region only has data relevant to it.
    - Take Uber for example. While on any given day we may have millions of riders and drivers, inside one particular city we may only have a few thousand. Our physical architecture and network topology can take advantage of this.
    - We can bundle together nearby cities into a single local region. Each region can have its own database hosted on distinct servers located in that geography. The servers handling requests can be co-located alongside the databases they need to query.
- ## Handling Failures and Fault modes
    - Network Failures are common and robust system design requires planning for these failures.
- ### Timeouts with retries and backoff
    - The most elementary hygiene for handling failures is to use timeouts and retries.
    - If we expect a request to take a certain amount of time, we can set a timeout and if the request takes too long we can give up and try again.
    - Retrying requests is a great strategy for dealing with transient failures.
    - Read more: [[Retries, Timeout and Exponential Backoff]]
    - #### Backoff
        - Retries can be a double-edged sword, though. If we have a lot of retries, we may be retrying requests that are going to fail over and over again. This can actually make the problem worse!
        - So instead of retrying immediately, we wait a short amount of time before retrying. If the request still fails, we wait a little longer. This gives the system time to recover and reduces the load on the system.
        - It's important there is some randomness to the backoff strategy (often called "jitter"). It doesn't help us to have all of our clients retry at the same time! The worst case would be having all our failing requests synchronize and retry at the same time over and over again.
    - #### Idempotency
        - Imagine a payment system where we're trying to charge a user $10 for something. If we retry the same request multiple times, we're going to charge the user $20 (or $2,000) instead of $10!
        - This is why we need to make sure our APIs are **idempotent**. [[Idempotent]] APIs are APIs that can be called multiple times and they produce the same result every time.
        - Read or HTTP GET API's are usually idempotent without any effort. But for write or POST/PUT/PATCH API's it's common for us to introduce an **idempotency key**. The idempotency key is a unique identifier for a request that we can use to make sure the same request is idempotent.
- ### [[Circuit Breaker]]
    - Used to prevent **cascading failures** in a system.
    - Usually, "retry and wait till it's available" works but can introduce new problems. For example, If your database has gone down cold and you need to boot it up one instance at a time, having a firehose of retries and angry users might pin down an instance from ever getting started.
    - The key is to familiarize yourself with scenarios where one failure might create new failures: a cascade of failures.
    - circuit breakers are a crucial pattern for robust system design that directly impacts network communication. **Circuit breakers protect your system when network calls to dependencies fail repeatedly**.
    - How they work:
        - The circuit breaker monitors for failures when calling external services
          logseq.order-list-type:: number
        - When failures exceed a threshold, the circuit "trips" to an open state
          logseq.order-list-type:: number
        - While open, requests immediately fail without attempting the actual call
          logseq.order-list-type:: number
        - After a timeout period, the circuit transitions to a "half-open" state
          logseq.order-list-type:: number
        - A test request determines whether to close the circuit or keep it open
          logseq.order-list-type:: number
    - This pattern, inspired by electrical circuit breakers, prevents cascading failures across distributed systems and gives failing services time to recover.
    - Circuit breakers provide numerous advantages:
    - Fail Fast: Quickly reject requests to failing services instead of waiting for timeouts
    - Reduce Load: Prevent overwhelming already struggling services with more requests
    - Self-Healing: Automatically test recovery without full traffic load
    - Improved User Experience: Provide fast fallbacks instead of hanging UI
    - System Stability: Prevent failures in one service from affecting the entire system
- #### Where to use it
    - External API calls to third-party services
    - Database connections and queries
    - Service-to-service communication in microservices
    - Resource-intensive operations that might time out
    - Any network call that could fail or become slow
    -