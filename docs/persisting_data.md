# Persisting Data in Workflows

CircleCI provides a number of different ways to move data into and out of jobs, persist data, and with workspaces, move data between jobs. Using the right feature for the right task will help speed up your builds, improve repeatability, and improve efficiency.

## How Data Flows Between CircleCI Jobs

Workspaces persist data between jobs in a single Workflow. Caching persists data between the same job in different Workflow builds. Artifacts persist data after a Workflow has finished.

**Workspaces**

<p align="center">
    <img src="https://production-cci-com.imgix.net/blog/media/Diagram-v3-Workspaces.png?ixlib=rb-3.2.1&auto=format&fit=max&q=60&ch=DPR%2CWidth%2CViewport-Width%2CSave-Data&w=1500">
</p>

When a workspace is declared in a job, one or more files or directories can be added. Each addition creates a new layer in the workspace filesystem. Downstream jobs can then use this workspace for its own needs or add more layers on top.

Unlike caching, workspaces are not shared between runs as they no longer exists once a workflow is complete. There is one exception, re-running workflows.


**Caching**

<p align="center">
    <img src="https://production-cci-com.imgix.net/blog/media/Diagram-v3-Cache.png?ixlib=rb-3.2.1&auto=format&fit=max&q=60&ch=DPR%2CWidth%2CViewport-Width%2CSave-Data&w=1500">
</p>

Caching lets you reuse the data from expensive fetch operations from previous jobs.

Jobs in one workflow can share caches. Note that this makes it possible to create race conditions in caching across different jobs in workflows.

Cache is immutable on write: once a cache is written for a particular key like node-cache-master, it cannot be written to again. Consider a workflow of 3 jobs, where Job3 depends on Job1 and Job2: {Job1, Job2} -> Job3. They all read and write to the same cache key.


#### Example Caching Configuration

```yml
    steps:
        - restore_cache:
            keys:
            - m2-{{ checksum "pom.xml" }}
            - m2- # used if checksum fails

```

**Artifacts**

<p align="center">
    <img src="https://production-cci-com.imgix.net/blog/media/Diagram-v3-Artifact.png?ixlib=rb-3.2.1&auto=format&fit=max&q=60&ch=DPR%2CWidth%2CViewport-Width%2CSave-Data&w=1500">
</p>

If a job produces persistent artifacts such as screenshots, coverage reports, core files, or deployment tarballs, CircleCI can automatically save and link them for you.

Find links to the artifacts under the “Artifacts” tab on the Job page. Artifacts are stored on Amazon S3 and are protected with your CircleCI account for private projects. There is a 3GB curl file size limit.

Artifacts will be accessible for thirty days after creation. If you are relying on them as a source of documentation or persistent content, we recommend deploying the output to a dedicated output target such as S3, or GitHub Pages or Netlify for static websites.

### Example Uploading Artifacts

```yml
    version: 2
    jobs:
    build:
        docker:
        - image: python:3.6.3-jessie
            auth:
            username: mydockerhub-user
            password: $DOCKERHUB_PASSWORD  # context / project UI env-var reference

        working_directory: /tmp
        steps:
        - run:
            name: Creating Dummy Artifacts
            command: |
                echo "my artifact file" > /tmp/artifact-1;
                mkdir /tmp/artifacts;
                echo "my artifact files in a dir" > /tmp/artifacts/artifact-2;

        - store_artifacts:
            path: /tmp/artifact-1
            destination: artifact-file

        - store_artifacts:
            path: /tmp/artifacts
```