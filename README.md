# Project Setup Guide

## Features

- **User Authentication**: Login and registration with role-based access
- **JWT Security**: Token-based authentication using JWT
- **Role Management**: Supports Admin, Moderator, and User roles
- **PostgreSQL Integration**: Stores users, roles, and auth data
- **Spring Security**: Password encryption and secure authentication
- **REST API**: RESTful endpoints for auth and user management

## Prerequisites

- **Java**: Oracle OpenJDK **21.0.5**  
  _(Highly recommended for compatibility with other tools)_
- **PostgreSQL**: **18.1**

## Setup Steps

1. Create a PostgreSQL database named **`userdb`**.
2. Open the `application.yaml` file and configure the database connection details:
    - `username`
    - `password`
    - `host`
    - `port`
3. Build the project 
