# Spark Neo4j

**Spark Neo4j** is the *fastest* way to launch or deploy a graph analytics engine for big data graph processing using the new [Docker Compose](https://docs.docker.com/compose/) framework.

This image combines **Neo4j** and **Apache Spark GraphX** containers onto a single Docker host. This approach makes it easy to take advantage of these two powerful tools without worrying about configuring and installing any other dependencies.

## Getting started

The fundamental goal of this Docker image is to get you up and running as fast as possible with a **graph analytics engine**. It should take no longer than *30 minutes* for you to launch **Spark Neo4j** on Mac OSX or Linux.

### Requirements

Get Docker:  [https://docs.docker.com/installation/](https://docs.docker.com/installation/)

### Mac OSX

After you've installed Docker on Mac OSX with boot2docker, you'll need to make sure that the `DOCKER_HOST` environment variable points to the URL of the Docker daemon.

    export DOCKER_HOST=tcp://$(boot2docker ip 2>/dev/null):2375

> Neo4j Spark uses the `DOCKER_HOST` environment variable to manage multiple containers with [Docker Compose](https://docs.docker.com/compose/).

Run the following command in your current shell to generate the other necessary Docker configurations:

    $(boot2docker shellinit)

> You'll need to repeat this process if you open a new shell. Spark Neo4j requires the following environment variables: `DOCKER_HOST`, `DOCKER_CERT_PATH`, and `DOCKER_TLS_VERIFY`.

#### Start the Spark Neo4j cluster

In your current shell, run the following command to download and launch the Spark Neo4j cluster.

    docker run  --env DOCKER_HOST=$DOCKER_HOST \
                --env DOCKER_TLS_VERIFY=$DOCKER_TLS_VERIFY \
                -v $DOCKER_CERT_PATH:/docker/cert \
                -ti kbastani/spark-neo4j up -d

> This command will pull down multiple docker images the first time you run it. Grab a beer or coffee. You'll soon be taking over the world with your new found graph processing skills.

#### Stream log output from the cluster

After the Docker images are installed and configured, you will be able to access the Neo4j browser. To know whether or not Neo4j has been started, you can stream the log output from your Spark Neo4j cluster by running this command in your current shell:

    docker run  --env DOCKER_HOST=$DOCKER_HOST \
                --env DOCKER_TLS_VERIFY=$DOCKER_TLS_VERIFY \
                -v $DOCKER_CERT_PATH:/docker/cert \
                -ti kbastani/spark-neo4j logs graphdb

This command will stream the log output from Neo4j to your current shell. Confirm that Neo4j has started before continuing.

>`CTRL-C` will exit the log view and bring you back to your current shell.

>You can alter the above command to stream log output from all service containers simultaneously by removing `graphdb` from the last line.

#### Open the Neo4j browser

Now that you've confirmed Neo4j is running as a container in your Docker host, let's open up Neo4j's browser and test running PageRank on actors in a movie dataset.

Run the following command to open a browser window that navigates to Neo4j's URL.

    open $(echo \"$(echo $DOCKER_HOST)\"|
                \sed 's/tcp:\/\//http:\/\//g'|
                \sed 's/[0-9]\{4,\}/7474/g'|
                \sed 's/\"//g')

> This command finds the `$DOCKER_HOST` environment variable to generate the URL of Neo4j's browser. On Linux, this would be http://localhost:7474.

#### Import the movie graph

In the Neo4j console type `:play movies` and press enter. Follow the directions to import the movie sample dataset.

>We'll use this dataset to test the Spark integration by running PageRank on the "Celebrity Graph" of actors.

Now that the movie dataset has been imported, let's create new relationships between actors who appeared together in the same movie. Copy and paste the following command into the Neo4j console and press `CTRL+Enter` to execute.

    MATCH (p1:Person)-[:ACTED_IN]->(m:Movie),
          (p2:Person)-[:ACTED_IN]->(m)
    CREATE (p1)-[:KNOWS]->(p2)

> PageRank measures the probability of finding a node on the graph by randomly following links from one node to another node. It's a measure of a node's importance.

#### Calculate PageRank on the celebrity graph

Now that we've generated our "Celebrity Graph" by inferring the `:KNOWS` relationship between co-actors, we can run PageRank on all nodes connected by this new relationship.

In the Neo4j console, copy and paste the following command:

    :GET /service/mazerunner/analysis/pagerank/KNOWS

and press enter.

If everything ran correctly, we should have a result of:

    { "success": "true" }

#### Monitor Spark's log output

This means that the graph was exported to Spark for processing. We can monitor the log output from Spark by returning to the terminal we used during setup from earlier. From that shell, run the following command:

    docker run  --env DOCKER_HOST=$DOCKER_HOST \
                --env DOCKER_TLS_VERIFY=$DOCKER_TLS_VERIFY \
                -v $DOCKER_CERT_PATH:/docker/cert \
                -ti kbastani/spark-neo4j logs

#### Calculate Closeness Centrality

You'll now be able to monitor the real-time log output from the **Spark Neo4j** cluster as you submit new graph processing jobs.

Return back to the Neo4j browser and run the following command to calculate the Closeness Centrality of our "Celebrity Graph".

    :GET /service/mazerunner/analysis/closeness_centrality/KNOWS

If your log output from the terminal is visible, you'll see a flurry of activity from Spark as it calculates this new metric. Don't blink, you might miss it.

#### Querying the metrics from Neo4j

You can now query on the newly calculated metrics from Neo4j. In the Neo4j browser, run the following command:

    MATCH (p:Person) WHERE has(p.pagerank) AND has(p.closeness_centrality)
    RETURN p.name, p.pagerank as pagerank, p.closeness_centrality
    ORDER BY pagerank DESC

The results show which of the celebrities have the most influence in Hollywood.

> Go forth and process graphs.

## Graph Analytics Engine

This Docker image is an all-in-one graph processing solution combining **graph storage** and **graph processing** in a single platform.

### Graph Storage

A **Neo4j graph database** container provides an out of the box database management system with robust (fully ACID) graph data storage and query capabilities. This container configures Neo4j for high-performance OLTP use cases.

### Graph Processing

An **Apache Spark GraphX** container provides a single system that handles iterative graph computation and ETL from data sourced from Neo4j.

### Closed-loop Data Processing

The results of an analysis by the Apache Spark container are applied back to Neo4j. These results can be explored using Neo4j's powerful query capabilities to lookup graph metrics calculated by Spark.

* PageRank
* Closeness Centrality
* Triangle Counting
* Connected Components
* Strongly Connected Components

# License

This library is licensed under the Apache License, Version 2.0.
