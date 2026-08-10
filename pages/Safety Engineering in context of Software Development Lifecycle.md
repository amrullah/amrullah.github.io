filters:: {"templates" false}
type:: [[Career Learnings]] 
alias::
tags::

- # Abstract
- Software Development / Engineering as a discipline is quite nascent in comparison to other disciplines like Mechanical, Electrical, Electronics, Civil Engineering. And thus, it lacks the maturity in the Product development lifecycle that are present in the other disciplines of engineering. This state of (relative) apathy towards safety and incident avoidance is exacerbated by the fact that a software bug rarely leads to physical injuries or death. However, this doesn't mean there are no harms of a software development process with not-so-mature safety engineering practices.
- # Harms of not having a Safety Engineering policy
    - (cultural harms) - blame-game, too much bureaucracy and paperwork , shallow analysis of incidents, inability to prevent an incident of same kind from occurring again. Job dissatisfaction, high attrition in customer facing teams. High workload on Tech Teams due to constant fire-fighting. Stagnation in Innovation
    - (financial harms) - erroneous creation/destruction of money, miscalculation, lawsuits, damage claims
    - (PR harms) - reputational damage to organization, loss of faith upon the tech team
- # Some terminologies
    - ## Incident
        - Unexpected or Undesirable incident that has the potential to cause some harm. In our context, it can be any bug / failure which is not discovered by the customer. (This is slightly relaxed definition, ideally it should be "..which does not harm the customer, stakeholder or employees in insidious or conspicuous ways". But that's the state an organization has to reach to, over a period of time)
    - ## Accident
        - An incident which actually leads to a harm.
- # Methodology
    - ## Mindset
        - ### Ideal
            - "What caused this?"
            - Manifestation: Grow and sustain the tree by first sowing the seeds (instituting policies) and regular maintenance (tactical moves). Discovering Root causes and fixing/mitigating them is a continous never ending process. Realizing that humans are prone to error, and 0 human errors cannot be achieved, rather, the goal should be to reduce the frequency to the point of their disengagement from the business performance.
        - ### counterproductive
            - "Who caused this?"
            - Manifestation: Assigning blame, reprimanding (even if concealed), tackling only surface level causes of an incident and never looking for a pattern or historical context of incidents.
    - ## Strategic
        - Managing Complexity with good Software Architecture and Code Design
        - Sensitizing the Team to  [[The Design of Everyday Things]] (seven fundamental principles of Design)  so that they thoughtfully design any interface (UI, API's, SDK's, scripts etc.) which are learnable and which constrain undesirable or destructive actions from being carried out.
        - Team's maturity in Software Implementation Practices ([[TDD]], Modular Code Design etc.)
        - Mature automated testing infra
        - Automated checks before deployment
        - Mature Software Delivery process (requires less human actions, easy to do gradual rollout, easy to rollback),
        - monitoring, Alerting for early discovery, (ensuring monitoring systems don't overwhelm humans)
        - observability (logs), Auditability (db records) for efficient investigation,
        - [Swiss Cheese model of Accidents](https://wiki.corp.adobe.com/display/~azunzunia/The+Design+of+Everyday+things%2C+in+a+nutshell#TheDesignofEverydaythings,inanutshell-TheSwissCheeseModelofAccidents),
        - [Fault Tree Analysis](https://en.wikipedia.org/wiki/Fault_tree_analysis),
        - hiring right people, employee trainings / coachings, building a culture where people don't fear about repercussions of reporting incidents.
        - Collecting statistics around Incidents and Accidents and regularly aligning the team with the Safety Engineering goals
    - ## Tactical
        - 5 whys,
        - monitoring for early discovery,
        - Skilled Log Analysis,
        - plugging the discovered bug with automated Test case,
        - Retrospectives,
        - Regular checks on the progress of the policies and their impacts,