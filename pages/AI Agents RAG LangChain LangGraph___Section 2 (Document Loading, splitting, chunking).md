public:: true

- # Document Loaders
- ## Core Document Loaders
  collapsed:: true
    - PyPDFLoader
    - TextLoader
    - DirectoryLoader
    - WebBaseLoader
    - UnstructuredLoader
    - For a more updated list: [Document loader integrations - Docs by LangChain](https://docs.langchain.com/oss/python/integrations/document_loaders#common-file-types)
- ## PDF loading options (from Langchain community)
    - `PyPDFLoader`
        - Fast, Basic extraction
        - Speed: fast
        - Metadata: basic
    - `PyMuPDFLoader`
        - Fastest, good metadata
        - Speed: Best
        - Metadata: Rich
    - `UnstructuredPDFLoader`
        - Slow, Best for complex layouts
        - Speed: Slow
        - Metadata: Detailed
        - > This is a paid offering (but has a generous free tier) from https://unstructured.io
- ## PDF Loading options
- ### Core Positioning and Trade-offs at a Glance
    - | Tool | Core Positioning | Key Advantages | Main Limitations / Considerations |
      | ---- | ---- | ---- |
      | **MinerU** | Heavyweight document parsing engine (layout analysis + OCR) | Extremely powerful, handles complex layouts, formulas, tables, scans well; high benchmark scores (OmniDocBench 86-90+) [](https://pypi.org/project/mineru/3.0.9/#1)[](https://newreleases.io/project/github/opendatalab/MinerU/release/mineru-3.3.1-released#1) | Heavy dependencies, high resource consumption (16GB+ RAM recommended, 20GB+ disk); first run slow |
      | **OpenDataLoader PDF** | Deterministic parsing, optional hybrid AI mode | Claims top overall accuracy in its benchmark (0.907 hybrid); local CPU deterministic mode is very fast (0.015s/page) [](https://pypi.org/project/mercupdf/0.1.0/#1)[](https://pypi.org/project/opendataloader-pdf/2.0.1/#2) | Best performance requires enabling hybrid mode (extra backend); default deterministic mode has average table accuracy (0.489) [](https://pypi.org/project/mercupdf/0.1.0/#1) |
      | **pdfmuse** | Fast, deterministic RAG pre-processing layer (Rust core) | Extremely fast (claims 4-6× faster than PyMuPDF); no ML dependencies; output byte-identical across bindings [](https://pypi.org/project/pdfmuse/0.1.1/#files#1)[](https://pypi.org/project/pdfmuse/0.1.9/#1) | **Does not perform OCR or complex layout inference**; scanned pages are only flagged, requiring you to connect your own OCR backend [](https://pypi.org/project/pdfmuse/0.1.1/#files#1) |
      | **pdf-inspector** | Rapid triage and extraction (Rust from Firecrawl) | Extremely fast (50ms classification, ~200ms extraction); no OCR; clean Markdown output [](https://stackmap.shipwithai.xyz/alternatives/opendataloader-pdf)[](https://stackmap.shipwithai.xyz/alternatives/pdf-inspector) | Primarily suited for digital-native PDFs; relies on external OCR for complex layouts/scans; has a LangChain integration package `langchain-pdf-inspector` [](https://pypi.org/project/langchain-pdf-inspector/#1) |
      | **oxidize-pdf** | Pure Rust PDF generation/parsing/manipulation toolkit | Versatile, supports RAG chunking, structure-aware output, even comes with MCP server [](https://github.com/bzsanti/oxidizepdf/blob/7f66aa708e7a2a70ec0cbb0f877f5d5cb9ff92b4/README.md)[](https://socket.dev/pypi/package/oxidize-pdf/overview/0.18.0#1) | More of a general library; as a "document loader" it is less specialized than the above tools; lacks built-in ML layout analysis/OCR  |
    - Always a good idea to go here: [Document loader integrations - Docs by LangChain](https://docs.langchain.com/oss/python/integrations/document_loaders#pdfs) and examine the updated list of options
- ### A Practical Selection Workflow
  collapsed:: true
    - **Step 1: Characterize your documents first (5 minutes)**
        - Before touching any tool, classify your sample PDFs:
        - **Digital-native vs. scanned?** Scans need OCR (MinerU, OpenDataLoader hybrid). Pure digital PDFs don't.
        - **Layout complexity?** Simple text vs. multi-column, tables, formulas, figures.
        - **Volume and latency budget?** Batch offline processing can afford `MinerU`; real-time ingestion may need `pdfmuse`/`pdf-inspector` speeds.
        - **Language/scripts?** Some OCR backends are stronger for certain languages.
    - **Step 2: Shortlist based on that profile (not all five)**
        - Complex/scanned → **MinerU**, **OpenDataLoader PDF (hybrid)**
        - Clean digital, speed-critical → **pdfmuse**, **pdf-inspector**
        - Need PDF manipulation too → **oxidize-pdf**
        - Already in LangChain → **pdf-inspector** has a native `langchain-pdf-inspector` package
    - **Step 3: Build a small, representative eval set**
        - Pick 10–20 PDFs that cover your edge cases (the hardest table, the worst scan, a typical doc). Don't test on only easy files—that hides differences.
    - **Step 4: Define what "good" means for your downstream task**
        - This is the step most engineers skip. A loader isn't judged in isolation—it's judged by **RAG retrieval quality** or **downstream LLM answer accuracy**. Measure:
            - Text fidelity (character/word error rate vs. ground truth)
            - Table/structure preservation (does the Markdown keep table integrity?)
            - Chunk-boundary sanity (does it split mid-sentence or mid-table?)
            - Speed and memory per page
            - Output determinism (same input → same output?)
    - **Step 5: Run the shortlist, then validate end-to-end**
        - Parse with each tool, chunk, embed, and run a small retrieval/QA eval. A loader that looks great in raw text but breaks tables will lose in RAG.
    - #### ⚠️ Two Cautions
        - **Don't over-benchmark.** Testing all five on a large corpus is a time sink. A 15-document smoke test on your shortlist will eliminate most candidates fast.
        - **Re-test when your corpus changes.** A loader that wins on your current documents may fail on a new document type (e.g., adding scanned invoices). Keep the eval set as a living artifact.
    - #### Bottom Line
        - Empirical testing on your own data is the correct approach, because published benchmarks (like MinerU's OmniDocBench scores or OpenDataLoader's self-reported accuracy) rarely match your specific document mix. But **filter first by document characteristics and constraints, then benchmark the 2–3 survivors end-to-end on downstream quality**, not just raw text extraction. That's the difference between a useful eval and a benchmarking hobby.
- ## Code Examples
  collapsed:: true
    - **Text Loader (deprecated)**
        - Code: [document loading in langchain (deprecated way) · amrullah/ai_agents_with_langgraph@11dc787](https://github.com/amrullah/ai_agents_with_langgraph/commit/11dc787d37e68d7d0212c9ebe675c17d396a2d68)
        - Output:
          collapsed:: true
            - ```
              $ uv run src/ai_agents_with_langgraph/02_document_loaders.py 
              /home/amrullah/Developer/ai_agents_with_langgraph/src/ai_agents_with_langgraph/02_document_loaders.py:4: DeprecationWarning: `langchain-community` is being sunset and is no longer actively maintained. See https://github.com/langchain-ai/langchain-community/issues/674 for details and migration guidance toward standalone integration packages.
                from langchain_community.document_loaders import (
              USER_AGENT environment variable not set, consider setting it to identify your requests.
              Loaded 1 document(s)
              Metadata: {'source': '/tmp/tmpkv_r52a3.txt'}
              Document Content:
              page_content='Hello, this is a sample text file.
              This file is used to demonstrate the TextLoader.' metadata={'source': '/tmp/tmpkv_r52a3.txt'}
              Hello, this is a sample text file.
              This file is used to demonstrate the TextLoader.
              ```
    - **Text Loader (new way)**
        - Code: [text loading using docling package · amrullah/ai_agents_with_langgraph@5e3d58a](https://github.com/amrullah/ai_agents_with_langgraph/commit/5e3d58a049321b743e7f3ab8c61cf7e44328ce48)
        - Output:
          collapsed:: true
            - ```
              $ uv run src/ai_agents_with_langgraph/02_document_loaders.py 
              The plugin langchain_docling will not be loaded because Docling is being executed with allow_external_plugins=false.
              Loaded 1 document(s)
              Metadata: {'source': '/tmp/tmp380ae71b.txt', 'dl_meta': {'schema_name': 'docling_core.transforms.chunker.DocMeta', 'version':'1.0.0', 'doc_items': [{'self_ref': '#/texts/0', 'parent': {'$ref': '#/body'}, 'children': [], 'content_layer': 'body', 'label': 'text', 'prov': []}], 'origin': {'mimetype': 'text/markdown', 'binary_hash': 444185960187452560, 'filename': 'tmp380ae71b.txt'}}}
              Document Content:
              page_content='Hello, this is a sample text file. This file is used to demonstrate the TextLoader.' metadata={'source': '/tmp/tmp380ae71b.txt', 'dl_meta': {'schema_name': 'docling_core.transforms.chunker.DocMeta', 'version': '1.0.0', 'doc_items': [{'self_ref': '#/texts/0', 'parent': {'$ref': '#/body'}, 'children': [], 'content_layer': 'body', 'label': 'text', 'prov': []}], 'origin': {'mimetype': 'text/markdown', 'binary_hash': 444185960187452560, 'filename': 'tmp380ae71b.txt'}}}
              Hello, this is a sample text file. This file is used to demonstrate the TextLoader.
              ```
    - **Web Loader (deprecated)**
        - Code: [web loader (deprecated way) · amrullah/ai_agents_with_langgraph@dc7be61](https://github.com/amrullah/ai_agents_with_langgraph/commit/dc7be61583df6e5845d55cb41ffee0aaaeec2b99)
        - Output:
          collapsed:: true
            - ```
              $ uv run src/ai_agents_with_langgraph/02_document_loaders.py 
              /home/amrullah/Developer/ai_agents_with_langgraph/src/ai_agents_with_langgraph/02_document_loaders.py:4: DeprecationWarning: `langchain-community` is being sunset and is no longer actively maintained. See https://github.com/langchain-ai/langchain-community/issues/674 for details and migration guidance toward standalone integration packages.
                from langchain_community.document_loaders import (
              USER_AGENT environment variable not set, consider setting it to identify your requests.
              [transformers] PyTorch was not found. Models won't be available and only tokenizers, configuration and file/data utilities can be used.
              Loaded 1 document(s) from web
              Source: https://en.wikipedia.org/wiki/Web_scraping
              Content length: 30982 characters
              Preview: 
              
              
              
              Web scraping - Wikipedia
              
              
              Jump to content
              
              
              Main menu
              
              <truncated>
              ```
    - Web Loader (new way)
        - Code: [web page loading using docling · amrullah/ai_agents_with_langgraph@ffdb7d2](https://github.com/amrullah/ai_agents_with_langgraph/commit/ffdb7d2a12da962ef9b93fd2d20ce29b3e2eb6cb)
        - Output:
          collapsed:: true
            - ```
              $ uv run src/ai_agents_with_langgraph/02_document_loaders.py 
              /home/amrullah/Developer/ai_agents_with_langgraph/src/ai_agents_with_langgraph/02_document_loaders.py:5: DeprecationWarning: `langchain-community` is being sunset and is no longer actively maintained. See https://github.com/langchain-ai/langchain-community/issues/674 for details and migration guidance toward standalone integration packages.
                from langchain_community.document_loaders import (
              USER_AGENT environment variable not set, consider setting it to identify your requests.
              [transformers] PyTorch was not found. Models won't be available and only tokenizers, configuration and file/data utilities can be used.
              The plugin langchain_docling will not be loaded because Docling is being executed with allow_external_plugins=false.
              Dropping hyperlink with unsafe scheme; keeping the link text only.
              Loaded 1 document(s).
              
              --- Document Metadata ---
              {'source': 'https://en.wikipedia.org/wiki/Web_scraping'}
              
              --- First 100 characters of Markdown page content ---
              ## Contents
              
              move to sidebar
              
              hide
              
              - [(Top)](#)
              - [1 History](#History)
              - [2 Techniques](#Technique
              ```
    - **Directory Loader (with lazy loading)**
        - Code: [directory loader (with lazy loading) · amrullah/ai_agents_with_langgraph@83f8b41](https://github.com/amrullah/ai_agents_with_langgraph/commit/83f8b41f2c3cd011db56aab454c3b6b5d1edd3e0)
        - Output:
          collapsed:: true
            - ```
              $ uv run src/ai_agents_with_langgraph/02_document_loaders.py 
              /home/amrullah/Developer/ai_agents_with_langgraph/src/ai_agents_with_langgraph/02_document_loaders.py:6: DeprecationWarning: `langchain-community` is being sunset and is no longer actively maintained. See https://github.com/langchain-ai/langchain-community/issues/674 for details and migration guidance toward standalone integration packages.
                from langchain_community.document_loaders import (
              USER_AGENT environment variable not set, consider setting it to identify your requests.
              [transformers] PyTorch was not found. Models won't be available and only tokenizers, configuration and file/data utilities can be used.
              Initialized lazy loader for directory: /tmp/tmpkurbbxvm
              Document Content Preview: This is document 4. It contains sample content. ...
              Metadata: /tmp/tmpkurbbxvm/doc_4.txt
              Document Content Preview: This is document 3. It contains sample content. ...
              Metadata: /tmp/tmpkurbbxvm/doc_3.txt
              Document Content Preview: This is document 2. It contains sample content. ...
              Metadata: /tmp/tmpkurbbxvm/doc_2.txt
              Document Content Preview: This is document 1. It contains sample content. ...
              Metadata: /tmp/tmpkurbbxvm/doc_1.txt
              Document Content Preview: This is document 0. It contains sample content. ...
              Metadata: /tmp/tmpkurbbxvm/doc_0.txt
              ```
    - **PDF Loader (old way)**
        - Code: [pdf loader (old way) · amrullah/ai_agents_with_langgraph@752d5a8](https://github.com/amrullah/ai_agents_with_langgraph/commit/752d5a8c8fd6d2123fe1f7d8e1caf54c92585f34)
        - Output:
          collapsed:: true
            - ```
              $ uv run src/ai_agents_with_langgraph/02_document_loaders.py 
              
              Loaded 3 document(s) from PDF
              Document 1 Content Preview: LangChain Document Loaders - Demo Document
              Understanding LangChain Document Loaders
              1. Introduction
              ...
              Metadata: {'producer': 'PyPDF', 'creator': 'PyPDF', 'creationdate': '2026-02-02T21:45:08+00:00', 'source': './docs/langchain_demo.pdf', 'total_pages': 3, 'page': 0, 'page_label': '1'}
              Document 2 Content Preview: LangChain Document Loaders - Demo Document
              4. Best Practices
              When working with document loaders, con...
              Metadata: {'producer': 'PyPDF', 'creator': 'PyPDF', 'creationdate': '2026-02-02T21:45:08+00:00', 'source': './docs/langchain_demo.pdf', 'total_pages': 3, 'page': 1, 'page_label': '2'}
              Document 3 Content Preview: LangChain Document Loaders - Demo Document
              formatting, and provides realistic content for testing yo...
              Metadata: {'producer': 'PyPDF', 'creator': 'PyPDF', 'creationdate': '2026-02-02T21:45:08+00:00', 'source': './docs/langchain_demo.pdf', 'total_pages': 3, 'page': 2, 'page_label': '3'}
              ```
    - **PDF Loader (using `OpenDataLoader`)**
        - Code: [pdf loading using OpenDataLoader · amrullah/ai_agents_with_langgraph@a0606aa](https://github.com/amrullah/ai_agents_with_langgraph/commit/a0606aa24692f14925a75daadd7274e49424edea)
        - Output:
          collapsed:: true
            - ```
              uv run src/ai_agents_with_langgraph/02_document_loaders.py 
              Loaded 3 document(s) from PDF
              
              
              Document 1 Content Preview: Understanding LangChain Document Loaders
              
              1. Introduction
              
              LangChain provides powerful document load...
              
              Metadata: {'source': 'langchain_demo.pdf', 'format': 'text', 'page': 1}
              
              
              Document 2 Content Preview: 4. Best Practices When working with document loaders, consider these best practices:
                1. Text Split...
              
              Metadata: {'source': 'langchain_demo.pdf', 'format': 'text', 'page': 2}
              
              
              Document 3 Content Preview: formatting, and provides realistic content for testing your LangChain document loading pipelines....
              
              Metadata: {'source': 'langchain_demo.pdf', 'format': 'text', 'page': 3}
              ```
- # Chunking and Splitting
- ## Why chunking matters
    - The documents have to be chopped up to smaller chunks to feed to [[RAG]] and ultimately to LLM.
    - <div style="display: flex;"> 
      <div style="border: 1px solid var(--ls-primary-text-color); padding: 5px;"> <span style="font-weight: bold;">Large Documents</span> <br /> 50,000 Tokens</div> 
      <div style="padding: 20px; padding-left: 10px; font-size: 25px;"> → </div> 
      <div style="border: 1px solid var(--ls-primary-text-color); padding: 5px;"> <span style="font-weight: bold;">Text Splitter</span><br /> Chunking</div>
      <div style="padding: 20px; padding-left: 10px; font-size: 25px;"> → </div> 
      <div style="border: 1px solid var(--ls-primary-text-color); padding: 5px;"> <span style="font-weight: bold;">Chunks</span><br /> 500-1000 Tokens</div>
      <div style="padding: 20px; padding-left: 10px; font-size: 25px;"> → </div> 
      <div style="border: 1px solid var(--ls-primary-text-color); padding: 5px;"> <span style="font-weight: bold;"> Embedd-ings</span> <br /> Vectors</div>
      <div style="padding: 20px; padding-left: 10px; font-size: 25px;"> → </div> 
      <div style="border: 1px solid var(--ls-primary-text-color); padding: 5px;"> <span style="font-weight: bold;"> Vector store</span><br /> Searchable</div>
      </div>
- ## Key considerations
    - [[LLM]]'s have context limits
    - Smaller chunks = Precise retrieval
      collapsed:: true
        - Better relevance matching
    - Too small = Lose context
      collapsed:: true
        - Due to incomplete
    - Too large = noise in retrieval
        - irrelevant content included
        - will not be optimal
- ## Chunking strategies
- ### RecursiveCharacterTextSplitter
    - **Key configs**
        - chunk_size
        - chunk_overlap
        - separators
    - **Chunk Size guidelines**
        - |Use Case|Chunk size|Overlap|Why|
          |--|--|--|--|
          |Q&A/FAQ|500-800|50-100|Precision|
          |Documentation|1000-1500|200|Context|
          |Code |1500-2000|200|Functions|
          |Books/Articles|800-1200|150|Balance|
    - #### Why overlap is necessary in chunks
      collapsed:: true
        - > Overlap is recommended because **chunk boundaries are arbitrary, but meaning isn't.** A small overlap buys boundary safety and better retrieval at a modest storage cost. Tune it empirically: if your retrieval eval shows relevant content being missed at chunk edges, increase overlap; if you see heavy duplication in top-k, decrease it.
        - **Prevent context loss at chunk boundaries**
            - If a sentence or concept spans a split point, neither chunk contains the full thought. Overlap means the end of chunk A and the start of chunk B both carry the boundary region, so at least one chunk has the complete idea. This directly improves retrieval: a query matching that idea will hit a chunk that actually contains it.
        - **Improve retrieval recall**
            - Embeddings are computed per chunk. Without overlap, a chunk that starts mid-sentence may embed poorly—its vector doesn't represent a coherent unit. Overlap gives each chunk a more self-contained semantic profile, so similarity search is less likely to miss relevant content.
        - **Preserve answer continuity for the LLM**
            - When retrieved chunks are fed to an LLM, overlapping text provides a bridge between adjacent chunks. The model sees the connective tissue (the end of one thought and the beginning of the next), reducing the chance of a truncated or disjointed answer.
        - **Guard against imperfect splitters**
            - Splitters work on heuristics (character counts, separators). They don't understand semantics. A 10–15% overlap is a cheap insurance policy against the splitter's blind spots—especially with `RecursiveCharacterTextSplitter`, which may still cut mid-sentence when a single sentence exceeds `chunk_size`.
    - ##### Trade off
      collapsed:: true
        - Overlap isn't free:
          | Cost | Effect |
          | ---- | ---- | ---- |
          | **More chunks / larger index** | 10–20% overlap means ~10–20% more storage and embedding cost |
          | **Redundant retrieval** | The same passage may appear in two chunks, so top-k results can be duplicative |
          | **Diminishing returns** | Overlap much beyond ~20–25% mostly adds redundancy, not recall |
    - ##### Practical Rule of Thumb
      collapsed:: true
        - **Typical range: 10–20% of `chunk_size`** (e.g., `chunk_size=1000`, `chunk_overlap=100–200`).
        - **Dense, idea-rich text** (legal, scientific) → lean toward 15–20%.
        - **Simple, list-like content** → 5–10% is often enough.
        - **Watch token budget**: since `RecursiveCharacterTextSplitter` measures in characters, verify the effective token size of chunks (including overlap) fits your embedding model and LLM context.
-
- ### Semantic chunking
    - Converts a document with a variety of topics in to "semantic chunks", ie. chunks of text with similar meaning in them, or about the same topic. (group by meaning)
    - Requires Embeddings API calls.
    - Best for documents with mixed topics
- ## Code Examples
    - **RecursiveCharacterTextSplitter** (text, code, pdf)
        - Code: [recursive character text splitter · amrullah/ai_agents_with_langgraph@c3ce578](https://github.com/amrullah/ai_agents_with_langgraph/commit/c3ce5789ddc0ad74c40f51830efa1d567b456a52)
        - Output:
          collapsed:: true
            - ```
              $ uv run src/ai_agents_with_langgraph/03_text_splitters.py 
              Original length: 887 chars
              Number of chunks: 2
              Chunk sizes: [462, 423]
              
              First chunk preview:
              # Introduction to Machine Learning
              
              Machine learning is a subset of artificial intelligence that enables systems to learn and improve from experience without being explicitly programmed.
              
              ## Types of ...
              ```
        - Code: [code splitting with RecursiveCharacterTextSplitter · amrullah/ai_agents_with_langgraph@c569426](https://github.com/amrullah/ai_agents_with_langgraph/commit/c569426027eef942985941353df5c05cdc696749)
        - Output:
          collapsed:: true
            - ```
              $ uv run src/ai_agents_with_langgraph/03_text_splitters.py 
              Code Splitter produced 2 chunks.
              
              Chunk 0 (390 chars):
              def quicksort(arr):
                  """
                  Quicksort implementation in Python.
                  Time complexity: O(n log n) average, O(n²) worst case.
                  """
                  if len(arr)...
              
              Chunk 1 (402 chars):
              def binary_search(arr, target):
                  """
                  Binary search implementation.
                  Requires sorted array.
                  Time complexity: O(log n)
                  """
                  left, r...
              ```
        - Code: [pdf splitter · amrullah/ai_agents_with_langgraph@d14378d](https://github.com/amrullah/ai_agents_with_langgraph/commit/d14378d59451595a31abe98ba2c8def5738219fd)
        - Output:
          collapsed:: true
            - ```
              $ uv run src/ai_agents_with_langgraph/03_text_splitters.py 
              Loaded 3 documents from PDF.
              Split into 8 chunks
              
              First chunk metadata: {'source': 'langchain_demo.pdf', 'format': 'text', 'page': 1}
              First chunk content: Understanding LangChain Document Loaders
              
              1. Introduction
              
              LangChain provides powerful document loaders that allow you to ingest data from various sources into your LLM applications. Document loaders...
              
              Last chunk metadata: {'source': 'langchain_demo.pdf', 'format': 'text', 'page': 3}
              ```
    - **MarkdownHeaderTextSplitter**
        - Code: [markdown text splitter · amrullah/ai_agents_with_langgraph@8ee3206](https://github.com/amrullah/ai_agents_with_langgraph/commit/8ee3206d6af675894ce368d7508eade6104ac5fc)
        - Output:
          collapsed:: true
            - ```
              $ uv run src/ai_agents_with_langgraph/03_text_splitters.py 
              Markdown Splitter produced 4 chunks.
              --- Chunk 0 ---
               Metadata: {'h1': 'Introduction to Machine Learning'}
              
               Content: Machine learning is a subset of artificial intelligence that enables systems to learn and improve from experience without being explicitly programmed....
              
              --- Chunk 1 ---
               Metadata: {'h1': 'Introduction to Machine Learning', 'h2': 'Types of Machine Learning', 'h3': 'Supervised Learning'}
              
               Content: Supervised learning uses labeled data to train models. The algorithm learns to map inputs to outputs based on example input-outputpairs.  
              Common algorithms include:
              - Linear Regression
              - Decision Tr...
              
              --- Chunk 2 ---
               Metadata: {'h1': 'Introduction to Machine Learning', 'h2': 'Types of Machine Learning', 'h3': 'Unsupervised Learning'}
              
               Content: Unsupervised learning finds hidden patterns in unlabeled data. The algorithm discovers structure without predefined labels.  
              Common algorithms include:
              - K-Means Clustering
              - Principal Component Anal...
              
              --- Chunk 3 ---
               Metadata: {'h1': 'Introduction to Machine Learning', 'h2': 'Applications'}
              
               Content: Machine learning is used in many fields:
              1. Image recognition
              2. Natural language processing
              3. Recommendation systems
              4. Fraud detection
              5. Autonomous vehicles...
              ```
    -