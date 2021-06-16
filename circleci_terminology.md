# CircleCI Terminology

## About CircleCI
CircleCI is a continuous integration and delivery platform that aids software teams by automating the build, test, and deploy process.

## What are Orbs? 
CircleCI orbs are open-source, shareable packages of parameterizable reusable configuration elements, including jobs, commands, and executors. Use orbs to reduce configuration complexity and help you integrate with your software and services stack quickly and easily across many projects.

## Public vs Private Orbs
CircleCI offers an organization the option to create public and private orbs. Public orbs allow an organization to publish their orbs to the CircleCI Orb Registry. Using a public orb enables all CircleCI users to access and use your orb in their own configurations. Private orbs allow you to author an orb that ensures your orb does not appear on the CircleCI Orb Registry. In addition, your orb cannot be viewed or used by someone outside of your organization and your orb cannot be used in a pipeline that does not belong to your organization. 

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

## Parallelism

The more tests your project has, the longer it will take for them to complete on a single machine. To reduce this time, you can run tests in parallel by spreading them across multiple separate executors. This requires specifying a parallelism level to define how many separate executors get spun up for the test job. Then, you can use either the CircleCI CLI to split test files, or use environment variables to configure each parallel machine individually.
