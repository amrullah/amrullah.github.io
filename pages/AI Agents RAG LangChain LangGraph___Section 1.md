public:: true
filters:: {"templates" false}
title:: 
alias::
tags::

- # LangChain Foundations
- ## The Langchain Ecosystem
- ### Core packages
    - |Package|Description|
      |--|--|
      |`langchain-core`|Core abstractions and LCEL|
      |`langchain`|Agents, chains and high-level API's|
      |`langgraph`|Stateful Agent Orchestration|
      |`langsmith`|Tracing, evaluation, monitoring|
      |`langserve`|Deploy as REST API's|
- ### Integration Packages
    - |Package|Description|
      |--|--|
      |`langchain-openai`|OpenAI Integration|
      |`langchain-anthropic`|Anthropic / Claude Integration|
      |`langchain-community`|Community Integrations|
- ## When to use what
    - |Component|Use When...|
      |--|--|
      | [[LangChain]] |Building chains, RAG, quick prototypes|
      | [[LangGraph]] |Stateful Agents, Loops, Multi-Agent, production|
      |LangSmith|Debugging, Monitoring, Evaluation|
      |LangServe|Deploy workflows as API's|
- ## Why enterprises prefer LangChain
    - **Vendor agnostic**
        - Swap between OpenAI, Anthropic, Ollama easily
    - **LangSmith**
        - Compliance and [[Auditability]]
    - **[[LangGraph]]**
        - Durable, Resumable workflows
    - **Community**
        - Active community, strong support
- ## Architecture
    - **Comprised of these layers:**
        - > **Your Application**
        - > **Chains and Agents**
          langchain
        - > **LCEL**
          Langchain Expression Language
        - collapsed:: true
          > **Runnables**
          langchain-core
            - Foundation of everything in [[LangChain]] and above
            -
        - > **Model Integrations**
          langchain-openai, langchain-anthropic etc.
    - Runnable methods:
        - ```
          invoke() | batch() | stream() | ainvoke()
          ```
            - pipe syntax allows chaining various functions, to create complex Runnables
- ## Runnables - The foundation
    - Everything in [[LangChain]] V.1 is a Runnable
    - This includes:
        - Prompts
        - Models
        - Output Parsers
        - Chains (composite runnables)
    - At the central of [[LangChain]], we have Unified interface comprising of :
        - `invoke()`
        - `batch()`
        - `stream()`
- ## Some available models as of 2026
    - |Provider|Model|Best for|
      |--|--|--|
      |[[OpenAI]]|[[gpt-4o]]|Flagship, balanced|
      |[[OpenAI]]|[[gpt-4o-mini]]|Fast, cheap|
      |[[OpenAI]]|[[gpt-5.2]]|400k context, latest|
      |[[Anthropic]]| [[claude-opus-4-5]] |Deep Reasoning|
      |[[Anthropic]]| [[claude-sonnet-4-5]] |Balanced|
      |[[Anthropic]]| [[claude-haiku-3-5]] |Fast, cheap|
      |[[Ollama]]|[[llama]], [[mistral]]|Local, free|
- ## Model configuration strategies
    - some parameters you can provide to `init_chat_models` or `ChatOpenAI` etc:
        - **temperature**
            - is a decoding parameter that controls randomness in text generation: low values (≈0.0-0.4) make output focused and deterministic, while high values (≈0.7–1.0) make it more diverse and creative.
              collapsed:: true
                - **Low temperature (<1)** → sharper distribution → predictable, factual, consistent.
                - **High temperature (>1)** → flatter distribution → varied, creative, sometimes incoherent.
        - **max_tokens**
          id:: 6a9be988-ed45-4c90-9de5-2b865b82cf87
            - Maximum output length
                - one of the key factors in determining LLM request cost
        - **timeout**
            - Request timeout
        - **max_retries**
            - Retry on failure
                - handle transient errors
        - **model_kwargs**
            - provider specific parameters
    - Code Example:
      collapsed:: true
        - ```python
          from langchain_anthropic import ChatAnthropic
          
          model = ChatAnthropic(model='claude-sonnet-4-5-20250929',
                               temperature=0.7, max_tokens=1500,
                               timeout=30, max_retries=3)
          ```
        -
- ## Streaming Responses
  collapsed:: true
    - **Benefits**
        - Immediate Feedback
        - Better UX
        - Early termination
- ## Cost optimization
    - Use a combination of these strategies
    - ### Choose the right model
        - Example:
            - [[gpt-4o-mini]]: $0.15/1M [[tokens]]
              [[gpt-4o]]: $2.5/1M tokens [[tokens]]
              ^^17x cost difference^^
    - ### Limit output tokens
        - Use ((6a9be988-ed45-4c90-9de5-2b865b82cf87)) to control response length and cost
    - ### Use caching
        - [[Cache]] identical requests with `InMemoryCache` / `sqlite` / [[Redis]] / Database
- ## Message types
    - #### SystemMessage
        - A **SystemMessage** is used to **prime the AI model** with instructions that guide its overall behavior, tone, and persona before any user interaction occurs.
            - For example, you can instruct the AI to act as a senior Python developer, provide concise explanations, or adopt a specific style of communication.
        - System messages are processed with **higher priority than user input**, meaning the AI follows these instructions while responding to all subsequent messages
    - #### HumanMessage
        - A **HumanMessage** represents the **user's input**—what the user types, speaks, or submits to the AI. It does not define how the AI should behave; instead, it tells the AI **what to respond to**.
        - Human messages are the primary input signal for the model and are essential for maintaining conversation context.
        - When combined with `AIMessage` objects, they allow the AI to remember previous interactions and provide coherent multi-turn responses
    - #### AIMessage
        - An `AIMessage` is returned from a chat model as a response to a prompt.
        - This message represents the output of the model and consists of both the raw output as returned by the model and standardized fields (e.g., tool calls, usage metadata) added by the [[LangChain]] framework.
    - Also see: ((6a96dbf4-0709-4fc7-9548-265f8bb39cd4))
- ## Code Examples
    - **Testing Basic Integration with OpenAI and Anthropic**
        - Code: [Sample request to OpenAI and Anthropic to test integration, account s… · amrullah/ai_agents_with_langgraph@01315f2](https://github.com/amrullah/ai_agents_with_langgraph/commit/01315f20c419e7283f1dd120ff13af3d293ce7f6#diff-b10564ab7d2c520cdd0243874879fb0a782862c3c902ab535faabe57d5a505e1)
        - Output:
          collapsed:: true
            - ```
              (ai_agents_with_langgraph) amrullah@Amrullahhpob3:~/Developer/ai_agents_with_langgraph$ uv run main.py
              Langchain Core:  1.6.1
              LangGraph:  1.2.11
              OpenAI response: content='Ready!' additional_kwargs={'refusal': None} response_metadata={'token_usage': 
              {'completion_tokens': 2, 'prompt_tokens': 15, 'total_tokens': 17, 'completion_tokens_details': 
              {'accepted_prediction_tokens': 0, 'audio_tokens': 0, 'reasoning_tokens': 0, 'rejected_prediction_tokens': 0, 'text_tokens': None}, 
              'prompt_tokens_details': {'audio_tokens': 0, 'cache_write_tokens': None, 'cached_tokens': 0, 'image_tokens': None, 'text_tokens': None}}, 
              'model_provider': 'openai', 'model_name': 'gpt-4o-mini-2024-07-18', 'system_fingerprint': '<redacted>', 'id': '<redacted>', 
              'service_tier': 'default', 'finish_reason': 'stop', 'logprobs': None} id='<redacted>' tool_calls=[] invalid_tool_calls=[] 
              usage_metadata={'input_tokens': 15, 'output_tokens': 2, 'total_tokens': 17, 'input_token_details': {'audio': 0, 'cache_read': 0}, 
              'output_token_details': {'audio': 0, 'reasoning': 0}}
              Anthropic response: content='Setup complete!' additional_kwargs={} response_metadata={'id': '<redacted>', 'container': None, 
              'model': 'claude-sonnet-4-5-20250929', 'stop_details': None, 'stop_reason': 'end_turn', 'stop_sequence': None, 
              'usage': {'cache_creation': {'ephemeral_1h_input_tokens': 0, 'ephemeral_5m_input_tokens': 0}, 'cache_creation_input_tokens': 0, 
              'cache_read_input_tokens': 0, 'inference_geo': 'not_available', 'input_tokens': 16, 'output_tokens': 6, 'output_tokens_details': None, 
              'server_tool_use': None, 'service_tier': 'standard'}, 'model_name': 'claude-sonnet-4-5-20250929', 'model_provider': 'anthropic'} id='<redacted>' 
              tool_calls=[] invalid_tool_calls=[] usage_metadata={'input_tokens': 16, 'output_tokens': 6, 'total_tokens': 22, 
              'input_token_details': {'cache_read': 0, 'cache_creation': 0, 'ephemeral_5m_input_tokens': 0, 'ephemeral_1h_input_tokens': 0}}
              setup complete!
              ```
    - **Basic Chain using Runnables**
        - Key method: `chain.invoke()`
        - Code: [Basic chain demo, composed of a prompt, model and output parser · amrullah/ai_agents_with_langgraph@670aac7](https://github.com/amrullah/ai_agents_with_langgraph/commit/670aac7becbd9300ced94ce317c21f5c9ab70dc5#diff-a3fcb3160c49321179c69749b909ae4b5040717a694cff0c36f66713b9df0d3c)
        - Output:
          collapsed:: true
            - ```
              (ai_agents_with_langgraph) amrullah@Amrullahhpob3:~/Developer/ai_agents_with_langgraph$ uv run src/ai_agents_with_langgraph/core_concepts.py 
              Response: LangChain is a framework designed to facilitate the development of applications that use language models by providing tools and abstractions 
              for chaining together different components and managing data flow.
              ```
    - **Batch execution**
        - Key method: `chain.batch()`
        - Code: [batch execution · amrullah/ai_agents_with_langgraph@e631886](https://github.com/amrullah/ai_agents_with_langgraph/commit/e631886df6345b6568dbc231db6e2291851f44ed)
        - Output:
          collapsed:: true
            - ```
              text: {'text': 'Hello, how are you?'} => Result: Bonjour, comment ça va ?
              text: {'text': 'What is your name?'} => Result: The translation of "What is your name?" in French is "Comment vous appelez-vous ?" or simply "Tu t'appelles comment ?" depending on the level of formality.
              ```
    - **Streaming output**
        - Key method: `chain.stream()`
        - Code: [streaming output demo · amrullah/ai_agents_with_langgraph@a30c4c9](https://github.com/amrullah/ai_agents_with_langgraph/commit/a30c4c98e74f62331f01c4c63a7a6d4d68a8d36f)
        - Output:
          collapsed:: true
            - ```
              amrullah@Amrullahhpob3:~/Developer/ai_agents_with_langgraph$ uv run src/ai_agents_with_langgraph/core_concepts.py
              Whispers through the trees,  
              Sunlight dances on the brook,  
              Nature's breath in peace.
              ```
    - **Chain schema inspection**
        - Code: [chain schema inspection · amrullah/ai_agents_with_langgraph@db3987d](https://github.com/amrullah/ai_agents_with_langgraph/commit/db3987d33e3ac64dbb366ad0590f8e49aa4c6374)
        - Output:
          collapsed:: true
            - ```
              (ai_agents_with_langgraph) amrullah@Amrullahhpob3:~/Developer/ai_agents_with_langgraph$ uv run src/ai_agents_with_langgraph/core_concepts.py 
              input_schema: {'properties': {'topic': {'title': 'Topic', 'type': 'string'}}, 'required': ['topic'], 'title': 'PromptInput', 'type': 'object'}
              output_schema: {'title': 'StrOutputParserOutput', 'type': 'string'}
              ```
    - **Message Types**
        - Code:
        - Output:
          collapsed:: true
            - ```
              (ai_agents_with_langgraph) amrullah@Amrullahhpob3:~/Developer/ai_agents_with_langgraph$ uv run src/ai_agents_with_langgraph/core_concepts.py 
              ai_message object 
              content="Arrr, matey! I be unable to tell ye the weather today, for me crystal ball be foggy and me compass be pointin' to the past! 
              But ye can check yer trusty weather map or ask a landlubber for the latest forecast. Fair winds and a sunny sky to ye!" 
              additional_kwargs={'refusal': None} 
              response_metadata={'token_usage': {'completion_tokens': 62, 'prompt_tokens': 28, 'total_tokens': 90, 
              'completion_tokens_details': {'accepted_prediction_tokens': 0, 'audio_tokens': 0, 'reasoning_tokens': 0, 'rejected_prediction_tokens': 0, 'text_tokens': None}, 
              'prompt_tokens_details': {'audio_tokens': 0, 'cache_write_tokens': None, 'cached_tokens': 0, 'image_tokens': None, 'text_tokens': None}}, 
              'model_provider': 'openai', 'model_name': 'gpt-4o-mini-2024-07-18', 'system_fingerprint': '<redacted>', 'id': '<redacted>', 'service_tier': 'default', 'finish_reason': 'stop', 'logprobs': None} 
              id='<redacted>' tool_calls=[] invalid_tool_calls=[] 
              usage_metadata={'input_tokens': 28, 'output_tokens': 62, 'total_tokens': 90, 'input_token_details': {'audio': 0, 'cache_read': 0}, 
              'output_token_details': {'audio': 0, 'reasoning': 0}}
              
              Response from the Pirate: Arrr, matey! I be unable to tell ye the weather today, for me crystal ball be foggy and me compass be pointin' to the past! 
              But ye can check yer trusty weather map or ask a landlubber for the latest forecast. Fair winds and a sunny sky to ye!
              
              Multi-turn conversation:
              Follow-up response from the Pirate: Arrr, I still can’t see into the morrow, me hearty! 
              The winds of fate be too fickle for a pirate like meself to predict. 
              Best ye consult the weather gods or a landlubber’s forecast for what the skies hold for ye tomorrow. May the sun shine bright on yer sails!
              ```