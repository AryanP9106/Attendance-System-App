## Quick orientation

This is a small Flutter app that implements simple role-based navigation (teacher vs student). Use these notes to make targeted, low-risk code changes and to reason about how features should be wired.

Core idea: `lib/main.dart` sets up a `ChangeNotifierProvider` with `AuthService` (`lib/services/auth_service.dart`). UI routing is manual and synchronous: `lib/screens/auth_wrapper.dart` inspects `AuthService.currentUser?.role` and returns `TeacherScreen` or `StudentScreen` (fallback -> `LoginScreen`).

## Key files to read first
- `lib/main.dart` — app entry, registers provider.
- `lib/services/auth_service.dart` — central auth state (fake implementation). Important: `isAuthenticated` and `currentUser` are the single source of truth.
- `lib/screens/auth_wrapper.dart` — role-routing logic and use of `kDebugMode` + `logger` for debug logs.
- `lib/screens/login_screen.dart` — calls `AuthService.login(email, password)` and expects `AuthWrapper` to react.
- `lib/screens/teacher_screen.dart`, `lib/screens/student_screen.dart` — role-specific pages; both call `authService.logout()` directly.
- `lib/models/user.dart` — data shape used across code; includes `toMap()` / `fromMap()` for DB integration.
- `lib/database/database_helper.dart` and `lib/db_helper.dart` — database integration points (currently TODO/empty). `pubspec.yaml` already depends on `sqflite` and `path`.
- `lib/screens/glass_background.dart` — UI wrapper used by `LoginScreen` (pattern for small consistent screens).

## Project-specific conventions & patterns
- State: uses Provider + ChangeNotifier (see `main.dart`). Prefer updating `AuthService` rather than passing auth state down the tree.
- Roles: role strings are literal `'teacher'` or `'student'`. Many control flows branch on `role == 'teacher'` or `'student'` (see `auth_wrapper.dart`). Keep exact spelling.
- Auth contract: `AuthService` exposes `isAuthenticated: bool`, `currentUser: UserModel?`, `login(...) async` and `logout()`. UI expects `login` to set state and call `notifyListeners()`.
- Logging: use `logger` and guard logs with `kDebugMode` where appropriate (see `AuthWrapper`).
- UI composition: small reusable wrapper widgets (e.g., `GlassBackground`) are used to apply consistent styling.

## Important implementation notes & TODOs discovered
- `auth_service.dart` currently contains a placeholder: login logic fakes a teacher when the email contains the substring `"teacher"`. Any integrated auth system (Firebase, REST API) should preserve the same observable contract (`isAuthenticated`, `currentUser`, and `notifyListeners()`).
- DB helpers are not implemented: `lib/db_helper.dart` is empty and `lib/database/database_helper.dart` exists as the intended place for sqflite wiring. If you add local persistence, follow the `User.toMap()/fromMap()` in `lib/models/user.dart`.

## Build / run / test commands (Windows PowerShell)
- Install deps: `flutter pub get`
- Run (default device or desktop): `flutter run`
- Run specifically on Windows: `flutter run -d windows`
- Run tests: `flutter test` (there is a `test/widget_test.dart` scaffold)

Examples (power-user):
```
flutter pub get
flutter run -d windows
flutter test
```

## Integration & external dependencies
- See `pubspec.yaml`: notable deps already present — `provider`, `sqflite`, `path`, `logger`, `telephony`, `intl`.
- `sqflite` + `path` indicate local SQLite DB intent; look in `lib/database/database_helper.dart` to implement DB file creation and queries.
- `telephony` is declared but unused in the visible UI code; it likely would be used for SMS integrations on Android.

## How to extend features safely (short checklist)
1. Preserve `AuthService` contract: keep `isAuthenticated`, `currentUser`, and `notifyListeners()` so `AuthWrapper` keeps working.
2. If changing role values, update all string checks in `auth_wrapper.dart` and `models/user.dart`.
3. Add DB queries under `lib/database/database_helper.dart` and use `User.toMap()/fromMap()`.
4. Add debug logs using `logger` and gate them with `kDebugMode` where appropriate.

## Examples to cite in PRs
- Role-routing: reference `lib/screens/auth_wrapper.dart` when proposing navigation changes.
- Fake auth: reference `lib/services/auth_service.dart` and mention the simple `email.contains("teacher")` rule when suggesting auth backend work.
- DB shape: reference `lib/models/user.dart` to justify column names for a `users` table.

If anything in here is unclear or you want more details (examples of adding sqflite setup, or a suggested AuthService migration to Firebase), tell me which area to expand and I'll iterate.
