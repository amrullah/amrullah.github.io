filters:: {"templates" false}
type:: [[Book]]
subtitle::
alias::
subject::
author:: [[Don Norman]] 
tags::

- # 1.  The Seven Fundamental principles of Interaction
- ## 1.1.  Discoverability
- What this machine does? How does it work? What operations are possible?
- Generated from:
    - Affordances
    - Signifiers
    - Constraints
    - Mappings
    - Feedback
    - Conceptual Model
- > **Design Principle**
  Is it possible to determine what actions are possible and the current state of the device?
    -
- ## 1.2.  Affordances
- Colloquially, an affordance is a resource or support that the environment offers a person or an animal (or any agent for that matter, even non living).
- An Affordance is a relationship between the properties of an object and the capabilities of an agent. So it's presence is determined by jointly by both.
- Affordances determine what actions are possible.
- Anti-affordance is a means to prevent an interaction.
- If an affordance or anti-affordance is not perceivable, then some means of signalling it's presence is required, ie. Signifier
- > **Design Principle**
  Do the proper affordances exist to make the desired actions possible?
- ## 1.3.  Signifiers
- Signifier is any mark or sound or any perceivable indicator that communicates appropriate behavior to a person.
- Affordances determine what actions are possible. Signifiers communicate where the action should take place.
- Good Design requires good communication of purpose, structure and operation of the device.
- > **Design Principle**
  Effective use of signifiers ensures discoverability and that the feedback is well communicated and intelligible
- ## 1.4.  Constraints
- Constraints are a means of correctly guiding the actions, reducing the things to remember, and preventing undesirable or destructive actions from taking place.
- Types of Constraints
    - Physical
    - Logical
    - Semantic
    - Cultural
- **Forcing Functions**
    - Forcing Functions are a form of physical constraint, using which, failure at one stage prevents actions in next stage from occurring.
    - Examples:
        - Interlock: Force operations to take place in proper sequence. Example: Prevent disassembling a device before turning off the power.
        - Lock in: Force keeping an operation active, prevent premature stopping of it. Example: Prevent exiting an application before saving work.
        - Lock out:  Keep people out of a dangerous place or prevent an event from occurring. Example: The pin that prevents a fire extinguisher from accidental discharge.
    - Caution:
      Forcing functions can be a nuisance in normal usage. People may try to deliberately disable them, negating their safety feature. A clever designer has to minimize the nuisance value, while retaining the safety feature.
- > **Design Principle**
  Providing physical, logical, semantic and cultural constraints, guides actions and eases the interpretation.
- ## 1.5.  Mappings
- In Mathematics, Mapping means relationship between elements of two sets.
- When mapping uses spatial correspondence between layout of the controls and the devices being controlled, it is easy to determine how to use them. For example, movement of steering wheel.
- Grouping (related controls together), Patterning, Proximity (of control to the item being controlled).
- A device is easy to use when the set of possible actions is visible and when the controls and displays exploit natural mappings.
- > **Design Principle**
  The relationship between controls and their actions should follow the principle of good mapping. Enhanced as much as possible through spatial layout and temporal contiguity.
- ## 1.6.  Feedback
- Some way of letting the agent know that the system is working on the request provided to it and/or communicating the result of an action
- Should be immediate and informative.
- Poor feedback can be worse than no feedback, because it is distracting, uninformative, or even  irritating and anxiety provoking.
- Too much feedback can be more annoying than too little. It can lead to desensitization.
- > **Design Principle**
  There should be full and continuous information about the results of actions and the current state of the product.
- ## 1.7.  Conceptual Model
- It is a usually simplified explanation of how something works.
- Mental Models are the conceptual models in people's minds that represent their understanding. It can vary from person to person.
- The major clues of how things work comes from their perceived structure - in particular from signifiers, affordances, constraints and mappings.
- The conceptual model enhances both, the discoverability and evaluation of results.
- Good conceptual models are the key to understandable, enjoyable products. And good communication is key to a good conceptual model.
- > **Design Principle**
  The design should project all the information needed to a create good conceptual model of the system. This leads to understanding and feeling of control.
- # 2.  The Psychology of Design
- ## 2.1.  Gulf of Execution 
  
  Reflects the amount of effort required to figure out how a device operates (what can be done and how?)
- ### 2.1.1.  Things that help with Gulf of Execution
- Signifiers
- Constraints
- Mappings
- Good Conceptual Model
- ## 2.2.  Gulf of evaluation 
  
  Reflects the amount of effort that a person must exert to interpret the state of the device and to determine how well the expectations and intentions have been met.
- ### 2.2.1.  Things that help with Gulf of Evaluation
- Feedback
- Good Conceptual Model
- ## 2.3.  Schematic representation
- {{renderer :drawio, 1782667105781.svg}}
- # 3.  Errors 
  
  Any deviance from "appropriate" behavior. In many circumstances, the appropriate is not known or only determined after the fact.
- ## 3.1.  Types of Errors
- ### 3.1.1.  Slips 
  
  A slip occurs when a person intends to do one action and ends up doing something else. Slips happen in the execution of the plan or in perception or in interpretation of the outcome.
- #### 3.1.1.1.  Action based slips
- Performance of wrong action.
- Example: Pouring some milk into the coffee cup and putting the cup in the refrigerator (instead of milk)
- #### 3.1.1.2.   Memory Lapse slips
- Intended action is not done or it's result not evaluated.
- Examples:
    - Failing to do all the steps of a procedure
    - Forgetting the outcome of an action
    - Repeating steps
    - Forgetting the goal or plan
- Some ways to combat memory lapse errors:
    - Minimize the number of steps.
    - Provide vivid reminders of steps that need to be completed.
    - Forcing Function. Example: ATM machines require removal of card before the cash is handed out.
- **Classification of Slips:**
- #### 3.1.1.3.  Capture Slips
- Situation where instead of the desired activity, a more frequently or recently performed activity gets done. It "captures" the activity.
- Designers need to avoid procedures that have identical opening steps but then diverge. The more experienced the worker, the more likely they are to fall prey to capture.
- #### 3.1.1.4.  Description Similarity Slips
- To act upon an item similar to the target. This happens when the description of the target in people's heads is sufficiently vague.
- This error results in performing the correct action on the wrong object. The more the wrong and the right object have in common or more those objects are visible at the same time, the more likely this error is to occur.
- Designers need to ensure that the controls and displays for different purposes are significantly different from one another.
- #### 3.1.1.5.  Mode Slips
- A mode error occurs when a device has different states in which the same controls have different meanings.
- Mode errors are inevitable in anything that has more possible actions than it has controls or displays, that is, the controls mean different things in different modes.
- ### 3.1.2.  Mistakes 
  
  Mistakes result from poor choice of inappropriate goals and plans or from faulty comparison of the outcome with goals during evaluation. In mistakes, a person makes poor decision, misclassifies a situation or fails to take all relevant factors into account.
- #### 3.1.2.1.  Rule based Mistake
- Appropriate Diagnosis of the situation but erroneous course of action. The wrong rule is being followed.
- Rule based mistakes occur in several ways:
    - The situation is mistakenly interpreted, thereby invoking wrong goal or plan.
    - The correct rule is invoked, but the rule itself is faulty. Either because it was formulated improperly, or the conditions are different than assumed, or through incomplete knowledge used to determine the rule.
    - The correct rule is invoked but the outcome is incorrectly evaluated.
- Remedies:
    - Provide as much guidance as possible to ensure that the current state of things is displayed in a coherent and easily interpreted manner. Ideally graphical.
- #### 3.1.2.2.  Knowledge based mistake
- The problem is misdiagnosed because of erroneous or incomplete knowledge.
- Knowledge based behavior occurs when the situation is novel enough that there are no skills or rules to cover it.
- #### 3.1.2.3.  Memory Lapse mistake
- When there's a forgetting at the goals, plans or evaluation.
- ## 3.2.  The Swiss Cheese Model of Accidents 
  
  [James Reason](https://en.wikipedia.org/wiki/James_Reason), an Accident Researcher introduced the [Swiss Cheese Model](https://en.wikipedia.org/wiki/Swiss_cheese_model) of accidents, where:
- **Slices** of cheese represent the **stages** of a process or safety check **layers** or defensive layers.
- **Holes** represent opportunities for slips, mistakes, chances of failure or malfunction or any other such **weaknesses**.
- Diagram:
  collapsed:: true
    - ![Covid-19-Cheese-Model-animation-02-short.gif](../assets/Covid-19-Cheese-Model-animation-02-short_1782667315953_0.gif)
- ### 3.2.1.  According to this model:
- The Accident can happens only if the **holes** of various slices **align** perfectly. Ie. mistakes pass through multiple layers of defence. Normally in a well designed and resilient system, mistakes wouldn’t be able to pass through several stages and lead to an accident.
- Frequent occurrences of accidents indicate numerous and large holes in the cheese slices (stages of process or layers of defence).
- Usually there’s **no** **single** **root cause** of an accident. There are several **contributing factors**.
- ### 3.2.2.  To Reduce the chances of Accidents, try to:
- **Add more slices** of cheese, that is, more checks, defensive layers, sanity check layers etc.) in the process.
- **Eliminate holes**, that is, remove the need of human input or action or block erroneous operation by introducing constraint etc.
- If a hole cannot be eliminated, then, try to **reduce the size of the hole**. For example, if an automated safety check cannot be added, then may be have two people perform an operation whereby there are more than one pair of eyes carefully examining and verifying the sequence of actions.
- ### 3.2.3.  Also see:
  collapsed:: true
    - {{video https://youtu.be/MfWpMrEOlJ8?si=lB9BIiXAlbl0QceN}}
    -
- ## 3.3.  Designing for error
- Understand the causes of error and design to minimize those causes.
- Do sensibility checks. Ask, does the action passes the "common sense" test?
- Make it possible to reverse the actions (undo) or make it harder to do what cannot be reversed.
- Make it easier for people to discover the errors that occur and make them easier to correct.
- Don't treat the action as an error, rather try to help the person complete the action properly.
- A major source of error, especially memory lapse errors, is interruption. When an activity is interrupted by some other event, to resume it is necessary to remember the previous state of the activity precisely:
    - What the goal was.
    - Where was one in the action sequence.
    - The relevant state of the system.
- Many systems make it difficult to resume after an interruption. They discard critical information that is needed by the user to remember:
    - The small decisions that had been made.
    - The things that were in the person's short term memory
    - Current state of the system.
- ### 3.3.1.  Design lessons from the study of errors
- Preventing before they occur, correcting them when they do.
- Adding Constraints to block errors:
    - Prevention often involves adding specific constraints to actions.
    - Segregating controls so that easily confused controls are far from one another
- Undo:
    - The best systems have multiple levels of undoing, so it is possible to undo an entire sequence of actions.
- Confirmation and Error messages:
    - The request for confirmation seems like an irritant rather than an essential safety check, because the persone tends to focus upon the action rather than the object that is being acted upon.
    - A better option would be a prominent display of both, the action and the object being acted upon, perhaps with a choice of "cancel" and "do it".
    - The important is making salient (prominent) what the implications of the actions are.
- Sensibility Checks:
    - Operations involving medical machines or sums of money can benefit from sensibility checks.
- Minimizing slips:
    - Slips most frequently occur when the consious mind is distracted, or if the action is so well learnt that it can be done automatically.
    - Many slips can be minimized by ensuring that the actions and their controls are as dissimilar to each other as possible or at least physically far apart.
    - Mode errors can be minimized by reducing the number of modes or making modes distinct from each other.
    - The best way of mitigating slips is to provide perceptible feedback about the nature of action being performed and very perceptible feedback describing the new state, coupled with a mechanism that allows the error to be undone.
    - Rows of identical controls or meters is a sure shot recipe for description similarity errors.
    - Internal modes that are not very clearly marked are a clear driver of mode errors
    - Situations with numerous interruptions, yet where the design assumes undivided attention, is clear enabler of memory lapses.
    - Failure to provide assistance and visible reminders for performing infrequent procedures that are similar to more frequent procedures, leads to capture errors. Procedures should be designed such that their initial steps are as dissimilar as possible.
- ## 3.4.   Design Principles for dealing with error
- People are flexible, versatile and creative. Machines are rigid, precise and relatively fixed.
- Difficulties arise when we don't think of people and machines as a collaborative system. And naively assign automatable tasks to machines and leave the rest to the people.
- This requires people to behave in machine like fashion.
- We expect people to monitor machines, which means keeping alert for long periods, something we are bad at.
- We require people to do repeated operations with extreme precision required by machines, again something we are bad at.
- When we divide up the machine and human components this way, we fail to take advantage of human strengths and capabilities, but instead rely upon areas where we are genetically and biologically unsuited. And yet, when people fail, they are blamed.
- Errors are inevitable. The best designers take that fact as a given and seek to minimize the opportunities for errors while also trying to mitigate their consequences.
- # 4.  Summarized Design Principles
- Put the knowledge required to operate the technology in the world. Allow for efficient operation when people have become experts and can perform without the knowledge in the world.
- Use the power of natural and artificial constraints: physical, logical, semantic and cultural. Exploit the power of forcing functions and natural mappings.
- Bridge the two Gulfs. Make things visible (or perceptible through other media), both for Execution and Evaluation.
    - On the Execution side: provide feedforward information - make the options readily available and discoverable.
    - On the Evaluation side: provide the feedback: make the result of each action readily apparent.
- Make it possible to determine the system status readily, easily, accurately and in a form consistent with the person's goals, plans and expectations.
- # 5.  The Harms of Bad Design