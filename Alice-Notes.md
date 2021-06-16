# CircleCI

## Basic Configuration

### Jobs

Jobs are CircleCI's basic way of defining a set of steps that should be carried
out as part of a pipeline process. Because multiple jobs can be run in a single
workflow, a single job can be used to define one step in a CI process.

Jobs define information about what executor to use while running, in addition
to defining the steps that make up the job. Job parameters can also be specified
to help make jobs more reusable. Any parameters specified will either need to
be given a default value, or else they will be required. When a job is used in
a workflow, any parameters can be passed in at that time.

Job steps are defined as a series of actions to take until one fails or the job
completes. The steps can be either built-in steps, scripts which execute with
the job's shell, or pre-defined commands.

### Workflows

Workflows provide the entrypoint for CI/CD execution within CircleCI. A workflow
is made up of a collection of jobs, each of which runs as part of the workflow.

Each job can function like a stage in a pipeline, however, unlike some other
CI tools, workflow jobs are run in parallel by default and any ordering of
jobs, such as requiring testing to pass before deployment needs to be
explicitly specified.

Workflows also allow for specifying triggering conditions. By default pipelines
are triggered on push to the pipelines repo. Different build triggers, such as
a time based trigger can be specified instead.

Because workflows are triggered by default on any code push, they can use
filtering configurations to limit what jobs run on any given push. For example,
a deployment job may be filtered to run only when code is pushed to the 'main'
branch, whereas a linting job may run on every push.

#### Example

```yml
workflows:
  version: 2
  example-workflow:
    jobs:
    - build
    - lint
    - test:
        requires:
        - build
    - deploy:
        requires:
        - build
        - lint
        - test
        filters:
          branches:
            only:
            - main
```

## Orbs

Orbs allow for CircleCI configurations to be reused in different CI workflows, or for standard patterns for integrating with tools to be distributed. Orbs work like libraries which can be imported into a configuration where the preconfigured commands, executors, and jobs can then be used as needed.
For example, a workflow that needs to login to AWS and publish a Docker image to ECR might use the functionality in an `aws-ecr` orb, which could contain the logic for authenticating to, and interacting with ECR, functionality which can be defined in one place, and then used in many different workflows.

### Orb Registry

In CircleCI cloud, Orbs can be found in the [Orb Registry](https://circleci.com/developer/orbs). Orbs from the registry are prefixed with a namespace, denoting the organization which published and maintains the Orb, and suffixed with a semantic version number, such as `circleci/node@1.0.0`.
There are three main types of Orbs in the registry, certified (Written by CircleCI), partner (Written by technology partners), and community (Written by CircleCI users). By default CircleCI won’t allow workflows to use uncertified Orbs, this functionality must be manually enabled within a CircleCI organization.

### Custom Orbs

As mentioned, the Orb Registry contains Orbs written and maintained by the community, which also means that users can write their own Orbs and publish them to the Registry. This process entails pulling the reusable configuration, such as jobs, commands, and executors out of a pipeline configuration, and moving them to their own Orb repo. Using a special pipeline, that Orb configuration can then be published to the Registry, before being imported into the pipelines where it is required.

Orbs can be published as either public or private. Public Orbs can be published freely (although there are restrictions on deleting them) and they are the community providers listed on the Orb registry. Private Orbs are limited based on what payment plan is in use, they allow for Orbs which can be published and used within an organization, but which are not accessible outside of that organization.

### Example

```yml
orbs:
  aws-ecr: circleci/aws-ecr@7.0.0
version: 2.1
workflows:
  build_and_push_image:
    jobs:
      - aws-ecr/build-and-push-image:
          account-url: AWS_ECR_ACCOUNT_URL_ENV_VAR_NAME
          aws-access-key-id: ACCESS_KEY_ID_ENV_VAR_NAME
          aws-secret-access-key: SECRET_ACCESS_KEY_ENV_VAR_NAME
          context: myContext
          create-repo: true
          dockerfile: myDockerfile
          no-output-timeout: 20m
          path: pathToMyDockerfile
          profile-name: myProfileName
          region: AWS_REGION_ENV_VAR_NAME
          repo: myECRRepository
          skip-when-tags-exist: false
          tag: 'latest,myECRRepoTag'
```
