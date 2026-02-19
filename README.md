# axiom-pupil-restrictions

Discourse plugin for Axiom Maths to restrict pupil account-edit privileges.

## Features
- Prevent pupils from changing username.
- Prevent pupils from changing full name.
- Hide username/full-name settings in the account preferences UI for pupils.
- Enforce restrictions server-side through Guardian checks.

## Settings
- `axiom_pupil_restrictions_enabled` (default: true)
- `axiom_pupil_restrictions_pupil_groups` (default: "", accepts multiple groups)

## Notes
- Backend guards are authoritative. UI hiding is a convenience layer.
- Username restrictions are enforced through `Guardian#can_edit_username?`.
- Full-name restrictions are enforced through `Guardian#can_edit_name?`.

## Next Version (to do)
- Add pupil avatar changes as a moderation flow: upload is accepted but avatar change remains pending until moderator approval.
- Intercept pupil avatar update endpoints and create a dedicated reviewable item for avatar-change requests.
- Add moderator actions in review queue: approve (apply pending avatar) and reject (discard request).
- Add pupil-facing feedback in preferences/avatar modal that the change is pending review.
- Keep scope tight for first pass: one pending avatar request per pupil user, with backend enforcement first and UI polish second.
