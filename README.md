# Overview

This proof of concept (POC) shows you how to configure a CircleCI pipeline for a sample blog application that combines the power of Spring Boot and Kotlin. Within this pipeline: test, build, and deploy a Docker image to a private repository on Amazon’s Elastic Container Registry. Additionally, this POC demonstrates pulling down this image and deploying it to EKS, where the blog application can be accessed on port 8080. 

<p align="center">
    <img src="https://raw.githubusercontent.com/liatrio/circleci-pipeline-poc/master/images/jobflow_small.png">
</p>

## Contents

* ### <a href="https://github.com/liatrio/circleci-pipeline-poc/blob/master/docs/app_documentation.adoc" target="_top">Source Project Readme</a>

* ### <a href="https://github.com/spring-guides/tut-spring-boot-kotlin" target="_top">Source Project Link</a>

* ### <a href="https://github.com/liatrio/circleci-pipeline-poc/blob/master/docs/best_practices.md" target="_top">Orb Best Practices</a>

* ### <a href="https://github.com/liatrio/circleci-pipeline-poc/blob/master/docs/persisting_data.md" target="_top">Persisting Data</a>

* ### <a href="https://github.com/liatrio/circleci-pipeline-poc/blob/master/docs/circleci_terminology.md" target="_top">CircleCI Usage / Overview</a>

* ### <a href="https://circleci.com/developer/orbs/orb/liatrio-poc/circleci-orb-poc" target="_top">POC Orb and Usage on CircleCI's Orb Registry</a>
