# Security design

## Roles → permissions

There is a single role in this product — every signed-in individual is a "User" with identical permissions, scoped strictly to their own tasks. No admin or shared-access role exists (personal-only, per Product Decisions).

## Authentication (Thunder)

- Both `todo-webapp` and `todo-api` declare the same platform-resource dependency name, `thunder-auth` (`resourceType: thunder-app`), which is what ties the SPA's sign-in session to the bearer tokens `todo-api` validates.
- Scopes: `openid profile email` (default).
- `todo-webapp` performs OIDC + PKCE sign-in in the browser and attaches the resulting access token as a Bearer credential on every call to `todo-api`.
- `todo-api` sits behind the platform API gateway, which validates the token and injects the caller's identity; `todo-api` itself never issues or stores tokens.
- There is no unauthenticated surface: every screen and every `todo-api` endpoint requires a signed-in user.

## Role resolution

`todo-api` resolves the caller's user id from the identity the gateway injects from the validated token (`X-User-Id`) and uses it to scope every query and mutation — a user can only ever read or modify tasks whose `userId` matches their own. A request with no valid token is rejected by the gateway before it reaches `todo-api` (401); a request whose token resolves to a user id that doesn't own the requested task is rejected with 404 (never revealing another user's task exists).