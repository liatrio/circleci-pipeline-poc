# CircleCI Usage / Overview

## About CircleCI
CircleCI is a continuous integration and delivery platform that aids software teams by automating the build, test, and deploy process.

## What are Orbs? 
CircleCI orbs are open-source, shareable packages of parameterizable reusable configuration elements, including jobs, commands, and executors. Use orbs to reduce configuration complexity and help you integrate with your software and services stack quickly and easily across many projects.

## Private or Public Orbs. Which One to Choose?
If you have a paid plan you can create private orbs; private orbs are organization-centric. Performance plan customers can create up to three private orbs, whereas scale plan customers can create an unlimited number of private orbs. Private orbs are restricted your organization's pipelines and furthermore, can only be viewed and used by members of your organization. Private
orbs do not appear in CircleCI's Orb Registry.

A public orb appears in the Orb Registry and is available to all CircleCI to use in their own configurations.

There are no means of deleting an orb (public or private); an orb can only be unlisted. Note that unlisting an orb does not affect its ability to be referenced by name in builds or for its source to be viewed. 

*What Orbs Were Used and Why?*

* gradle: circleci/gradle@2.2.0
Gradle is utilized for testing the sample blog application.
* aws-cli: circleci/aws-cli@2.0.2
Allows a user to interface / authenticate with aws (ECR/EKS).
* aws-ecr: circleci/aws-ecr@7.0.0
For pushing and pulling images from an ECR repository.
* helm: circleci/helm@1.2.0
Managing the blog application in Kubernetes
* aws-eks: circleci/aws-eks@0.2.3=:
Installing the aws-iam-authenticator to authenticate with EKS. Installing the blog helm chart to the cluster.

*Executors*

An executor type defines the underlying technology or environment in which to run a job. CircleCI enables you to run jobs in one of four environments:
Within Docker images (type: docker 🐳) 
Within a Linux virtual machine (VM) image(type: machine)
Within a macOS image (type: macos)
Within a Windows VM image (type: windows)
	
*Jobs/Commands*

Jobs are collections of steps. All of the steps in the job are executed in a single unit, either within a fresh container or VM.
* Workspaces persist data between jobs in a single workflow
* Caching persists data between the same job in different workflows runs
* Artifacts persist data after a workflow has finished

A command definition defines a sequence of steps as a map to be executed in a job, enabling you to reuse a single command definition across multiple jobs.

*Workflow*

Workflows define a list of jobs and their run order. It is possible to run jobs concurrently, sequentially, on a schedule, or with a manual gate using an approval job.

## Environment Variables

CircleCI uses Bash, which follows the POSIX naming convention for environment variables. Valid characters include letters (uppercase and lowecase), digits, and the underscore. The first character of each environment variable must be a letter.

**Order of Precedence**

1. Environment variables declared [inside a shell command](https://circleci.com/docs/2.0/env-vars/?utm_medium=SEM&utm_source=gnb&utm_campaign=SEM-gb-DSA-Eng-uscan&utm_content=&utm_term=dynamicSearch-&gclid=CjwKCAjwwqaGBhBKEiwAMk-FtP2pJHZDeyiG2fVZvPpKvY22atmSQshCc4kODA2RV4uXxVwm_-iKZxoCr40QAvD_BwE#setting-an-environment-variable-in-a-shell-command) in a run step
2. Environment variables declared with the environment key [for a run step](https://circleci.com/docs/2.0/env-vars/?utm_medium=SEM&utm_source=gnb&utm_campaign=SEM-gb-DSA-Eng-uscan&utm_content=&utm_term=dynamicSearch-&gclid=CjwKCAjwwqaGBhBKEiwAMk-FtP2pJHZDeyiG2fVZvPpKvY22atmSQshCc4kODA2RV4uXxVwm_-iKZxoCr40QAvD_BwE#setting-an-environment-variable-in-a-step)
3. Environment variables set with the environment key [for a job](https://circleci.com/docs/2.0/env-vars/?utm_medium=SEM&utm_source=gnb&utm_campaign=SEM-gb-DSA-Eng-uscan&utm_content=&utm_term=dynamicSearch-&gclid=CjwKCAjwwqaGBhBKEiwAMk-FtP2pJHZDeyiG2fVZvPpKvY22atmSQshCc4kODA2RV4uXxVwm_-iKZxoCr40QAvD_BwE#setting-an-environment-variable-in-a-job)
4. Special CircleCI environment variables defined in the [CircleCI Built-in Environment Variables](https://circleci.com/docs/2.0/env-vars/?utm_medium=SEM&utm_source=gnb&utm_campaign=SEM-gb-DSA-Eng-uscan&utm_content=&utm_term=dynamicSearch-&gclid=CjwKCAjwwqaGBhBKEiwAMk-FtP2pJHZDeyiG2fVZvPpKvY22atmSQshCc4kODA2RV4uXxVwm_-iKZxoCr40QAvD_BwE#built-in-environment-variables) section
5. [Context](https://circleci.com/docs/2.0/contexts/) environment variables (assuming the user has access to the Context) 
6. [Project-level environment variables](https://circleci.com/docs/2.0/env-vars/?utm_medium=SEM&utm_source=gnb&utm_campaign=SEM-gb-DSA-Eng-uscan&utm_content=&utm_term=dynamicSearch-&gclid=CjwKCAjwwqaGBhBKEiwAMk-FtP2pJHZDeyiG2fVZvPpKvY22atmSQshCc4kODA2RV4uXxVwm_-iKZxoCr40QAvD_BwE#setting-an-environment-variable-in-a-project) set on the Project Settings page

*NOTE*: Environment variables declared inside a shell command run step will override environment variables declared with the environment and contexts keys. Environment variables added on the Contexts page will take precedence over variables added on the Project Settings page.

**Security**

Do not add secrets or keys inside the *.circleci/config.yml* file. The full text of *config.yml* is visible to developers with access to your project on CircleCI. Store secrets or keys in project or context settings in the CircleCI app. For more information, see [Encryption](https://circleci.com/docs/2.0/security/#encryption) section of the Security document.

## Parallelism

The more tests your project has, the longer it will take for them to complete on a single machine. To reduce this time, you can run tests in parallel by spreading them across multiple separate executors. This requires specifying a parallelism level to define how many separate executors get spun up for the test job. Then, you can use either the CircleCI CLI to split test files, or use environment variables to configure each parallel machine individually.
