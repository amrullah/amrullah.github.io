filters:: {"templates" false}
type:: [[Career Learnings]] 
alias::
tags::

- Think of a prompt as answering a few fundamental questions for the AI:
    - **Who are you?** → Identity context
    - **What situation are we in?** → World context
    - **What do you need to do?** → Task context
    - **How should you do it?** → Process context
    - **What should the result look like?** → Output context
- The more clearly you answer these questions, the better the AI performs.
- ---
- # A Simple Mental Model
    - Imagine you're hiring a consultant for 30 minutes.
    - Before they can help, they need to know:
        - Who they are supposed to be
        - What they should know
        - What problem they're solving
        - What constraints exist
        - What output you expect
    - These map directly to different kinds of prompt context.
- # 1. Identity Context (Role Context)
    - **Who should the AI act as?**
        - This sets expertise, perspective, and decision-making style.
- ### Example
    - Instead of:
      >  Explain this code.
      
      Use:
      >  You are a senior Python engineer mentoring a junior developer. Explain this code.
      
      Now the AI will likely:
        - Use engineering terminology
        - Explain tradeoffs
        - Teach rather than merely describe
- ### Other examples
    - Product Manager
    - Startup Advisor
    - CFO
    - Career Coach
    - Doctor (for educational purposes)
    - Teacher
    - Marketing Strategist
- Think:
  >  "Who would I hire to solve this?"
- # 2. World Context (Background Context)
    - **What is true about the situation?**
        - This gives the AI the environment in which it should operate.
    - ### Example
        - Bad:
          >  Create a growth strategy.
        - Better:
          >  We are a B2B SaaS company with 50 employees, $5M ARR, selling to manufacturing firms in Europe.
        - Now the AI has a world to reason within.
    - ### Includes
        - Company details
        - Industry
        - Market conditions
        - Geography
        - Team structure
        - Existing products
        - Historical events
    - Think:
      >  "What would a human need to know before helping me?"
- # 3. User Context (Audience Context)
    - **Who are you?**
        - The AI often performs much better when it knows the person it's helping.
    - ### Example
        - > I am a first-year engineering student with no machine learning background.
          
          versus
          >  I am an ML researcher.
          
          Same question, very different answer.
    - ### Includes
        - Experience level
        - Goals
        - Skills
        - Preferences
        - Available time
        - Budget
    - Think:
      > "What about me affects the answer?"
- # 4. Task Context
    - **What exactly should the AI do?**
      
      This is the actual job.
    - ### Example
        - Weak:
          > Analyze this document.
        - Strong:
          > Analyze this document and identify the top 5 business risks.
    - The task should ideally start with an action verb:
        - Analyze
        - Summarize
        - Compare
        - Critique
        - Brainstorm
        - Design
        - Rewrite
        - Explain
        - Prioritize
    - Think:
      >  "What specific job am I assigning?"
- # 5. Goal Context
    - **Why are you doing this?**
        - AI often gives better answers when it understands the underlying objective.
    - ### Example
        - Instead of:
          
          > Write an email.
          
          Use:
          > Write an email convincing the client to renew their contract.
        - The goal influences choices.
    - ### Examples
        - Get funding
        - Pass an interview
        - Reduce costs
        - Increase conversions
        - Learn a topic
        - Persuade stakeholders
    - Think:
      >  "What outcome am I trying to achieve?"
- # 6. Constraint Context
    - **What limitations exist?**
        - Humans need constraints to produce useful work. So do AI models.
    - ### Example
        - > Create a marketing plan.
          
          versus
          > Create a marketing plan with a budget under $5,000 and a team of two people.
    - ### Constraints can include
        - Budget
        - Time
        - Resources
        - Legal requirements
        - Brand guidelines
        - Technology limitations
        - Word count
    - Think:
      > "What can't be changed?"
- # 7. Process Context
    - **How should the AI approach the task?**
        - This influences reasoning style.
    - ### Example
        - >  Think step-by-step before answering.
          
          or
          >  Evaluate three alternatives before recommending one.
          
          or
          >  First identify assumptions, then provide a recommendation.
    - This is especially useful for:
        - Analysis
        - Strategy
        - Problem solving
        - Decision making
    - Think:
      > "How should the work be done?"
- # 8. Output Context (Format Context)
    - **What should the answer look like?**
        - Many prompt failures are actually formatting failures.
    - ### Example
        - Instead of:
          
          >  Compare AWS and Azure.
          
          Use:
          >  Compare AWS and Azure in a table with columns for cost, scalability, learning curve, and enterprise adoption.
    - ### Common output formats
        - Table
        - Bullet list
        - Executive summary
        - JSON
        - Markdown
        - Email
        - Presentation outline
        - Report
    - Think:
      > "What deliverable do I want?"
- # 9. Quality Context
    - **What does a good answer look like?**
        - You can define the standard of quality.
    - ### Example
        - >  Give a recommendation and explain the reasoning, risks, assumptions, and alternatives.
          
          or
          > Be concise and practical.
          
          or
          > Be comprehensive and academically rigorous.
    - Think:
      > "How good is good enough?"
- # 10. Example Context (Few-Shot Context)
    - **Show examples of desired behavior.**
        - This is one of the most powerful prompting techniques.
    - ### Example
        - > Input: "The service was slow."
          Output: "Customer reports slow service response times."
          Input: "The UI is confusing."
          Output: ?
        - The AI learns from examples rather than instructions alone.
    - Think:
      >  "Can I show instead of tell?"
- # 11. Knowledge Context (Reference Context)
    - **What source material should the AI use?**
        - You provide the facts.
    - ### Example
        - > Use the following company strategy document when answering.
          
          or
          > Here is our API documentation.
        - This dramatically reduces hallucinations.
    - Think:
      > "What information should the AI rely on?"
- # 12. Interaction Context
    - **How should the conversation proceed?**
    - ### Example
        - > Ask me questions one at a time before making recommendations.
          
          or
          > Challenge my assumptions.
          
          or
          > Act as a debate partner.
        - This controls the collaboration style.
    - Think:
      >  "How should we work together?"
- # Putting It All Together
    - A complete prompt often looks like this:
        - ```
          Identity:
          You are a senior product manager.
          
          World Context:
          We are a SaaS company serving small businesses.
          
          User Context:
          I am a new PM with 6 months of experience.
          
          Task:
          Create a roadmap for the next 12 months.
          
          Goal:
          Increase customer retention by 20%.
          
          Constraints:
          Budget is limited and engineering capacity is 5 developers.
          
          Process:
          Evaluate opportunities using impact vs effort.
          
          Output:
          Provide a table with initiatives, rationale, effort, and expected impact.
          
          Quality:
          Include risks and assumptions.
          ```
- # The Hierarchy of Context
    - If you remember only one thing, remember this stack:
        - ```
          Identity     → Who are you to act as?
          World        → What situation are we in?
          User         → Who am I?
          Task         → What do I want done?
          Goal         → Why?
          Constraints  → What limits exist?
          Process      → How should you think?
          Output       → What should I receive?
          Examples     → Show me what good looks like.
          References  → What information should you use?
          ```
    - Most beginner prompts contain only **Task Context**:
      > "Write a marketing plan."
    - Strong prompts usually contain at least:
      >  **Identity + World + Task + Constraints + Output**
    - That's the point where prompt quality often jumps from **"generic"** to **"surprisingly useful"**.