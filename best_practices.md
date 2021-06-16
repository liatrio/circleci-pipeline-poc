## Orb Authoring Best Practices

Below are some best practices for authroing orbs that we think are the most important to understand when authoring your first orb. For more detail and the complete list of CircleCI orb authoring best practices visit this link: https://circleci.com/docs/2.0/orbs-best-practices

*General*

* Give your orb a descriptive name
    - The orb "slug" consists of a namespace and an orb name seperated by a forward slash: "company/orb"

* Categorize your orb
    - Allows your orb to be searchable on the Orb Registry. The documentation for categorizing your orb can be found here: https://circleci.com/docs/2.0/orb-author/#categorizing-your-orb

* Ensure all orb components include descriptions
    - Jobs, commands, executors and parameters can accept descriptions.

* All public orbs should contain one usage example
    - Orb Usage Examples provide an excellent way for orb developers to share use-cases and best practices with the community.

*Commands*

* Most orbs have at least one command 

* Use the minimal number of steps required
    - To limit the amount of noise in the UI, try to use as few steps as possible

*Jobs* 

* Consider pass through paramaters
    - If you are using commands or executors, you must include a copy of each parameter from those components into your job. Then, you can "pass-through" the parameters in the job to each referenced component. 

* Consider post and pre steps, and step parameters
    - Jobs on CircleCI can have steps injected into them, either before or after the job, or somewhere in-between with the use of parameters. Injectable steps allow for more flexibility in jobs and may allow new functionalities in your orb. For more info on pre and post steps see https://circleci.com/docs/2.0/configuration-reference/#pre-steps-and-post-steps-requires-version-21. 

