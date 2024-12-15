# Chatbot Database and Scripts Documentation

## Overview

This repository contains the database and Python scripts for a chatbot project. The main focus is to set up a PostgreSQL database with `pgvector` extension for storing and querying document embeddings, and providing sample Python scripts to interact with the database.

## Table of Contents

- [Installation](#installation)
- [Database Setup](#database-setup)
  - [Docker Compose](#docker-compose)
- [Python Scripts](#python-scripts)
  - [pg_vector_similarity.py](#pg_vector_similaritypy)
  - [pgvector_service.py](#pgvector_servicepy)
- [Running on Mac and Windows](#running-on-mac-and-windows)


### Installation

1. Clone the repository:


2. Install the required Python packages:

```bash
pip install -r requirements.txt
```

## Database Setup

### Docker Compose

To set up the PostgreSQL database with the `pgvector` extension, use the provided Docker Compose configuration.

1. Navigate to the `database` directory:

```bash
cd database
```

2. Run Docker Compose:

```bash
docker-compose up -d
```

This will start a PostgreSQL container with the `pgvector` extension.


## Python Scripts

### pg_vector_similarity.py

This script demonstrates how to use `pgvector` with a sample text document. It loads the document, splits it into chunks, and stores the chunks and their embeddings in the PostgreSQL database. It then performs similarity searches using the `pgvector` extension.

### pgvector_service.py

This script provides a service for interacting with the PostgreSQL database containing document embeddings. It includes methods for getting vector embeddings, custom similarity searches, updating collections, and more.

## Running on Mac and Windows

The provided scripts and configurations are compatible with both Mac and Windows. However, there may be slight differences in running Docker Compose or executing shell commands.

For detailed instructions on running Docker Compose on Mac and Windows, refer to the Docker documentation:

- [Docker Compose on Mac](https://docs.docker.com/compose/install/#install-compose-on-macos)
- [Docker Compose on Windows](https://docs.docker.com/compose/install/#install-compose-on-windows)

For executing shell commands, use the appropriate command prompt (cmd, PowerShell, or Terminal) based on your operating system.