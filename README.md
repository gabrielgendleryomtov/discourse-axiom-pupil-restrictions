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
