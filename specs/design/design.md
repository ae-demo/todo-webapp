# Todo Webapp — Design

## Overview

A single-page React web app (`todo-webapp`) lets a signed-in user manage a private list of tasks, each with a title, an optional due date, and a completed flag. It talks to a Ballerina REST API (`todo-api`) that owns all task data in a dedicated Postgres database (`todo-db`) and scopes every read and write to the caller's own user id. Sign-in for both the app and the API is handled by Thunder, the platform IDP, via SSO.

## Context (C1)

```mermaid
graph TB
    user[User]

    subgraph system["Todo Webapp"]
        webapp[todo-webapp]
        api[todo-api]
    end

    thunder[Thunder Auth]

    user -->|signs in, manages tasks| webapp
    webapp -->|REST calls| api
    webapp -->|OIDC sign-in| thunder
    api -->|validates token| thunder
```

## Domain model (ER)

```mermaid
erDiagram
    TASK {
        string id
        string userId
        string title
        date dueDate
        boolean completed
        datetime createdAt
        datetime updatedAt
    }
```

`userId` is the signed-in user's id as resolved from their Thunder token; there is no local User table — Thunder is the source of identity. Every Task belongs to exactly one user, and a user's tasks are never visible to another user.

## Key flows

### Sign-in

```mermaid
sequenceDiagram
    actor User
    participant Webapp as todo-webapp
    participant Thunder as Thunder Auth
    participant API as todo-api

    User->>Webapp: Open app
    Webapp->>Thunder: Redirect to sign-in (OIDC + PKCE)
    Thunder-->>Webapp: Auth code
    Webapp->>Thunder: Exchange code for tokens
    Thunder-->>Webapp: Access token
    Webapp->>API: GET /tasks (Bearer token)
    API->>Thunder: Validate token
    Thunder-->>API: Token valid, user id
    API-->>Webapp: 200 task list
```

### Create a task

```mermaid
sequenceDiagram
    actor User
    participant Webapp as todo-webapp
    participant API as todo-api

    User->>Webapp: Fill title + optional due date, Save
    Webapp->>API: POST /tasks {title, dueDate}
    API->>API: Associate task with caller's user id
    API-->>Webapp: 201 created task
    Webapp-->>User: Task appears in list
```

### View, complete, edit, delete, sort/filter

```mermaid
sequenceDiagram
    actor User
    participant Webapp as todo-webapp
    participant API as todo-api

    User->>Webapp: Open task list
    Webapp->>API: GET /tasks?completed=&sort=dueDate
    API-->>Webapp: 200 tasks (scoped to caller)
    Webapp->>Webapp: Highlight tasks past due
    User->>Webapp: Mark complete / edit / delete a task
    Webapp->>API: PATCH or DELETE /tasks/{taskId}
    API->>API: Verify task belongs to caller
    API-->>Webapp: 200/204 updated state
```