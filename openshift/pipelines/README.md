# Pipelines

What is the problem? you don't just have 1 pipeline, you are joining multiple pipelines together like cutting a paper from opposite ends to meet in the middle.

## Machine Learning Pipelines
An ML Pipepline is a software architecture for automating, monitoring, and maintaining from data to trained model.

In Machine Learning, Pipelines are usually Directed Acyclic Graphs (DAGs). Simply put, they are sequencing of tasks to  be performed based on dependencies and support automation.

## Common ML Pipeline tools:
1. TensorFlow Extended (TFX) Pipeline
1. KubeFlow
1. Airflow
1. Argo
1. Luigi
1. Celery

## Pipeline Steps
1. Data Ingestion
1. Data Validation
1. Feature Engineering
1. Model Training
1. Model Validation
1. Model Push
1. Model Serving
1. Model Observation


## Cloud Native Pipelines
A Cloud Native Pipeline

Ultimately, an end-to-end construct that orchtestrates the flow of data into, the output from, a machine learning model or set of models. It is the core of enterprise AI.

## RH OpenShift Pipelines
cloud-native continuous integration and continuous delivery (CI/CD) K8s solution.

### Based on Tekton, which provides:
- standard K8s-native pipeline definitions. Easy to extend, integrate with other K8s tools and scale on-demand.
- Serverless pipelines with no CI server management overhead. All the required dependencies are isolated in containers.
- Designed for decentralized teams to work on microservice architectures
- Build using tools: s2i, Buildah, Buildpacks, JIB, Kaniko
- Portable across environments
- Powerful CLI
- Integrated UX in Developer perspective to manage and view pipelines
- Works in restricted network environments

## Concepts:
1. Pipeline. A collection of Task resources arranged in a specific order of execution. Used to automate the build, deployment and delivery of applications.
1. PipelineRun. A type of resource that binds a pipeline, workspace, credential, and set of parameter values toa scenario to run the CI/CD workflow. It is the running instance of a pipeline.
1. Tasks. Building blocks of a pipeline and consists of sequential steps. Executed individually or sequentially. Reusable. Runs in a Pod.
1. TasksRun. Executes the Steps in a Task in the specific order, until all Steps are Succeeded or Failed. Autocreated for each Task in a Pipeline.
1. Steps. Series of commands that are sequentially executed by the task. Achieve a specific goal, like building an image. Runs as a Container in a Pod. Can access the same volumes for caching files, config maps, and secrets.
1. When expression. Guards task execution by setting criteria for the execution of tasks within a pipeline. Only run when certain criteria are met.
1. Finally tasks. Always executes the tasks within the pipeline, irrespective if the pipelines runs are successful or not (e.g. cleanup).
1. Workspace. In place of PipelineResources. Declare shared volumes that a tasks needs at runtime. Store tasks inputs/out, share data among Tasks, use as a mount point for credentials, common tools, cache build artifcates for faster job completion.
1. Triggers. Capture the external events, like Git pull requests and process them. Automate the process by capturing and processing any change event. 

## Securing the Pipeline:
1. Authenticating Pipelines.
1. Use trusted container images.
1. Secure routes.
1. Re-encryption Termination.

## Installing
Pre-requisites: cluster-admin permissions, install the oc CLI, installed the tkn CLI.

Optional configs:
1. Lite: installs Tekton Pipelines only.
1. Basic: installs Tekton Pipelines and Tekton Triggers.
1. All: installs Tekton Pipelines, Tekton Triggers, Tekton Addons (ClusterTasks, ClusterTriggerBindings, ConsoleCLIDownload, ConsoleQuickStart, ConsoleYAMLSample)

1. Administrator
1. Operators
1. OperatorHub
1. Search for `Red Hat OpenShift Pipelines'
1. Install

