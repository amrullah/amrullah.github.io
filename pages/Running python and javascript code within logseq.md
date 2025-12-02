filters:: {"templates" false}
type:: [[Internet Resource]] 
alias:: 
link:: https://github.com/adxsoft/logseq-code-execution-demo-graph/blob/main/CodeExecutionDemo.zip 
tags::

- {{video https://www.youtube.com/watch?v=u1hi7HjG66A}}
- ```python
  import js
  print(dir(js.logseq.api))
  js.logseq.api.get_page_blocks_tree("PDF files")
  # the after js.logseq.api, add functions that are in `logseq.editor` section in
  # https://plugins-doc.logseq.com/logseq/Editor/getPageBlocksTree
  
  ```
    - {{evalparent}}
    -