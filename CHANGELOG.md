# Changelog

All notable changes to this project will be documented in this file.

The format is based on Keep a Changelog (https://keepachangelog.com/)
and this project adheres to Semantic Versioning (https://semver.org/).

---

## [1.0.0] - 2026-02-22

### Added

- **Tasks**: Full CRUD with title, optional description, category, priority (High/Medium/Low), and due date/time.
- **Categories and priorities**: Configurable from the app; managed via core services and data layer.
- **Bin (recycle)**: Deleted tasks go to bin; restore or permanently delete; empty bin action; quick access from app bar.
- **Local notifications**: Scheduled at task due date and optional reminder (e.g. 15 minutes before); Android and iOS support with timezone handling (timezone, flutter_timezone).
- **Navigation**: GoRouter with typed routes (`/tasks`, `/bin`) and go_router_builder.
- **Filters and search**: Filter by status (pending/completed/archived), category, and priority; text search.
- **Summary cards**: Totals for all, pending, completed, and archived tasks; tap to apply quick filters or refresh.
- **UI/UX**: Material 3 theme (light/dark), pull-to-refresh, skeleton loading states, error states with retry, empty states; About dialog (version, name, legal); theme toggle in app bar.
- **Internationalization**: Flutter l10n with ARB files (Spanish and English).
- **Tests**: Unit tests for task logic (list, create, edit, delete, status, category, priority) in `test/container/` using fakes for services (tasks, categories, priorities, notifications); helpers and test data in `test/helper/` and `test/fakes/`.

### Changed

- **.gitignore**: Ignore build artifacts for all platforms (Android, iOS, macOS, Windows, Linux) and `ios/Pods/` to avoid committing generated or build output.

### Notes

- Application is local-first (Drift/SQLite); architecture remains ready for future backend or sync integration.

---

## [0.1.0] - 2026-02-15

### Added

- Initial Flutter project setup
- Base folder structure following CMI architecture
- Core rules module
- Core uses module
- Local infrastructure module
- Drift database configuration
- Riverpod state management setup
- Freezed for immutable models
- Formz for form validation
- Initial UI screens (Home, Create Task, Filters)

### Notes

- Project initialized as local-only application
- Architecture prepared for future backend integration
