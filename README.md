# hello-iOS

This quickstart aims at helping you develop an iOS app using Hasura as your backend.

## Sections

* [Introduction](#introduction)
* [Quickstart](#quickstart)
* [Data API](#data-apis)
* [Auth API](#auth-apis)
* [Filestore API](#filestore-apis)
* [Custom service](#custom-service)
* [Migrate from an existing react app](#migrate-from-an-existing-react-app)
* [Local development](#local-development)
* [Project Structure](#project-structure)
* [FAQ](#faq)

## Introduction

This quickstart project comes with the following by default:
1. A basic hasura project
2. Two tables `article` and `author` with some dummy data in it
3. A basic iOS app which uses the auth, data and filestore apis provided by Hasura
4. A basic nodejs-express app which runs on the `api` subdomain.

The iOS app utilizes the various apis provided by hasura.

## Quickstart

Follow this section to get this project working. Before you begin, ensure you have the latest version of hasura cli tool installed.

### Step 1: Getting the project

```sh
$ hasura quickstart hello-iOS
$ cd hello-react
```

The above command does the following:
1. Creates a new folder in the current working directory called `hello-iOS`
2. Creates a new trial hasura cluster for you and sets that cluster as the default cluster for this project
3. Initializes `hello-iOS` as a git repository and adds the necessary git remotes.
4. Has the source code for a simple iOS app inside the hello-iOS directory called `iOS-app`.

### Step 2: Getting cluster information

Every hasura project is run on a Hasura cluster. To get details about the cluster this project is running on:

```sh
$ hasura cluster status
```

This will give you your cluster status like so

```sh
INFO Status:                                      
Cluster Name:       h34-excise98-stg
Cluster Alias:      hasura
Kube Context:       h34-excise98-stg
Platform Version:   v0.15.8
Cluster State:      Synced
```

Keep a note of your cluster name. Alternatively, you can also go to your [hasura dashboard](https://dashboard.hasura.io) and see the clusters you have.

### Step 3: Deploying on a hasura cluster

```sh
$ git add .
$ git commit -m "Initial Commit"
$ git push hasura master
```

After the above command has been executed, open up the iOS app from `hello-iOS/iOS-app` in your xcode and run the app. Continue reading to know how the iOS app leverages the hasura apis.

### Api console

Every hasura cluster comes with an api console that gives you a GUI to test out the baas features of hasura. To open the api console

```sh
$ hasura api-console
```

## Data APIs

Hasura provides ready to use data apis to make powerful data queries on your tables. This means that you have ready-to-use JSON apis on any tables created. The url to be used to make these queries is always of the type: `https://data.cluster-name.hasura-app.io/v1/query` (in this case `https://data.h34-excise98-stg.hasura-app.io`)

As mentioned earlier, this quickstart app comes with two pre-created tables `author` and `article`.

**author**

column | type
--- | ---
id | integer NOT NULL *primary key*
name | text NOT NULL

**article**

column | type
--- | ---
id | serial NOT NULL *primary key*
title | text NOT NULL
content | text NOT NULL
rating | numeric NOT NULL
author_id | integer NOT NULL

Alternatively, you can also view the schema for these tables on the api console by heading over to the tab named `data` as shown in the screenshots below.

![alt text][readme-assets/data-1.png]
![alt text][readme-assets/data-2.png]

This means that you can now leverage the hasura data queries to perform CRUD operations on these tables.

The iOS app uses these data apis to show the respective data, to see it in action click on `View articles` button in the homepage of the app. The code for the same is at `iOS-app/iOS-app/HasuraExamples/ArticlesTableViewController.swift`. You can also check out all the apis provided by Hasura from the api console by heading over to the `API EXPLORER` tab.

For eg, to fetch a list of all articles from the article table, you have to send the following JSON request to the data api endpoint -> `https://data.cluster-name.hasura-app.io/v1/query` (replace `cluster-name` with your cluster name)

```json
{
    "type": "select",
    "args": {
        "table": "article",
        "columns": [
            "id",
            "title",
            "content",
            "rating",
            "author_id"
        ]
    }
}
```

To learn more about the data apis, head over to our [docs](https://docs.hasura-stg.hasura-app.io/0.15/manual/data/index.html)

## Auth APIs

Every app almost always requires some form of authentication. This is useful to identify a user and provide some sort of personalized experience to the user. Hasura provides various types of authentication methods (username/password, mobile/otp, email/password, Google, Facebook etc).  

You can try out these in the `API EXPLORER` tab of the `api console`. To learn more, check out our [docs](https://docs.hasura-stg.hasura-app.io/0.15/manual/users/index.html)

The iOS app in this quickstart shows us an example of the username/password authentication. To see it in action click on the `Authenticate` button on the landing page of the app and also take a look at the `iOS-app/iOS-app/HasuraExamples/AuthViewController.swift` file to see how this is done in code.

## Filestore APIs

Sometimes, you would want to upload some files to the cloud. This can range from a profile pic for your user or images for things listed on your app. You can securely add, remove, manage, update files such as pictures, videos, documents using Hasura filestore.

You can try out these in the `API EXPLORER` tab of the `api console`. To learn more, check out our [docs](https://docs.hasura-stg.hasura-app.io/0.15/manual/users/index.html)

The react app in this quickstart shows us an example of uploading a file to the filestore. To see it in action click on the `Filestore` button on the main page and take a look at `iOS-app/iOS-app/HasuraExamples/FilestoreViewController.swift` for the code.

## Custom Service

There might be cases where you might want to perform some custom business logic on your apis. For example, sending an email/sms to a user on sign up or sending a push notification to the mobile device when some event happens. For this, you would want to create your own custom service which does these for you on the endpoints that you define.

This quickstart comes with one such custom service written in `nodejs` using the `express` framework. Check it out in action at `https://app.cluster-name.hasura-app.io` . Currently, it just returns a "Hello-iOS" at that endpoint.

In case you want to use another language/framework for your custom service. Take a look at our docs to see how you can add a new custom service.

## Local development

Everytime you push, your code will get deployed on a public URL. However, for faster iteration you should locally test your changes.

### Testing your custom service locally

Since we are directly accessing the internal data endpoint (Read more about internal and external endpoints here) in the nodejs-express app. We need to forward our requests to the port at which the data service is running.

```sh
$ hasura forward -s data -n hasura --local-port 6432 --remote-port 8080
$ cd services/api/app
$ ENVIRONMENT=dev npm start
```

## Project structure

### Files and Directories

The project (a.k.a. project directory) has a particular directory structure and it has to be maintained strictly, else `hasura` cli would not work as expected. A representative project is shown below:

```
.
├── hasura.yaml
├── clusters.yaml
├── conf
│   ├── authorized-keys.yaml
│   ├── auth.yaml
│   ├── ci.yaml
│   ├── domains.yaml
│   ├── filestore.yaml
│   ├── gateway.yaml
│   ├── http-directives.conf
│   ├── notify.yaml
│   ├── postgres.yaml
│   ├── routes.yaml
│   └── session-store.yaml
├── migrations/
└── services
    ├── api/
    └── ui/
```

### `hasura.yaml`

This file contains some metadata about the project, namely a name, description and some keywords. Also contains `platformVersion` which says which Hasura platform version is compatible with this project.

### `clusters.yaml`

Info about the clusters added to this project can be found in this file. Each cluster is defined by it's name allotted by Hasura. While adding the cluster to the project you are prompted to give an alias, which is just hasura by default. The `kubeContext` mentions the name of kubernetes context used to access the cluster, which is also managed by hasura. The `config` key denotes the location of cluster's metadata on the cluster itself. This information is parsed and cluster's metadata is appended while conf is rendered. `data` key is for holding custom variables that you can define. A sample `clusters.yaml` file would look like so:

```yaml
- name: h34-ambitious93-stg
  alias: hasura
  kubeContext: h34-ambitious93-stg
  config:
    configmap: controller-conf
    namespace: hasura
  data: null  
```
