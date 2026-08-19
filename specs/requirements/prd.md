# todo-webapp — PRD

## Problem Statement

People juggling daily tasks lose track of what needs doing and when, relying on scattered notes, memory, or tools that are either too complex or don't fit their workflow. Without a single, always-available place to capture and track tasks, things fall through the cracks and due dates get missed.

## Solution

A simple, personal todo web application where each signed-in user keeps their own private list of tasks, each optionally carrying a due date, so they can capture, track, and complete their work in one place.

## Actors

- **User** — a signed-in individual who creates, views, edits, completes, and deletes their own tasks. Cannot see or affect any other user's tasks.

## User Stories

1. As a user, I want to sign in securely, so that my task list is private to me and available whenever I return.
2. As a user, I want to create a new task with a title, so that I can capture something I need to do.
3. As a user, I want to set an optional due date on a task, so that I know when it needs to be done.
4. As a user, I want to view my list of tasks, so that I can see everything I need to do.
5. As a user, I want overdue tasks to be visually highlighted in my list, so that I can spot what needs attention.
6. As a user, I want to mark a task as complete, so that I can track my progress and declutter my active list.
7. As a user, I want to edit a task's title or due date, so that I can keep it accurate as things change.
8. As a user, I want to delete a task, so that I can remove things I no longer need to track.
9. As a user, I want to sort or filter my tasks (e.g. by due date, or completed vs. incomplete), so that I can focus on what matters most right now.

## Product Decisions

- Sign-in is handled via SSO through Thunder, the platform IDP (org default).
- The app is personal-only: each user's tasks are private to them; there is no list sharing or collaboration between users in this phase.
- Task organization in Phase 1 is limited to an optional due date per task; priority levels, tags/categories, and sub-tasks are not included.
- No reminder notifications (in-app or email) are sent for due or overdue tasks in this phase; users check the app themselves.
- Tasks are presented in a single list view; no alternate views (e.g. Kanban board, calendar) are built in this phase.

## Phasing

- **Phase 1 — A private, sign-in-protected todo list with due dates**: Deliver secure sign-in and full task lifecycle management (create, view, edit, complete, delete) with due dates, overdue highlighting, and sorting/filtering. Stories: 1, 2, 3, 4, 5, 6, 7, 8, 9.

## Out of Scope

- Sharing or collaborating on task lists with other users.
- Priority levels, tags/categories, and sub-tasks.
- In-app or email reminder notifications.
- Alternate views such as Kanban boards or calendars.
- Native mobile applications.

## Open Questions

None at this time — all decisions needed to proceed to design have been made or assumed above.