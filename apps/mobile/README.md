# life_insurance_monitoring_mobile

A Mini-App that computes Monthly Remittances for Life Insurance Policies based on Insurance Holders' Payment Periods.

## 🏗️ Architecture

This application follows **Clean Architecture** principles, ensuring:
- ✅ **Separation of Concerns** - Each layer has a single responsibility
- ✅ **Testability** - Easy to write unit and integration tests
- ✅ **Maintainability** - Changes in one layer don't affect others
- ✅ **Scalability** - Easy to add new features
- ✅ **Independence** - Business logic is independent of frameworks and UI

### Architecture Layers

```
┌─────────────────────────────────────┐
│     Presentation Layer (UI)         │  ← User Interface (Flutter Widgets)
├─────────────────────────────────────┤
│     Providers (State Management)    │  ← State & UI Logic
├─────────────────────────────────────┤
│     Domain Layer (Business Logic)   │  ← Use Cases & Entities
├─────────────────────────────────────┤
│     Data Layer (Data Management)    │  ← Repositories & Models
├─────────────────────────────────────┤
│     Core Layer (Utilities)          │  ← API Client, Constants, Utils
└─────────────────────────────────────┘
```

### Data Flow

```
User Action → Provider → Use Case → Repository → Data Source → API → Backend
                                                                        ↓
User sees result ← Provider ← Entity ← Repository ← Model ← Response ←
```

---

## 📁 Folder Structure

### Flutter (Mobile App)

```
lib/
├── core/                           # Shared utilities and tools
│   ├── constants/                  # App-wide constants
│   │   ├── api_constants.dart      # API endpoints and base URLs
│   │   ├── app_constants.dart      # Application constants (limits, defaults)
│   │   └── storage_constants.dart  # Local storage keys
│   ├── errors/                     # Error handling
│   │   ├── exceptions.dart         # Custom exception classes
│   │   └── failures.dart           # Failure classes for error states
│   ├── network/                    # Network layer
│   │   ├── api_client.dart         # ⭐ Centralized API client (GET, POST, PUT, DELETE)
│   │   ├── network_info.dart       # Internet connectivity checker
│   │   └── interceptors.dart       # HTTP interceptors (auth, logging)
│   ├── utils/                      # Utility functions
│   │   ├── validators.dart         # Input validation functions
│   │   ├── formatters.dart         # Data formatting utilities
│   │   └── date_helpers.dart       # Date manipulation helpers
│   ├── themes/                     # App theming
│   │   ├── app_theme.dart          # Theme configuration
│   │   ├── app_colors.dart         # Color palette
│   │   └── app_text_styles.dart    # Text styles
│   └── di/                         # Dependency injection
│       └── injection_container.dart # Service locator setup
│
├── data/                           # Data layer - handles data operations
│   ├── models/                     # Data models (API response/request)
│   │   ├── monthly_remittance_model.dart       # Monthly remittance data model with JSON serialization
│   │   ├── agent_model.dart        # Agent data model
│   ├── repositories/               # Repository implementations
│   │   ├── monthly_remittance_impl.dart
│   │   ├── agent_repository_impl.dart
│   └── datasources/                # Data sources (remote & local)
│       ├── remote/                 # API data sources
│       │   ├── monthly_remittance_remote_datasource.dart
│       │   ├── agent_remote_datasource.dart
│       └── local/                  # Local storage data sources
│           ├── monthly_remittance_local_datasource.dart
│           ├── agent_local_datasource.dart
│           └── app_database. dart   # Local database setup (Hive/SQLite)
│
├── domain/                         # Domain layer - business logic
│   ├── entities/                   # Pure business objects
│   │   ├── monthly_remittance.dart             # Monthly Remittance entity
│   │   ├── agent.dart              # Agent entity
│   ├── repositories/               # Repository interfaces (contracts)
│   │   ├── monthly_remittance_repository.dart
│   │   ├── agent_repository.dart
│   └── usecases/                   # Business use cases (single responsibility)
│       ├── monthly_remittance/
│       │   ├── get_monthly_remittances.dart
│       │   ├── get_monthly_remittance_details.dart
│       │   ├── create_monthly_remittance.dart
│       │   ├── update_monthly_remittance.dart
│       ├── agent/
│       │   ├── get_agents.dart
│       │   ├── get_agent_details.dart
│       │   └── update_agent_profile.dart
│
└── presentation/                   # Presentation layer - UI
    ├── pages/                      # Screen pages
    │   ├── splash/
    │   │   └── splash_page.dart
    │   ├── auth/
    │   │   ├── login_page.dart
    │   │   └── register_page.dart
    │   ├── dashboard/
    │   │   └── dashboard_page.dart
    │   ├── monthly_remittance/
    │   │   ├── monthly_remittance_list_page.dart
    │   │   ├── monthly_remittance_detail_page.dart
    ├── widgets/                    # Reusable UI components
    │   ├── common/
    │   │   ├── custom_button.dart
    │   │   ├── custom_text_field.dart
    │   │   ├── loading_indicator.dart
    │   │   └── error_widget.dart
    │   ├── monthly_remittance/
    │   │   └── monthly_remittance_card.dart
    └── providers/                  # State management (Provider pattern)
        ├── monthly_remittance/
        │   ├── monthly_remittance_provider.dart
        │   └── monthly_remittance_state.dart
        └── auth/
            ├── auth_provider.dart
            └── auth_state.dart
```

#### 📂 Folder Purpose Summary

| Folder | Purpose | When to Use |
|--------|---------|-------------|
| **core/** | Shared utilities used across the app | Place reusable tools, constants, API client |
| **data/** | Manages data from API and local storage | Create models, implement data fetching |
| **domain/** | Pure business logic, no framework dependencies | Define entities, business rules, use cases |
| **presentation/** | Everything user sees and interacts with | Build UI screens, widgets, state management |

---

## Getting Started

```bash
# Clone the repository
git clone https://github.com/Pogs789/insurance-agent-remittance-engine.git

# Navigate to project directory
cd apps/mobile

# Install dependencies
flutter pub get

# Run the app
flutter run
```