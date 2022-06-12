# Katalon example for using SSH shell command - Docker Compose

## Description

This is a docker-compose file to be use as a sample ssh server.

## About this documentation

### Asumptions

- User has an ssh client application installed in his/her machine
- User has an ssh public key configured in his/her machine
- User is using *[default.env](./default.env)** as **[.env](./.env)* without modification

### Default .env

Key              | Value
-----------------|------
EXAMPLE_USERNAME | test
EXAMPLE_PASSWORD | test
EXAMPLE_SSH_PORT | 22

## Configuration

On the first run, copy **[default.env](./default.env)** as **[.env](./.env)**

## How to run

To start SSH Service, run:

```bash
docker-compose up
```

or use `--build` parameter if there's changes on Dockerfile

```bash
docker-compose up --build
```

## How to stop

To shutdown, the services

```bash
docker-compose down
```

## Accessing SSH

To be able access the ssh server type:

Syntax:

```bash
ssh <remote_user>@<remote server address> -p <remote ssh port>
```

Example with default .env:

```bash
ssh test@localhot -p 22
```

### Accessing SSH without asking password

While automating things, it's quite common that you cannot asking user to inputing ssh password. There's two common options you can use:

1. Use sshpass
2. Passwordless public key

#### Use sshpass

Sytax:

```bash
sshpass -p "<remote user password>" ssh <remote_user>@<remote server address> -p <remote ssh port>
```

Example with default .env:

```bash
sshpass -p "test" ssh test@localhost
```

Some people or system is considering sshpass as an unsafe solution, so maybe it's not available in your system

#### Passwordless public key

If you had a passwordless public key, you can copy it into target remote server, so you could access without inputing password

Syntax:

```bash
ssh-copy-id -p <remote ssh port> <remote_user>@<remote server address>
```

Example with default .env:

```bash
ssh-copy-id -p 22 test@localhost
```