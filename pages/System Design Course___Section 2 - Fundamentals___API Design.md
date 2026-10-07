
public:: true
- # API Design Principles
    - **Design around resources, not actions.**
      logseq.order-list-type:: number
      collapsed:: true
        - change `/processPayment` to `POST /payments`
    - **Be consistent everywhere.**
      logseq.order-list-type:: number
      collapsed:: true
        - Same naming conventions, same parameter names, same response shapes across every endpoint.
    - **Follow the principle of least surprise**
      logseq.order-list-type:: number
      collapsed:: true
        - Follow well known REST conventions. For example avoid a `200 OK` response with a `{"success": false}` or a `GET` request that changes data.
    - **Keep the API stateless**
      logseq.order-list-type:: number
      collapsed:: true
        - Each request should carry everything the server needs to process it: the auth token, the parameters, the payload. When no server has to remember anything about previous requests, any server can handle any request, and horizontal scaling becomes a lot easier
    - **Make retries safe**
      logseq.order-list-type:: number
      collapsed:: true
        - Networks fail mid-request, and the client has no idea whether the server did the work before things fell apart. Its only option is to retry, so design your API so retries are harmless.
    - **Paginate anything that can grow.**
      logseq.order-list-type:: number
      collapsed:: true
        - Every collection endpoint gets pagination from day one, along with a cap on page size so a client can't ask for ?limit=100000 and take down your database.
    - **Secure every endpoint by default**
      logseq.order-list-type:: number
      collapsed:: true
        - Every endpoint requires a valid token unless you deliberately mark it public, and authorization confirms the caller can act on this specific resource (John can cancel his own bookings, not everyone's)
    - **Evolve without breaking clients**
      logseq.order-list-type:: number
      collapsed:: true
        - Old mobile app versions stick around for years. Adding a new field is safe, but renaming, removing, or changing the meaning of an existing one is a breaking change that needs a versioning story.
    - **Make errors actionable**
      logseq.order-list-type:: number
      collapsed:: true
        - A good error response tells the client what went wrong and what to do about it. That means the right status code class (4xx for "you messed up," 5xx for "we messed up") plus a machine-readable error code and a human-readable message in the body.
- # Common API Patterns
- ## Pagination
- ### Offset-based Pagination
    - `/events?offset=20&limit=10`
    - simple and easy to implement
    - If new data is created while you're paginating through results, you might see duplicates or miss records as the data shifts.
- ### Cursor-based Pagination
    - ```
      {
        "events": [...],
        "next_cursor": "cmd93ifnt30rfjvemfdsc"
      }
      ```
    - The cursor is typically an encoded reference to a specific record (like an ID or timestamp). This is more stable because it's not affected by new records being added, but it's harder to implement features like "jump to page 5."
- ## Idempotency key
    - ```
      curl https://api.stripe.com/v1/customers \
        -u sk_test_some_long_random_alphabets \
        -H "Idempotency-Key: KG5LxwFBepaKHyUD" \
        -d description="My First Test Customer (created for API docs at https://docs.stripe.com/api)"
      ```
- ## Consistent Error shape
    - ```
      {
        "error": {
          "code": "STATUS_FOR_FRONTEND_CODE",
          "message": "Hey human, this message is for you to lament about"
        }
      }
      ```
- ## Versioning strategies
    - APIs evolve over time, and you need a strategy for handling changes without breaking existing clients. This is particularly important for public APIs where you can't control when clients update their code.
    - The most common wa**url versioning** (`/v1/resource`) and **Header versioning ** (`Accept-Version: v2`)
- # Security Considerations
- ## Authentication and Authorization
    - > Who is making this request? And are they allowed to do what they are requesting to?
- ### API Keys vs JWT Tokens
    - > Use JWT tokens for user sessions in web/mobile applications as they can carry user context and be stateless. Use API keys for internal service communication and external developer access.
- #### API Keys
    - ```
      GET /events
      Authorization: Bearer sk_live_abc123...
      ```
    - Good for Server to Server communication apparently... #intriguing
- #### [[JWT]]
    - JWT tokens, encode user information directly into the token itself rather than storing session state on your server
    - The token itself carries all the context you need to authorize the request.
    - JWTs work particularly well for distributed systems because any service with access to the verification key can validate tokens independently
- ### Role-based Access Control (RBAC)
    - ```
      GET /bookings/{id}
      1. Is the user authenticated? (valid JWT token)
      2. Is the user authorized? (owns this booking OR is admin)
      ```
- ## [[Rate Limiting]] and Throttling
    - Rate Limiting is crucial to avoid overloading the systems, both malicious and non-malicious.
    - Common strategies include:
        - **Per user limits:** X requests per unit time per authenticated user
        - **Per-IP limits:** X requests per unit time for unauthenticated user
        - **Endpoint specific limits:** X bids allowed per minute overall.
    - Rate limiting is typically implemented at [[API Gateway]] level or at middleware level in your backend application
    - When limits are exceeded, return a `429 Too Many Requests` status code.
    -
    -
    -