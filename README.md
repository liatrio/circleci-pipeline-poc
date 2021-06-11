# Overview

Source project: https://github.com/spring-guides/tut-spring-boot-kotlin

This proof of concept (POC) shows you how to configure a CircleCI pipeline for a sample blog application that combines the power of Spring Boot and Kotlin. Within this pipeline: test, build, and deploy a Docker image to a private repository on Amazon’s Elastic Container Registry. Additionally, this POC demonstrates pulling down this image and deploying it to EKS, where the blog application can be accessed on port 8080.

