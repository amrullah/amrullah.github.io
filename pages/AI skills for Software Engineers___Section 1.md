public:: true

- # Foundations of Large Language Models
    - ## What are [[LLM]]s
        - Fundamentally a probability machine which predicts what word or token should come next in a sequence given all the words that came before.
    - ## Why "Large" and "Language" matter
        - **Large:** This refers to both, the scale of the model (hundreds of billions of internal parameters) and the scale of training data (a significant portion of public internet). These parameters capture tiny patterns in how words relate to concepts, grammar and ideas.
        - **Language:** The model's domain. It's trained to understand and generate human language in all forms, from prose and poetry to structured text like JSON and code like Python
        - **Model:** A mathematical representation of language.
    - ## What [[LLM]]s actually do
        - There are no special "reasoning" models triggered in an LLM when you ask it to write code or to answer a question or to summarize a document. These abilities emerge naturally from the core task of LLM, which is to predict statistically likely next token, learned across an enormous corpus of text.
        - LLMs are probabilistic, not deterministic. Which means it can be creative, flexible and generalizable across contexts. On the downside it can also "hallucinate", confidently generating garbage information that sounds plausible because it fits the statistical patterns.
    - ## Practical implications for engineers
        - **API Design:** When calling an LLM API, you control temperature and sampling parameters to tune now creative vs conservative the model is.
        - **Error handling:** You need to validate outputs because the hallucinations are a feature of the LLM architecture, not a bug.
        - **Cost:** Every token costs money. Understanding tokenization is essential for cost control.
        - **Latency:** Each token is generated one at a time. Understanding streaming enables responsive interfaces.
        - **Reliability:** Techniques like [[Retrieval Augmented Generation]] and structured prompting make systems more factual and predictable.
- # [[Tokens]] and [[Tokenization]]
    - Before LLM can process any text, it must convert that text into numbers. It does this by breaking the text into small chunks called tokens. A token can be a word, a part of a word, or even just a character or punctuation mark, depending on the tokenizer.
    - ## Why [[tokens]] instead of characters or words
        - Using individual characters is inefficient computationally and memory-wise, and using full words is inflexible as you would need a token for every possible word in existence, including the rare ones.
        - [[Tokenization]] finds the sweet spot by breaking text into meaningful subunits frequent enough to be efficient, but granular enough to handle any language.
    - ## Byte-pair encoding (BPE) algorithm
        - Most Modern tokenizers use Byte-pair encoding algorithm, which is as follows:
            - Start by treating every single character as it's own token
              logseq.order-list-type:: number
            - Analyze the text and find the most frequently occurring pair of adjacent tokens.
              logseq.order-list-type:: number
            - Merge that pair into single new token, adding it to the vocabulary.
              logseq.order-list-type:: number
            - Repeat thousands of times until the vocabulary reaches it's target size (typically 50,000 - 100,000 tokens).
              logseq.order-list-type:: number
        - For example, if the training text has many words like "the", "this", "that", "them", "they", "thing", the algorithm might:
            - Merge `t` and `h` into `th`.
            - Merge `th` and `e` into `the`.
            - Merge `i`, `n`, `g` into `ing`.
        - The result is an efficient vocabulary. Common words and sub-words like "the" or "ing" are single tokens, and flexible, handling rare words by composing them from smaller pieces.
    - ## How [[Tokenization]] affects cost and behavior
        - Understanding how [[LLMs]] process text is essential for optimizing both, performance and budget. [[Tokenization]] serves as the bridge between raw text and machine understanding, impacting your workflow in several key ways:
            - **Cost:** You pay per [[token]] , not per word. A 100 word might cost 120 tokens. Longer or more complex text (like code) tokenize less efficiently than English prose. Your billing depends on tokenization.
            - **Model Behavior:** Different [[LLMs]] use different tokenizers. The same prompt might tokenize into 50 tokens in one model and 75 tokens in another, affecting both, the cost and the model's ability to see the entire prompt in it's [[Context Window]].
            - **Non-obvious patterns:**
                - Punctuation and spacing are separate [[tokens]] . A comma costs the same as a word.
                - Code [[tokenizes]] poorly. 100 words of Python code might become 150 tokens because of symbols like `=`, `(`, `)`
                - Whitespace matters. A space before a word is often a separate token from the word itself.
                - Numbers are often split into digit tokens.
        - ### [[Token]] counting Rules of Thumb
            - For a quick estimate without running a tokenizer:
                - **English prose:** ~4 characters per token (1000 characters ≈ 250 tokens)
                - **Code:** ~3 characters per token (more symbols, less efficiency)
                - **Numbers:** Each digit is often a separate token
                - **Punctuation:** Each mark is usually it's own token
            - These rules are not exact, but they help you reason about cost and context usage quickly.
        - ### Different models have different tokenizers
            - GPT models use `cl100k_base` tokenizer. Claude uses a different, Llama yet another. Each model was trained with it's own tokenizer. And you must use the correct tokenizer to get the right token ids.
            - This matters for two reasons:
                - When estimating token counts for cost and context window calculations, you must use the tokenizer that matches your target model.
                - Same text will produce different token boundaries in different tokenizers, which can affect how the models "sees" the content. A word that becomes a single token in one tokenizer can be a three sub-word tokens in another, which can subtly change how the model weighs that word's meaning relative to the surrounding context.
        - ## Tokenizing in practice
            - Code Sample:
                - ```python
                  import tiktoken
                  
                  # Load the tokenizer for GPT-4 models
                  encoding = tiktoken.get_encoding("cl100k_base")
                  
                  # Tokenize a sample text
                  # this is a good practice in production: tokenize first -> then decide to send to LLM
                  tokens = encoding.encode("Tokenization is important")
                  print("Tokens:", tokens)
                  
                  text = encoding.decode([3404, 2065, 374, 3062])
                  print("Decoded text:", text)
                  
                  text_to_tokenize = "Tokenization is important for natural language processing."
                  # Tokenize the text 
                  tokens_length = len(encoding.encode(text_to_tokenize)) 
                  print(f"Number of tokens in the text: {tokens_length} for string length {len(text_to_tokenize)}, avg tokens per character: {len(text_to_tokenize)/tokens_length}")
                  ```
                    - {{evalparent}}
                    -
        - ## Practical implications for engineers
            - Understanding [[tokenization]] directly shapes cost, reliability and output quality of every [[LLM]] powered feature you ship.
                - **Cost forecasting:** You can estimate API costs by understanding [[Tokenization]] patterns before you ever make a call.
                  logseq.order-list-type:: number
                - **Context window management:** You know how much content fits in model's context in tokens, not  words
                  logseq.order-list-type:: number
                - **Prompt Engineering:** You optimize prompts knowing that redundant phrasing wastes tokens and budget
                  logseq.order-list-type:: number
                - **Multilingual systems:** Code and non-English text are tokenized differently, affecting both, cost and model [[Performance]]
                  logseq.order-list-type:: number
- # Context windows and their practical limits
    - The ** [[Context Window]] ** is the maximum number of tokens a model can process in a single request #definition
        - Everything a model "knows" about your problem, your instructions, your data and conversation history and it's own generated output must fit in the context window
    - ## Why context windows have a hard limit
        - The Transformer [[Architecture]] uses an operation called **self-attention** to let tokens communicate with each other. Self-attention has a quadratic cost, to compare N tokens with each other, it requires N^{2} comparisons
          id:: 6a7f0342-9f13-4267-969d-45c30d776508
            - #+BEGIN_TIP
              For example, for 1,000 Tokens will require 1,000,000 comparisons
              #+END_TIP
            - #+BEGIN_WARNING
               As the context window grows, compute and memory requirements grows quadratically. This creates a practical limit on how large a context window can be without becoming prohibitively expensive.
              #+END_WARNING
    - ## Context Window sizes across models
        - |Model|Context Size (in tokens)|Approximate Words|Notes|
          |--|--|--|--|
          |GPT-3.5|4k|~3000 words|Limited for Long documents|
          |GPT-4|8k or 128k|~6k or 96k words|128k version enables longer conversations|
          |Claude 3.5 [[Sonnet]]|200k|~150k words|Can work with entire codebases|
          |Llama 3.1|128k|~96k words|Open source option|
          |Gemini 1.5 Pro|1M|~750k words|Can effectively read entire books|
        - #+BEGIN_TIP
          Choosing the right context size for a task is therefore an active design decision not just a capability check. For a task that fits in 2000 tokens, there is no benefit in paying for a 200k context window. Conversely, a small context window forces you into chunking strategies that add latency and complexity. 
          #+END_TIP
    - ## What happens when you exceed the Context limit
        - One of the below may happen:
        - **Truncation:** The model may silently ignore the oldest tokens. Your instructions might be at the beginning of the context and if the window fills up with the conversation, your instructions get cut-off.
            - #+BEGIN_TIP
              Building context monitoring into your application is the only way to catch this before it affects the correctness or completeness of the LLM output
              #+END_TIP
        - **API Errors:** The LLM provider's API may return error instead of processing the request. This is more predictable failure mode, where you get a clear signal that something is wrong.
            - The harder scenario is where you are close to the Context Limit but not over it
        - **Degraded Output:** Even within limit, the model can struggle to "find" information that is buried in middle of a very long context. Research on this " [[lost-in-the-middle]] " phenomenon shows that model accuracy on retrieval tasks drops significantly for content positioned in the middle of a long context, even when the full content fits in the window.
            - #+BEGIN_TIP
              If your task requires a model to reliably reference a specific section, position it near the beginning or end of the context. or use RAG to retrieve only that section
              #+END_TIP
    - ## The Cost-Quality trade-off of long contexts
        - While larger context windows offer more contexts offer more flexibility, they also introduce several constraints that must be balanced
        - **Cost:** Larger Contexts cost more. Remember the quadratic cost of self-attention: ((6a7f0342-9f13-4267-969d-45c30d776508)). However, the actual cost depends on how providers price large contexts.
            - #+BEGIN_TIP
              In practice, you should benchmark real costs at your expected token volumes before committing to a large context approach in production
              #+END_TIP
        - **Latency:** Processing longer contexts takes more time. At 50,000 tokens of context, the time-to-first-token latency can be several seconds, noticeable to users in interactive applications.
            - #+BEGIN_TIP
              If you are building a real-time feature, you should prototype with your expected maximum context size and measure whether the latency remains acceptable before choosing an architecture that depends on large contexts.
              #+END_TIP
        - **Quality:** Research suggests that the model performs worse on reasoning tasks when the context is very long. This is called [[lost-in-the-middle]]
            - #+BEGIN_TIP
              Even if your content technically fits in the window, you may get better results by summarizing or chunking it, so the model reasons over a smaller, more focused set of information.
              #+END_TIP
    - ## Strategies for maintaining Context Limits
        - Context limits is a given. So the practical question to ask is:
          
          #+BEGIN_IMPORTANT
          What to do when your conversation, document or task exceeds the context limits?
          #+END_IMPORTANT
          
          There is no single correct answer. The below three strategies make a different trade-off between:
            - How much information you retain.
            - How much each call costs.
            - How much latency you add.
        - ### Sliding Window and Rolling Context
          logseq.order-list-type:: number
          id:: 6a96dbf4-0709-4fc7-9548-265f8bb39cd4
            - Keep a conversation going by maintaining only the most only the most recent messages. Summarize or discard old messages.
                - #+BEGIN_TIP
                  A bounded data structure like deque (double ended queue) may be helpful
                  #+END_TIP
                -
            - #+BEGIN_IMPORTANT
              **Trade off:** You lose information over time, but the conversation stays cheap and fast.
              #+END_IMPORTANT
            -
        - ### Summarization
          logseq.order-list-type:: number
            - Periodically summarize long documents or conversations into concise summary. The model reads summary instead of full text.
            - Summarization works best when the document has a natural executive summary structure, such as specifications, reports or meeting notes. It works less well for highly detailed technical content, where every sentence carries unique information like dense code or legal clauses.
            - #+BEGIN_IMPORTANT
              **Trade off:** You lose detail, but gain efficiency and reliability.
              #+END_IMPORTANT
            - #### Summarize intermediate work
              logseq.order-list-type:: number
              collapsed:: true
                - In multi-step workflows, each step typically produces output that becomes input to the next step. If you accumulate all the intermediate outputs verbatim, the context grows with each step and you will eventually exceed the window.
                - Instead, after each step completes, ask the model to distill the result into a compact summary or few bullet points, then pass only that summary forward. This keeps the context bounded, regardless of the number of steps, and often improves the final result because the model reasons over clean summaries rather than noisy intermediate text.
                - Examples:
                    - **Code review:** You want to review a 10,000 line Pull request. Instead of the full file, send the diffs plus related tests and function signatures. The model focuses on the changed code.
        - ### [[Retrieval Augmented Generation]] (RAG)
          logseq.order-list-type:: number
            - Instead of putting all the data in the context, retrieve only the most relevant chunks.  The idea is:
                - User asks a question.
                  logseq.order-list-type:: number
                - System retrieves the 3-5 most relevant document sections
                  logseq.order-list-type:: number
                - Model receives: ^^system prompt + question + retrieved sections^^
                  logseq.order-list-type:: number
            - Diagram
              collapsed:: true
                - {{renderer :drawio, 1786725162084.svg}}
            - This keeps context bounded while giving the model access to a much larger knowledge base.
                - Instead of hoping the model finds the right information in in a sea of tokens, you use similarity search to pre-select the relevant content and pass only that to the model.
            - The retrieval step is what makes [[RAG]] powerful. Good RAG systems invest heavily in retrieval accuracy, embedding quality, chunking strategy and re-ranking, before tuning the generation side.
    - ## Measuring Context Usage
        - When you call an LLM API, the response includes token usage. Track this to understand how close you are to the limit and forecast costs.
        - Code Sample:
            - ```python
              from openai import OpenAI
              from dotenv import load_dotenv
              
              load_dotenv()
              
              client = OpenAI()
              
              #  In a real application, it would include your system prompt and any conversation history
              response = client.chat.completions.create(
                  model="gpt-4o",
                  messages=[{"role": "user", "content": "Explain context windows in one paragraph."}],
              )
              
              
              
              # covers everything you sent (system prompts + messages + any function definitions)
              print(f'Prompt tokens: {response.usage.prompt_tokens}')
              
              # covers only the generated response
              print(f'Completion tokens: {response.usage.completion_tokens}')
              
              # The sum of above two, and it determines the bill for this LLM api call
              print(f'Total tokens: {response.usage.total_tokens}')
              
              context_limit = 128000  # gpt-4o
              pct = response.usage.prompt_tokens / context_limit * 100
              # percentage of context window used by the prompt's tokens. Good idea to log this in production
              print(f"Context used just in the prompt: {pct:.1f}%")
              ```
                - {{evalparent}}
-