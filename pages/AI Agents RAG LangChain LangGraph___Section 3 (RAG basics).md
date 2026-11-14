# RAG overview
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