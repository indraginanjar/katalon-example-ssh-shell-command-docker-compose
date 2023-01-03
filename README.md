# Katalon example for using SSH shell command - Docker Compose

## Description

This is a docker-compose file to be use as a sample ssh server.

## About this documentation

### Asumptions

This document is written with assumptions:

- User has an ssh client application installed in his/her machine

- User has an ssh public key configured in his/her machine

- User is using **[default.env](./default.env)** as **[.env](./.env)** without modification

- User have no SSH service running on his/her machine

### default.env

Key              | Value
-----------------|------
EXAMPLE_USERNAME | test
EXAMPLE_PASSWORD | test
EXAMPLE_SSH_PORT | 22

## Configuration

On the first run, copy **[default.env](./default.env)** as **[.env](./.env)**

## How to run/create SSH server container

To start SSH Service, run:

```bash
docker-compose up
```

or use `--build` parameter if there's changes on Dockerfile

```bash
docker-compose up --build
```

## How to stop SSH server container

To shutdown, the services

```bash
docker-compose down
```

## Accessing SSH server container

To be able access the ssh server type:

```bash
ssh <remote_user>@<remote server address> -p <remote ssh port>
```

Example if your container was created using default.env:

```bash
ssh test@localhost -p 22
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

Example with default.env:

```bash
sshpass -p "test" ssh test@localhost
```

Some people or system is considering sshpass as an unsafe solution, so maybe it's not available in your system

#### Passwordless public key

If you had a passwordless public key, you can copy it into target remote server, so your current device could access the server without inputing password.

> **Warning!**
> Since you're not putting any password, if your machine is compromised, then your server will be at a risk too to get compromised through access from your machine. Only use this method on closed environment.

If you have no passwordless SSH key yet, create it with empty password:

```bash
ssh-keygen -t <type of key> -f <filename of the key file>
```

Copy the passwordless key to server:

```bash
ssh-copy-id -p <remote ssh port> <remote_user>@<remote server address>
```

or, if you have multiple SSH keys on your machine:

```bash
ssh-copy-id -i ~/.ssh/test_rsa -o 'IdentityFile ~/.ssh/test_rsa' <remote_user>@<remote server address
```

Try to test passwordless access:

```bash
ssh <remote_user>@<remote server address> -p <remote ssh port>
```

##### Example if your server container was created using default.env

If you have no passwordless SSH key yet, create it with empty password:

```bash
ssh-keygen -t RSA -f ~/.ssh/test_rsa
```

Copy the passwordless key to server:

```bash
ssh-copy-id -i ~/.ssh/test_rsa test@localhost
```

or, if you have multiple SSH keys on your machine:

```bash
ssh-copy-id -i ~/.ssh/test_rsa -o 'IdentityFile ~/.ssh/test_rsa' test@localhost
```

Try to test passwordless access:

```bash
ssh test@localhost -p 22
```

or, if you have multiple SSH keys on your machine:

```bash
ssh -i ~/.ssh/test_rsa -p 22 test@localhost
```
