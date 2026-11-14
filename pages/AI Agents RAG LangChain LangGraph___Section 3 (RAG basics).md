public:: true

- # RAG overview
- ## What is RAG
- ### [[LLM]]'s and Data
    - Training cutoff date
    - No access to private data
    - Hallucination risk
- ### [[Retrieval Augmented Generation]]
    - **Traditional LLM**
        - <div style="display: flex;"> 
          <div style="border: 1px solid var(--ls-primary-text-color); padding: 5px;"> <span style="font-weight: bold;"> <br />User Question</span> </div> 
          <div style="padding: 20px; font-size: 25px;"> → </div> 
          <div style="border: 1px solid var(--ls-primary-text-color); padding: 5px;"> <span style="font-weight: bold;"> <br />LLM</span></div>
          <div style="padding: 20px; font-size: 25px;"> → </div> 
          <div style="border: 1px solid var(--ls-primary-text-color); padding: 5px;"> <span style="font-weight: bold;"><br /> Answer</span><br /> (limited knowledge)</div>
          </div>
        -
    - **[[RAG]] System**
        - <div style="display: flex;"> 
          <div style="border: 1px solid var(--ls-primary-text-color); padding: 5px;"> <span style="font-weight: bold;"> <br />User Question</span> </div> 
          <div style="padding: 20px; font-size: 25px;"> → </div> 
          <div style="border: 1px solid var(--ls-primary-text-color); padding: 5px;">  <br />Retrieve Relevant Docs </div>
          <div style="padding: 20px; "> <span>docs</span> <br /> <span style="font-size: 25px;">→</span> </div> 
          <div style="border: 1px solid var(--ls-primary-text-color); padding: 5px;"> <span style="font-weight: bold;"> <br />LLM</span> <br /> (with retrieved docs)</div>
          <div style="padding: 20px; font-size: 25px;"> → </div> 
          <div style="border: 1px solid var(--ls-primary-text-color); padding: 5px;"> <span style="font-weight: bold;"><br /> Answer</span><br /> (with better context)</div>
          </div>
    - > **Key Idea**
      > Give LLM the information it needs **before** it answers.
- ## RAG Architecture break-down
    - **Indexing**
        - one-time setup or whenever the source data changes
        - <div style="display: flex;"> 
          <div style="border: 1px solid var(--ls-primary-text-color); padding: 5px;"> <br /> Documents</div> 
          <div style="padding: 20px; font-size: 25px;"> → </div> 
          <div style="border: 1px solid var(--ls-primary-text-color); padding: 5px;"> <br /> Chunks</div>
          <div style="padding: 20px; font-size: 25px;"> → </div> 
          <div style="border: 1px solid var(--ls-primary-text-color); padding: 5px;"> <br /> Embeddings <br /> (with [[Embedding Model]] )</div>
          <div style="padding: 20px; font-size: 25px;"> → </div> 
          <div style="border: 1px solid var(--ls-primary-text-color); padding: 5px;"> <br /> Vector DB</div>
          </div>
    - **Retrieval**
        - per query
        - <div style="display: flex;"> 
          <div style="border: 1px solid var(--ls-primary-text-color); padding: 5px;"> <br /> Question</div> 
          <div style="padding: 20px; font-size: 25px;"> → </div> 
          <div style="border: 1px solid var(--ls-primary-text-color); padding: 5px;"> <br /> Embedding</div>
          <div style="padding: 20px; font-size: 25px;"> → </div> 
          <div style="border: 1px solid var(--ls-primary-text-color); padding: 5px;"> <br /> Similarity Search</div>
          <div style="padding: 20px; font-size: 25px;"> → </div> 
          <div style="border: 2px solid var(--ls-primary-text-color); padding: 5px;"> <br /> Relevant chunks</div>
          </div>
    - **Generation**
        - <div style="display: flex;"> 
          <div style="border: 1px solid var(--ls-primary-text-color); padding: 5px;"> <br /> Question</div> 
          <div style="padding: 20px; font-size: 25px;"> → </div> 
          <div style="border: 1px solid var(--ls-primary-text-color); padding: 5px;"> <br /> Context<br /> (with relevant chunks) </div>
          <div style="padding: 20px; font-size: 25px;"> → </div> 
          <div style="border: 1px solid var(--ls-primary-text-color); padding: 5px;"> <br /> LLM</div>
          <div style="padding: 20px; font-size: 25px;"> → </div> 
          <div style="border: 2px solid var(--ls-primary-text-color); padding: 5px;"> <br />Answer </div>
          </div>
- ## Indexing - [[Chunking]]
    - Dividing large docs into smaller **semantically** coherent pieces that:
        - Fit within embedding model token limits
        - Contain complete thoughts or concepts
        - maintain enough context to be understood **independently**
        - Optimized for storage and retrieval
- ### Why [[Chunking]] matters?
    - Large Documents (1000's of pages) hard for LLM's to digest and keep full context.
    - [[Embedding Models]] have Token limits.
- ## Why [[RAG]] beats alternatives
    - |Approach|Pros|Cons|
      |--|--|--|
      |Fine-Tuning|Deep customization|Expensive, Slow, requires ML Expertise|
      |Prompt Engineering|Free, Fast|Limited by [[Context Window]]|
      |RAG|Best of Both worlds|Requires [[Vector DB]] setup|
- ### [[RAG]] Advantages
    - Up-to-date
    - Transparent
      collapsed:: true
        - See which docs were used
    - Cost-effective
      collapsed:: true
        - no LLM retraining
    - Accurate
      collapsed:: true
        - Grounded in real sources
        -
    - Scalable
      collapsed:: true
        - Millions of Documents
        -
- # Vectors and Embeddings
- ## Vectors
    - In Maths, it consists of `Magnitude` and `Direction`
    - But a simpler mental model is to think of these as something similar to GPS co-ordinates, which tells you where you are in co-ordinate space
    - Vectors can operate in 2D (eg. `[3, 4]`), 3D (eg. `[3, 4, 5]`) or in case of AI vectors (`[0.3, -0.45 ......, 0.12]`), can have 1000+ dimensions! Each dimension represents meaning and nuance (or features, in general)
    - Vectors that are close together, represent similar concepts. Or similar **Semantic Meaning**.
    - Distance = Similarity score
        - Cosine Similarity
            - Measures the angle between vectors
        - Euclidean distance
            - Straight line distance between points
            - `numpy.linalg.norm()`
    - An [[Embedding Model]] converts text into vectors that capture semantic meaning.
        - So similar words like King and Queen will have closer vector embedding than, say Cat.
        - Also, sentences about a same word (say pizza) will be closer than two completely unrelated sentences.
- ## Embeddings
- ## Code Examples
    - **Basic**
        - Code: [simple embedding demo using OpenAIEmbeddings · amrullah/ai_agents_with_langgraph@85b36f7](https://github.com/amrullah/ai_agents_with_langgraph/commit/85b36f76fbf95559ad506de1308c25f1a2fd054b)
        - Output:
          collapsed:: true
            - ```
              $ uv run src/ai_agents_with_langgraph/04_embeddings.py 
              Embedding for single text: [0.03179931640625, 0.030120849609375, 0.026702880859375, -0.0007853507995605469, -0.0255584716796875, -0.05828857421875, 0.0095367431640625, -0.0292205810546875, -0.006450653076171875, -0.01152801513671875]
              
              1536
              ```
        - Code: [basic embedding to display euclidean norm · amrullah/ai_agents_with_langgraph@204e778](https://github.com/amrullah/ai_agents_with_langgraph/commit/204e778a5b4f96032f9c5b93909b52f7be44ce37)
        - Output:
          collapsed:: true
            - ```
              $ uv run src/ai_agents_with_langgraph/04_embeddings.py 
              Vector dimensions: 1536
              First 5 values: [-0.016143798828125, -0.00707244873046875, -0.0244598388671875, -0.044342041015625, 0.02801513671875]
              Vector norm: 1.0001
              ```
    - **Batch embeddings**
        - Code: [basic embeddings batch · amrullah/ai_agents_with_langgraph@ac34b6f](https://github.com/amrullah/ai_agents_with_langgraph/commit/ac34b6fe6f4f2d16a0a75318d4b4c587d080e4d8)
        - Output:
          collapsed:: true
            - ```
              $ uv run src/ai_agents_with_langgraph/04_embeddings.py 
              Text 1 - Vector dimensions: 1536
              Text 1 - First 5 values: [-0.0161895751953125, -0.007083892822265625, -0.0244903564453125, -0.044403076171875, 0.028045654296875]
              Text 1 - Vector norm: 1.0002
              Text 2 - Vector dimensions: 1536
              Text 2 - First 5 values: [-0.01216888427734375, -0.0308837890625, -0.01366424560546875, -0.021240234375, 0.006923675537109375]
              Text 2 - Vector norm: 0.9999
              Text 3 - Vector dimensions: 1536
              Text 3 - First 5 values: [-0.04400634765625, -0.01519012451171875, -0.0012140274047851562, -0.006343841552734375, 0.021240234375]
              Text 3 - Vector norm: 0.9997
              ```
    - **Similarity Search**
        - Code: [cosine similarity search · amrullah/ai_agents_with_langgraph@f63dc57](https://github.com/amrullah/ai_agents_with_langgraph/commit/f63dc57461f73e3f8cd4f04c5c0a1790e612c547)
        - Output:
          collapsed:: true
            - ```
              $ uv run src/ai_agents_with_langgraph/04_embeddings.py 
              Query: What programming languages exist?
              
              Ranked by similarity:
                0.4427: Python is a programming language
                0.3660: JavaScript is used for web development
                0.1625: Machine learning enables AI applications
                0.1274: Deep learning uses neural networks
                0.1144: Cats are popular pets
              ```
    - **Embeddings Caching**
        - Code: [embeddings caching · amrullah/ai_agents_with_langgraph@6a5b7d0](https://github.com/amrullah/ai_agents_with_langgraph/commit/6a5b7d0fca4e1a38df4ee1aa437a0b7547f435ad)
        - Output:
          collapsed:: true
            - ```
              First call (API):
                Embedded 1 documents
              
              Second call (Cache):
                Embedded 1 documents
              
              Same vectors: True
              ```
- ## Vector store architecture
    - <div style="display: flex;"> 
      <div style="border: 1px solid var(--ls-primary-text-color); padding: 5px;"> <span style="font-weight: bold;">Documents</span> <br /> Text chunks</div> 
      <div style="padding: 20px; font-size: 25px;"> → </div> 
      <div style="border: 1px solid var(--ls-primary-text-color); padding: 5px;"> <span style="font-weight: bold;">Embeddings</span><br /> vectors</div>
      <div style="padding: 20px; font-size: 25px;"> → </div> 
      <div style="border: 1px solid var(--ls-primary-text-color); padding: 5px;"> <span style="font-weight: bold;">Vector Store</span><br /> indexed</div>
      </div>
    - <div style="display: block; text-align: center;"> 
      <div style="border: 1px solid var(--ls-primary-text-color); padding: 10px;  margin 0px;"> <span style="font-weight: bold;">similarity_search(query)</span></div> 
      <div style="padding: 5px; font-size: 25px; margin-top: -20px; margin-bottom: -20px;"> ↓ </div> 
      <div style="border: 1px solid var(--ls-primary-text-color); padding: 10px; "> <span style="font-weight: bold;">Relevant Documents</span><br /> <span style="font-size: 20px;">🗏</span> Doc 1, <span style="font-size: 20px;">🗏</span> Doc 2, ...</div>
      </div>
    -