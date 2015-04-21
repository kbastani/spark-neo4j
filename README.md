# Spark Neo4j

**Spark Neo4j** is the *fastest* way to launch or deploy a graph analytics engine for big data graph processing using the new [Docker Compose](https://docs.docker.com/compose/) framework.

This image combines **Neo4j** and **Apache Spark GraphX** containers onto a single Docker host. This approach makes it easy to take advantage of these two powerful tools without worrying about configuring and installing any other dependencies.

## Getting started

The fundamental goal of this Docker image is to get you up and running as fast as possible with a **graph analytics engine**. It should take no longer than *30 minutes* for you to launch **Spark Neo4j** on Mac OSX or Linux.

### Requirements

Get Docker:  [https://docs.docker.com/installation/](https://docs.docker.com/installation/)

### Installation

To install **Spark Neo4j** on your machine, follow this install guide:

* [Mac OSX](https://github.com/kbastani/spark-neo4j/wiki/Mac-OSX-Install-Guide)
* [Linux](https://github.com/kbastani/spark-neo4j/wiki/Linux-Install-Guide)

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
* Betweenness Centrality
* Triangle Counting
* Connected Components
* Strongly Connected Components

# License

This library is licensed under the Apache License, Version 2.0.
