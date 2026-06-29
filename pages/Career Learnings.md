filters:: {"templates" false}
type:: [[Portal]]
alias::
tags::
description::

- The next big skill inside engineering orgs will be AI cost discipline.
    - Which model should this task use?
      How much context is actually needed?
      Should this run as an agent or a simple prompt?
      What is the cost per accepted PR?
- Seniority:
    - Trust (Reliability, consistency)
    - Influence (Advocacy, stakeholder buy-in)
    - Perception (should be built on rock-solid base of previous two, without which it won't survive long and can even backfire)
- Feedback in Adobe:
  collapsed:: true
    - Gavin Daniel
        - In reflecting back on Conversion Upload Migration, what did you think I did well and what impact did it have? Examples are helpful!
            - The documentation provided for the migration had detailed steps to make it easy to migrate clients and validate the migration was correct. It was written in a clear way and was easy to find the specific area relating to the task being performed. Even when we had some queries on some of the processes you helped to clear them up quickly and were available for support throughout the project in weekly catchup calls and ad-hoc meetings.
        - As I take on similar projects in the future, what feedback do you have for me that could help me be more impactful?
            - Validate that any processes mentioned in the wiki works correctly with the support team setup prior to going live with the process. This will help to avoid delays.
    - Alex Lambrakis
        - In context of Conversion Upload at Objective Level Project, what are the things you think that I did well?
            - Amrullah has done a great job of quick analysis of requirement implications and 'what-if' thinking on detailed requirement scenarios. Having a good idea both of the overall purpose of a project, down to the detailed edge cases that could come up, he is able to move between the general and specific points very well.
            - Also, in terms of communication - Amrullah is a very thoughtful and calm communicator, taking care to cover all bases without rushing or getting carried away on any topics. Very direct and easy to work with
        - What are the things I could do differently, and what impact would it have?​
            - In some cases of supplemental docs and logic/algorithm explanations, could offer a bit more background and scope of what is/is not covered. This can lead to faster coordination and scalability to multiple team members who may have less context on a project.
        - Anything else you think I should know?​
            - Keep up the good work Amrullah! I appreciate you always clearly laying out any points for clarification or improvement and following up in the right way. The rollout of Objective Upload was a success and I look forward to working together more this year.
    - Aishvarya Ananth
        - In reflecting back on Conversion Upload Migration, what did you think I did well and what impact did it have? Examples are helpful!
            - Your ability to coordinate the migration process was great. You organized and scheduled client migrations efficiently, ensuring minimal disruption. For example, your clear communication and detailed migration plans helped us transition multiple clients seamlessly within a tight timeframe.
        - As I take on similar projects in the future, what feedback do you have for me that could help me be more impactful?
            - While the migration went smoothly, proactively identifying potential issues earlier could further enhance the process. For future projects, consider conducting more frequent risk assessments and developing contingency plans to address potential challenges before they arise.
        - Is there any other feedback you'd like to share?
            - By continuing to focus on proactive problem-solving, you'll be able to make an even greater impact.
              A small suggestion would be to also have meetings slightly earlier in the day as most of us work India/EMEA hours.
    - Sayan Mukherjee
        - What is one thing I am doing well?​
            - You are extremely thorough and conscientious with whatever you do. I saw this in 2022 while working on Runbooks for the Execute processes with you, in 2023 when you worked on Observability, and most recently during the conversion tracker migration process. One of your greatest talents is 'big picture thinking' and that helps you anticipate challenges and design for it in advance.
            - Some Examples to illustrate this:
                - Behavioral
                    - Clear communication of what needed to be done, including KT sessions and sync ups with Alex and others
                    - Jointly leading it with Anchal with no visible conflict / lack of sync (rather smooth harmony) is a testament to how well you work with peers
                - Technical
                    - Amrullah has a penchant for breaking down complex concepts into simpler ones (without over-simplyfing) and expressing that in a way that is understandable for others - an example of this is the continuous innovation and improvements that he has brought to all the Wiki's and Runbooks that have his direct contribution - they stand in stark contrast to the average both in terms of presentation as well as depth of content
                    - Adding and improving log statements / fields that made it really simple to cross check for correctness during the process - such as we could easily tell if the tracker was uploaded or if the process didn't run
        - What is one thing I could do differently, and what impact would it have?​
            - On your path to growth to the next level, be it architect or engg manager, you have to start building consensus faster. This will be best achieved if you are better able to bring brevity to your presentation. Depth is great, but may not always be optimal for all audiences.
        - Anything else you think I should know?​
            - It is always fun interacting with you since you have so much breadth of knowledge: be it technical or non-technical concepts and are a cheerful person.
- Year End Check-in Conversations
    - 2022:
      collapsed:: true
        - Contributed to Clean code Session 1 with content to present. Suggested topics for future sessions about code cleanliness and software reliability.
        - Improved the log statements for easier debugging in Ad execute process. But couldn't go live due to release freeze.
        - Brought observability to Ad Execute process. (Currently in Testing phase. Yet to go live)
        - Kept improving Campaign Execute On Call Runbook as more insight was gathered in production environment
        - Brought observability to the Campaign Execute Process. Improved the log messages so they can be easily searched for the the affected campaign and user account. As a result of better visibility, found and fixed the long standing bugs that plagued the campaign execute process.
        - Manager's feedback:
            - In this 6 months with our team, you were very descriptive and trying to complete the task to the perfection with respect to documentation, coding style and coverage which is good. As part of observability and stability, you were working on optimization execution modules and added alerts for these. As you are owning execution modules, focus on understanding the functionality of the module end to end and the business criticality.
            - The campaign execute uptime monitoring and fixing existing issues is a good effort, you implemented the changes and run book documentation are all well planned and organized. Continue doing that.
            - Noticed that you were taking more time to complete tasks, could be because of being new to the system but please focus on prioritising the tasks based on criticality and impact on customer actions
            - Being part of the clean code initiative team, guiding the team on writing clean code is important. Have to enforce the guidelines.
            - You will be part of Stability and Observability team, focus on improving the code coverage (both regression and unit test) and modernizing the existing stack.
    - 2023
      collapsed:: true
        - Clean Code initiative
            - Conducted Coding Sessions to inculcate good coding practices.
            - Prepared a Reviewer's checklist which is to be followed while review
            - In depth Coding Guidelines is **in progress** as it's an extensive document
        - Modernization
            - Two **new processes**, Ad Execute Validator and Campaign Execute Validator have been **written** with keeping the **coding standards** in mind and to serve as an **example** for others to **follow**. They consist of **type hints** for better comprehensibility and safety, and they also consist of **unit tests** to guard against any inadvertent introduction of bugs.
            - Also, a framework has been created for other people to write validators for their processes.
        - Execute Documentation
            - Campaign Execute Process Documentation was done in the past quarters
            - For Ad Execute Process Documentation, I conducted multiple group discussions to make sense of the process. The documentation is 90% complete (majority of progress in writing it, in this quarter, has been made by Kiran Hebbar).
            - Two pending things are: 1. understanding the effect of search engine's bidding style. 2. Good formatting
        - Observability - Data Monitoring
            - Expected bid/budget pushes vs. Actual bid/budget pushes alert is deployed to production and handed over to Tech Support team.
            - Comparison against average of last 3 days (Probabilistic) Alert is deployed to production but hard to hand-over to other teams because it's a vague alert and requires checking all the upstream processes. It won't even be required after the **Validator** processes will go live and it's alerts handed over to Tech support team.
            - Ad/Campaign Execute Validator Processes, at the time of writing this, are being tested in staging. Will be beta-released and perfected soon.
        - Observability - Other improvements
            - Prepared an extensive Wiki for **Observability Setup** to save time for those who going to enable it for their processes.
            - Made IdempotentCounter class more flexible to accept multiple labels for idempotence check. This made it possible to use it for Report Fetcher and Sync processes and consequently, these processes now emit less metrics and raise fewer false alerts.
            - Devised a new pattern of alert expressions which completely eliminated false alerts for Execute Processes (sum(timeseries) - sum(timeseries offset 5m)). The previously used pattern, which depended on increase() function used to generate false alerts for our use-case. This new pattern eliminates that and has been utilized for Upload Objective Function and Report Fetcher alerts too.
            - Kept improving the Logging standards document written in previous quarter.
            - Pioneered an Runbook style and guided other teammates to utilize it to bring readability, usability and uniformity to the runbooks. For example Report Fetcher Runbook once looked like this (pedestrian effort). Now it looks like this (much better formatted).
            - Greatly enhanced the usability of Pagerduty alerts by mandating these things:
                - 1. Runbook links in alerts should have the link to the specific section of that alert in the runbook.
                - 2. Suggested to Amar for provision to add a new link in each alert called "splunk_url", which directly takes to splunk with the corresponding log search query applied.
                - 3. In runbooks, in each alert section, there's a "View in Splunk" link to make looking for relevant logs convenient.
        - Year End:
            - Planned
                - Stability, Uptime and Data Monitoring:
                    - Wrote the **Logging Standards Document** and **inculcated** these **values** amongst the team-members while **reviewing** the Observability related **Pull Requests**.
                        - Outcome: These standards help with **efficient incident investigation** of impacted clients, by the On-Call personnel, because they can employ techniques like these... (basically my wiki on extracting useful information from Splunk)
                    - Brought improvements to log messages by making changes to the Logger class.
                        - Outcome: Made adhering to the Loggings standards easier as a result for the team.
                    - Brought improvements to **IdempotentCounter** class (multiple labels support), so as to help **increase** it's **adoption** (For example, in Report Fetcher)
                        - Outcome: This lead to **reduction** in **redundant** metrics **collection** and improvement in the **reliability** of Prometheus Alert Expression evaluation.
                    - Summarized Outcome:
                        - Increased the reach of observability, leading to detection of previously undetected issues. Contributed to prevention of client churn.
                        - Contributed to the stability of Prometheus setup by designing constructs that prevent sending unnecessary amount of metrics to Prometheus server.
                - Clean Code Initiative:
                    - Wrote the [[Coding Guidelines I wrote in Adobe]] which can serve as a guidelines for enforcing the coding standards for the team.
                    - Conducted several **Hands-on Coding sessions** to instill the clean coding guidelines. Whose recordings (link removed) can serve as guides to the team members.
                    - Outcome:
                        - Helps in enforcing a **good coding practices** across the team, which in turn can lead to **prevention** of production **issues**. But it's success depends on the active participation of the team members too.
                - Module Ownership:
                    - Relentlessly extracted the knowledge of the **Ad Execute process**, whose code was extremely obfuscated. And captured that knowledge in the Ad Execute Process wiki
                    - Outcome:
                        - This **knowledge** helps in helping address any bugs that are discovered and also **future** **refactoring** of the process, which may contribute to it's **maintainability**.
            - Unplanned
                - Conversion Goal Automation
                    - Involved in analysis and design, in particular of the Conversion Goal Automation feature. Helping Anchal learn how to make good design decisions.
            - Self Initiative
                - **Designed good runbook experience** for Tech support and On Call personnel, by guiding the team-members to write good runbooks. Examples: (Report Fetcher, Sync Runbooks)
                - **Designed good incident investigation experience** for the Tech support and On Call personnel, enforcing logging standards in the Observability Pull Requests that I reviewed this year.
                - Outcome of above two:
                    - Outcomes of things like this are usually not so apparent. The fact that those who rely on runbooks don't reach out to authors every now and then for clarification is itself a great outcome. In rare situations, someone would take notice and praise the effort. (Sayan had appreciated the thoughtful design of on-call workflow experience)
                    - Contributed to the **ease of use** of Jothikanth's **Heartbeat Metrics Collection** feature: (basically suggested to contain the scatter of functions into one simple class HeartbeatMetricsCollector with defined public methods)
                    - **Strategized** around the **Unit Testing improvements**. Epic link. (identified the gaps and created an execution plan of tasks to divide and conquer the problem) (helped with tests directory standardization, local setup, CI/CD job improvements)
            - Manager's Feedback:
                - Hi Amrullah,
                - In Q1 and Q2 you were focussing on Execution ownership wiki and related monitoring. You were able to understand the execution module and provided Knowledge base docs and enabled Application support team to handle customer issues.
                - You showed good commitment to understand the functionality and business and updated monitoring for execute there by demonstrated Adobe Capability "Be Focused". Your efforts to improve the guidelines of Runbooks for on-call engineers are very much appreciated.
                - Coding guidelines are now published and your contributions are very good in bringing it out, your efforts to create impact on the team by improving the coding style to testability and maintainability showed your Adobe Capability "Be A Leader".
                  In Q3and Q4, you were assigned tasks related to conversion upload - monitoring and redesign. You delivered monitoring for conversion upload and exploring the conversion goal automation and conversion upload in objective level.
                - Challenges: As you called out, need to improve on business understanding which will enable you contribute to more than one projects simultaneously if needed. Its a good thing that you started courses on Google Ads.
                - Overall, its a good year in terms of improving understanding in execution modules and your initiatives are very much appreciated. Continue the good work.
                - Thanks,
                - Ravi
    - 2024
        - Deliverables
            - Conversion Upload at Objective Level
                - Stable Feature Release (relative to the size of the feature), Post Release Monitoring and proactive Observability related improvements (Links to PR's)
                - Took over the abstract Migration Plan and engineered it to **an actionable plan** through collaboration with stakeholders from App Support Team
                    - | New Process Enable | 90 days Data Collection | Ensure  Tracker Creation | Ensure Conversion Upload | Sync SE Conversions to AdCloud | Wait for 8 hours | Revenue Match (90 days) | Wait for a week | Revenue match (7 days) | Handoff to AM  | AM - Replacement of Trackers | Old process Disable | Notify the Data Team | AM- Delete Old Trackers after confirmation | exception |
                - Handed over Uptime Alerts to the App Support team along with Conversion Upload Runbook and Process documentation wikis, so as to help them efficiently resolve the issues and minimize the Ticket escalations to the Engineering team.
            - Modular Code Design + Test Driven Development promotion in the team
                - Guided Anchal throughout the Design and Implementation of Conversion Upload at Objective Level Process. In this duration, her Low Level Design (Conversion Goal Automation) and Test Driven Development (Adding File Path CLI arg) skills improved considerably.
                - Conducted more talks on Modular Code Design, answered questions of team-mates, floated the coding guidelines feedback form so as to build a consensus around the Coding Guidelines.
                - Instituted an updated **Unit Test Directory Structure** for python2 and python3 unit tests. Provided vision for the Unit Test improvements initiative (epic link) and aligned the team mates to the vision through discussions.
            - Manager's Feedback:
                - Hi Amrullah,
                  
                  In Q2 you did a good job in coordinating with Alex and application support in enabling Objective upload for all customers. Objective upload process was deployed without major issues for Google and extended to Meta which was very critical.
                  
                  You were also contributing to test coverage improvements and demonstrated TTD during Objective upload development.
                  
                  In Q3, focus on
                - Successful migration of all customers to Objective Upload
                - Conversion Goal Automation design and development
                - Domain knowledge - we are having sessions by Senthil in Q3, expecting your active participation. You can use Adobe learning opportunities for the same
                  
                  Module Ownership:
                  
                  As a team we are working on improving the code quality and product experience and hence Issue early detection is crucial. Please make sure to respond to the alerts (call/ mail/slack) from Production/ Staging for the owned modules.
                  
                  Proactive monitoring and fixing is expected.
                  
                  Thanks,
                  
                  Ravi
        - Year End
            - Conversion Upload at objective level design and implementation
                - Diagrams
                  collapsed:: true
                    - {{renderer :drawio, 1782729159859.svg}}
                - Expected Benefits and observed results:
                    - Prevent Team Detroit client attrition
                        - Manifestation: Team Detroit (c88) client is still with us
                    - Tech Debt Elimination, leading to higher reliability of this critical process.
                        - Manifestation: Discussed in in Modular Code Guidelines + Test Driven Development + Mentorship section below:
                    - Ease of troubleshooting, ensuring client satisfaction
                        - Manifestation: Runbook with detailed instructions, which builds up on Book keeping tables and Re-run guide. The Old process had significant toil in re-running a failed instance. And the new process' ServiceNow alerts were successfully handed over to the App-Support Team On-call without any complaints from them.
                    - Reduction in the number of Conversion Trackers created in the Advertising Networks system, preventing failures related to limit breach.
                        - Manifestation: In the Old Portfolio-id Format, the client Team Detroit had exhausted the 1000 Trackers Limit in Google Ads platform. After they were migrated to the new Conversion Tracker format, this number shrunk down significantly to less than 100
            - Modular Code Guidelines + Test Driven Development + Mentorship
                - Expected benefits and observed results:
                    - High Velocity + Very little leakage of bugs in Production during accommodation of new requirements or code refactoring (Due to high test coverage + comprehensible code structure)
                        - Manifestation:
                            - For [[Conversion Upload at objective level]] a lot of lines of code had been pushed to production via these Pull Requests, after the Beta Release 12 PR's. Many of these are pure refactor PR's whose only test plan is "to ensure unit tests are passing" and which wouldn't have been attempted if there was no robust test coverage (especially [PR12](https://git.corp.adobe.com/AMO/cv-server/pull/13044) which has 30+ file changes)
                                - Key changes:
                                    - Conversion Adjustment flow
                                    - Conversion Consent Upload
                                    - Facebook Conversion Upload enablement
                                    - 6hr -> Hourly Conversion Upload enablement
                                    - Observability improvements
                                        - UserAccountAndFile obj observability improvement (structured logging)
                                        - click_id level Book keeping tables for further debuggability
                                    - Minor refactorings
                                    - Pulling out common classes for re-use with Conversion Goal Automation
                                    - New CLI param addition for on-call re-trigger (--file-path)
                                    - Smarter File re-upload Logic
                                    - Unprocessed Feeds Monitoring
                                    - Conversion Restatement Backfill Enablement
                            - Component Reuse
                                - For Conversion Goal Automation
                - Mentorship
                    - Mentored [[Anchal]] in TDD. Her improvements:
                        - She demonstrated her adeptness with TDD in Enhanced Conversion For Leads project.
                        - Involved Preethi in LLD of Conversion Goal Automation components (effects will manifest next year) as the project was parked
                - Unit Test Infrastructure improvements
                    - Provided roadmap via Unit Test Infrastructure improvement Epic and Unit Test Directory structure proposal which catalyzed the improved unit tests job
                    - Benefit Manifestation: the Unit Tests job performs Verification of unit tests and blocking of PR's that introduce regression bug, thereby increase the reliability of feature releases (As unit test coverage increases, better the realization of this benefit)
            - Conversion Goal Automation design and implementation (was put on hold due to other priorities, leaves etc.) (High level design, low level designs and Conversion Tracker Creator component is ready though)
                - Extensive discussions with Product Team (Anubhav, Alex) and distillation of them in HLD and LLD's and development roadmap
            - On-call Process improvement
                - Conducted Manager and Team member interviews to gather the problems being currently faced.
                - Came up with the On-call Process Improvement Charter, which lists down the problems noted, their negative impact to business and the solutions, including the On-call Squad formation
            - Manager's Summary:
                - Hi Amrullah,
                  Congratulations on your promotion to **Computer Scientist II**!
                  It was great discussing the 2024 projects, key focus areas, and your goals for 2025.
                - ###
                - Key Takeaways from Our Conversation
                    - Strengths & Highlights:
                        - Your ability to collaborate with multiple stakeholders, identify use cases, and apply them effectively in design and execution was well demonstrated during the Objective Upload Migration.
                        - You successfully adopted Test-Driven Development (TDD) for objective upload and mentored Anchal on the same, enhancing team productivity and improving code coverage.
                    - Your peers also appreciate you for:
                        - Proactively seeking feedback on challenges faced during on-call and improving runbooks to support the on-call and app support teams.
                        - Taking the initiative to promote coding standards within the team.
                    - Focus Areas for Growth:
                        - Bring closure to initiatives like enforcing TDD for new projects and improving code coverage. Identify roadblocks and work on solutions to address them effectively.
                        - Strengthen your ability to handle multiple tasks simultaneously, a crucial skill as a team lead.
        -
    - 2025
      collapsed:: true
        - Mid Year
            - Rest-api Python 2-3 Migration
                - Has been completed on time with very few hiccups and no customer reported incidents
            - On-Call Documentation
                - Contributed to the On-call Speed Dial by grouping helpful wikis under it's banner.
            - Splunk Alerts Enhancement
                - 4 out of 20 Splunk Alerts have been improved (with Runbook Links, and other useful info that aids in investigation by reducing toil)
                - 1 redundant alert deleted
            - TDD Team Adoption
                - The measure of success of this goal is "50% of new projects should be developed with TDD", has been far exceeded thanks to enforcement of writing unit tests for PR approval. My contribution to this setup was to streamline the process of asking for exemptions by creating **unit-test-exemption-requests** channel, help wiki (what to do if your PR is blocked by Unit Test Pipeline) and through guidance to Coverage Pipeline job owners on which kind of exemption requests to approve and which ones to do deny. This prevented any potential derailment of the broader Unit-Tests initiative, which could have occurred as a result of lack of trust upon the reliability of Unit-Test Coverage job.
            - Hourly conversion Upload (Not Explicitly Assigned to me)
                - Provided support during Design and implementation phases with helpful review comments:
                - Also prevented a potential Tech Debt introduction in Example 3 (guarded the immutability of UserAccountAndFile object)
                - Discernible Design and High Unit test coverage of the Conversion Upload codebase indirectly contributed to a relatively error-free implementation of enhancements like Hourly Conversion Upload and it's Monitoring dashboard. (the customer outage was due to performance aspect at the Data side and is outside the scope of TDD)
                - @measure_time decorator written 2 years ago came in handy to observe performance of Conversion Upload process
    - 2026
        - Python 2-3 Migration:
            - Portfolio Managemnt Py2 REST API's to Py3: Done
            - Portfolio Management RPC's to REST API Py3: Beta Rollout stage => Delivered GA
            - Algo modules Migration -> Delivered tools to help beta-rollout => GA
              id:: 6a411f2b-0f06-4f66-ae3a-8d709260fb3a
        - Conversion Upload Data Monitoring
            - Publishing conversion numbers to Splunk is enabled on Production
            - Constructing meaningful alerts on top of it is a work in progress