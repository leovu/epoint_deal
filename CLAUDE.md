# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
flutter pub get          # install dependencies
flutter analyze          # lint (analysis_options.yaml is currently empty)
flutter test             # run tests
flutter format .         # format code
```

To run the example app:
```bash
cd example && flutter run
```

## Architecture

**epoint_deal_plugin** is a Flutter plugin that embeds a CRM-style deal management UI (create, list, detail, edit) into host apps. The host app calls one static entry point and passes auth credentials, callbacks, and configuration.

### Entry Point

`lib/epoint_deal_plugin.dart` — `EpointDealPlugin.open()` is the sole public API. It:
1. Writes all host-supplied config into global singletons (`Globals`, `Global`, `HTTPConnection`)
2. Selects a screen by `type` (0=Create, 1=Detail, 2=List, 3=CreateFromLead)
3. Returns a result map/bool to the host app via `Navigator.pop`

### Global State

Two singleton classes carry state across the entire plugin lifetime:

- **`lib/common/globals.dart` — `Globals`**: holds `LoginResponseModel`, `permissionModels`, `configModels`, cart (`GlobalCart`), and order/work status filters.
- **`lib/common/localization/global.dart` — `Global`**: holds host-app callbacks (`getListProduct`, `createJob`, `editJob`, `createCare`, `navigateDetailOrder`, `callHotline`), domain, token, `staffId`, `branchId`, `amount`.

### Networking

Three layers, all statically accessed:

| Class | File | Role |
|---|---|---|
| `HTTPConnection` | `lib/connection/http_connection.dart` | Raw HTTP POST + multipart; sets Bearer token, brand-code, lang headers |
| `DealConnection` | `lib/connection/deal_connection.dart` | 40+ static methods wrapping every deal API endpoint; also owns `showLoading` / `showMyDialog` helpers |
| `Repository` | `lib/resource/repository.dart` | Facade for order, booking, payment, and category sub-resources (used by BLoC layer) |

Domain and token must be set on `HTTPConnection` before any API call (done inside `open()`).

### BLoC Pattern

Blocs extend `BaseBloc` (`lib/bloc/base_bloc.dart`) which provides a `Repository` instance and RxDart `BehaviorSubject` streams. Screens subscribe to streams via `StreamBuilder`. There is no provider/DI — blocs are instantiated directly inside `State.initState()` and disposed in `dispose()`.

### Presentation Layer

`lib/presentation/` is organized by feature:

- `create_deal/` — `CreateDealScreen` + `CreateDealBloc`; opens customer/lead picker sheet on init
- `list_deal/` — paginated deal list with filter
- `detail_deal/` — tabbed detail view with sub-screens (comments, orders, care history, etc.)
- `edit_deal/` — mirrors create flow
- `modal/` — ~20 bottom-sheet modals (pipeline, journey, tag, customer, staff, branch pickers, etc.)
- `order_module/`, `category_module/` — embedded sub-features for order and product management

### Widgets

`lib/widget/` contains 115+ reusable widgets. Key ones:

- `CustomMenuBottomSheet` (`custom_menu_bottom_sheet.dart` and `custom_meni_bottom_sheet.dart`) — standard bottom-sheet shell used by most modals. Must use `Material(type: MaterialType.transparency)` as root (not `Scaffold`) so tap-outside dismissal works.
- `CustomListView`, `CustomButton`, `CustomTextField`, `CustomDatePicker` — standard UI primitives used throughout.

### Navigation

Plain `Navigator.push(MaterialPageRoute(...))` everywhere — no named routes. Bottom sheets use `showModalBottomSheet` with `useRootNavigator: true` and `backgroundColor: Colors.transparent`. Always pass `isScrollControlled: true` when the sheet needs more than half-screen height.

### Localization

`AppLocalizations.text(LangKey.someKey)` returns a translated string. Keys are defined in `lib/common/lang_key.dart`. Language JSON files live in `assets/languages/`.

### Models

- `lib/model/request/` — request bodies (e.g., `AddDealModelRequest`, `GetListDealModelRequest`)
- `lib/model/response/` — response wrappers (always have `errorCode`, `errorDescription`, nullable `data`)
