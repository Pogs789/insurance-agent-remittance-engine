# Life Insurance Monitoring Mobile Application

A Mobile Application that automates insurance remittances, makes planholder monitoring easy, and streamlines insurance agent workflows.

## 🚧 Project Status

This project is currently under active development.
Documentation may not reflect the latest implementation yet.
Major updates to architecture and features are ongoing.

Last updated: February 2026

## 📋 Table of Contents
- [Problem Statement](#problem-statement)
- [Features of the Application](#features-of-the-application)
- [Technologies Used](#technologies-used)
- [Architecture](#architecture)
- [Folder Structure](#folder-structure)
    - [Flutter (Mobile App)](#flutter-mobile-app)
    - [NestJS (Backend API)](#nestjs-backend-api)
- [Getting Started](#getting-started)
- [API Documentation](#api-documentation)
- [Contributing](#contributing)

---

## 🎯 Problem Statement

Insurance Agents every single month have to manually monitor insurance planholders to ensure that they are making their payments on time.  This process is tedious, time-consuming, and prone to human error.  Additionally, insurance agents often struggle to keep track of multiple insurance plans and their respective remittance schedules.

### Solution
This application provides an automated monitoring system that:
- Tracks payment schedules automatically
- Sends timely reminders to planholders
- Provides real-time dashboard for agents
- Reduces manual tracking errors
- Streamlines the entire remittance process

---

## ✨ Features of the Application

### For Insurance Agents
- **User Authentication** - Secure Sign Up, Login, and Logout
- **Dashboard Overview** - Quick glance at all active policies
- **View Insurance Plans** - Detailed view of all managed insurance plans
- **Insurance Remittance Tracking** - Automated tracking of payment schedules
- **Monitor Planholder Payments** - Real-time payment status updates
- **Notifications** - Automated alerts for upcoming and missed payments
- **User Profile Management** - Manage agent profile and preferences
- **Client Management** - Add, update, and track client information
- **Claims Processing** - Submit and track insurance claims

### For Admin/Insurance Providers
- **Admin Dashboard** - Comprehensive overview of all agents and policies
- **Agent Performance Tracking** - Monitor agent activities and success rates
- **Policy Management** - Create, update, and manage insurance policies
- **Reports & Analytics** - Generate insights on payments and policy performance

---

## 🛠️ Technologies Used

### Frontend (Mobile Application)
- **Flutter** - Cross-platform framework (iOS and Android)
- **Dart** - Programming language
- **Provider** - State management solution
- **Dio** - HTTP client for API requests
- **Firebase Cloud Messaging** - Push notifications
- **Shared Preferences** - Local data persistence

### Backend (API Server)
- **NestJS** - Progressive Node.js framework
- **TypeScript** - Strongly-typed programming language
- **PostgreSQL** - Relational database
- **TypeORM** - Object-Relational Mapping
- **JWT** - JSON Web Tokens for authentication
- **Passport** - Authentication middleware

### DevOps & Tools
- **Git** - Version control
- **Docker** - Containerization (optional)
- **Postman** - API testing

---

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
│   │   ├── policy_model.dart       # Policy data model with JSON serialization
│   │   ├── agent_model.dart        # Agent data model
│   │   ├── client_model.dart       # Client/Planholder data model
│   │   ├── premium_model.dart      # Premium payment data model
│   │   └── claim_model.dart        # Insurance claim data model
│   ├── repositories/               # Repository implementations
│   │   ├── policy_repository_impl.dart
│   │   ├── agent_repository_impl.dart
│   │   ├── client_repository_impl. dart
│   │   ├── premium_repository_impl.dart
│   │   └── claim_repository_impl.dart
│   └── datasources/                # Data sources (remote & local)
│       ├── remote/                 # API data sources
│       │   ├── policy_remote_datasource.dart
│       │   ├── agent_remote_datasource.dart
│       │   ├── client_remote_datasource.dart
│       │   ├── premium_remote_datasource.dart
│       │   └── claim_remote_datasource.dart
│       └── local/                  # Local storage data sources
│           ├── policy_local_datasource.dart
│           ├── agent_local_datasource.dart
│           └── app_database. dart   # Local database setup (Hive/SQLite)
│
├── domain/                         # Domain layer - business logic
│   ├── entities/                   # Pure business objects
│   │   ├── policy.dart             # Policy entity
│   │   ├── agent.dart              # Agent entity
│   │   ├── client.dart             # Client/Planholder entity
│   │   ├── premium.dart            # Premium entity
│   │   └── claim.dart              # Claim entity
│   ├── repositories/               # Repository interfaces (contracts)
│   │   ├── policy_repository.dart
│   │   ├── agent_repository.dart
│   │   ├── client_repository.dart
│   │   ├── premium_repository.dart
│   │   └── claim_repository.dart
│   └── usecases/                   # Business use cases (single responsibility)
│       ├── policy/
│       │   ├── get_policies. dart
│       │   ├── get_policy_details.dart
│       │   ├── create_policy.dart
│       │   ├── update_policy. dart
│       │   └── delete_policy.dart
│       ├── agent/
│       │   ├── get_agents.dart
│       │   ├── get_agent_details.dart
│       │   └── update_agent_profile.dart
│       ├── client/
│       │   ├── get_clients.dart
│       │   ├── get_client_details.dart
│       │   ├── create_client.dart
│       │   └── update_client.dart
│       ├── premium/
│       │   ├── get_premiums.dart
│       │   ├── get_premium_schedule.dart
│       │   ├── calculate_premium.dart
│       │   └── record_payment.dart
│       └── claim/
│           ├── get_claims.dart
│           ├── submit_claim.dart
│           └── update_claim_status.dart
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
    │   ├── policy/
    │   │   ├── policy_list_page.dart
    │   │   ├── policy_detail_page.dart
    │   ├── client/
    │   │   ├── client_list_page.dart
    │   │   ├── client_detail_page.dart
    │   │   └── client_form_page.dart
    │   ├── premium/
    │   │   ├── premium_list_page. dart
    │   │   ├── premium_payment_page.dart
    │   │   └── premium_schedule_page.dart
    │   └── claim/
    │       ├── claim_list_page. dart
    │       ├── claim_detail_page.dart
    │       └── claim_form_page.dart
    ├── widgets/                    # Reusable UI components
    │   ├── common/
    │   │   ├── custom_button.dart
    │   │   ├── custom_text_field.dart
    │   │   ├── loading_indicator.dart
    │   │   └── error_widget.dart
    │   ├── policy/
    │   │   └── policy_card.dart
    │   ├── client/
    │   │   └── client_card.dart
    │   └── premium/
    │       └── premium_card.dart
    └── providers/                  # State management (Provider pattern)
        ├── policy/
        │   ├── policy_provider.dart
        │   └── policy_state.dart
        ├── client/
        │   ├── client_provider.dart
        │   └── client_state.dart
        ├── premium/
        │   ├── premium_provider.dart
        │   └── premium_state.dart
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

### NestJS (Backend API)

```
src/
├── common/                         # Shared utilities across all modules
│   ├── decorators/                 # Custom decorators
│   │   ├── current-user.decorator.ts
│   │   └── roles.decorator.ts
│   ├── filters/                    # Exception filters
│   │   ├── http-exception.filter.ts
│   │   └── all-exceptions.filter.ts
│   ├── guards/                     # Route guards (authentication/authorization)
│   │   ├── jwt-auth.guard.ts
│   │   └── roles.guard.ts
│   ├── interceptors/               # Request/Response interceptors
│   │   ├── logging.interceptor.ts
│   │   └── transform.interceptor.ts
│   ├── pipes/                      # Validation pipes
│   │   └── validation.pipe.ts
│   ├── interfaces/                 # Shared TypeScript interfaces
│   │   └── response.interface.ts
│   └── constants/                  # Application constants
│       └── app.constants.ts
│
├── config/                         # Configuration files
│   ├── database.config.ts          # PostgreSQL connection config
│   ├── jwt. config.ts               # JWT authentication config
│   └── app.config.ts               # General app configuration
│
├── database/                       # Database management
│   ├── migrations/                 # Database migrations
│   ├── seeds/                      # Database seeders (test data)
│   └── database.module.ts          # Database module configuration
│
├── modules/                        # Feature modules
│   ├── auth/                       # Authentication module
│   │   ├── dto/
│   │   │   ├── login. dto.ts
│   │   │   ├── register.dto.ts
│   │   │   └── refresh-token.dto.ts
│   │   ├── entities/
│   │   │   └── user.entity.ts
│   │   ├── strategies/
│   │   │   ├── jwt.strategy.ts
│   │   │   └── local.strategy.ts
│   │   ├── auth.controller.ts      # Routes:  POST /auth/login, /auth/register
│   │   ├── auth.service.ts         # Business logic for authentication
│   │   ├── auth.repository.ts      # Database operations for users
│   │   └── auth.module.ts
│   │
│   ├── policies/                   # Insurance policies module
│   │   ├── dto/
│   │   │   ├── create-policy.dto.ts
│   │   │   ├── update-policy.dto.ts
│   │   │   └── query-policy.dto.ts
│   │   ├── entities/
│   │   │   └── policy.entity.ts    # Database schema for policies
│   │   ├── policies.controller.ts  # Routes: GET/POST/PUT/DELETE /policies
│   │   ├── policies.service.ts     # Business logic for policies
│   │   ├── policies.repository.ts  # Database operations
│   │   └── policies. module.ts
│   │
│   ├── agents/                     # Insurance agents module
│   │   ├── dto/
│   │   │   ├── create-agent.dto.ts
│   │   │   └── update-agent.dto.ts
│   │   ├── entities/
│   │   │   └── agent.entity.ts
│   │   ├── agents.controller.ts
│   │   ├── agents.service.ts
│   │   ├── agents.repository. ts
│   │   └── agents.module.ts
│   │
│   ├── clients/                    # Planholders/Clients module
│   │   ├── dto/
│   │   │   ├── create-client.dto.ts
│   │   │   └── update-client.dto.ts
│   │   ├── entities/
│   │   │   └── client.entity.ts
│   │   ├── clients.controller.ts
│   │   ├── clients.service.ts
│   │   ├── clients.repository.ts
│   │   └── clients.module.ts
│   │
│   ├── premiums/                   # Premium payments module
│   │   ├── dto/
│   │   │   ├── create-premium.dto.ts
│   │   │   ├── calculate-premium.dto.ts
│   │   │   └── record-payment.dto.ts
│   │   ├── entities/
│   │   │   └── premium.entity.ts
│   │   ├── premiums.controller.ts
│   │   ├── premiums.service.ts
│   │   ├── premiums.repository.ts
│   │   └── premiums.module.ts
│   │
│   ├── claims/                     # Insurance claims module
│   │   ├── dto/
│   │   │   ├── create-claim.dto.ts
│   │   │   ├── update-claim. dto.ts
│   │   │   └── query-claim. dto.ts
│   │   ├── entities/
│   │   │   └── claim. entity.ts
│   │   ├── claims.controller.ts
│   │   ├── claims.service.ts
│   │   ├── claims.repository.ts
│   │   └── claims.module.ts
│   │
│   └── notifications/              # Push notifications module
│       ├── dto/
│       │   └── send-notification.dto.ts
│       ├── notifications.service.ts
│       └── notifications.module.ts
│
├── app.module.ts                   # Root application module
└── main.ts                         # Application entry point
```

#### 📂 NestJS Module Structure

Each module follows this pattern:

| File | Purpose | Example |
|------|---------|---------|
| **dto/** | Data Transfer Objects - validation schemas | Ensures incoming data is correct format |
| **entities/** | Database table definitions (TypeORM) | Defines what columns exist in the database |
| **controller. ts** | Handles HTTP requests (routes) | `GET /policies`, `POST /policies` |
| **service.ts** | Contains business logic | Calculates premiums, validates rules |
| **repository.ts** | Interacts with database | CRUD operations on database |
| **module.ts** | Bundles everything together | Exports the module to be used elsewhere |

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.0.0)
- Node.js (>=18.0.0)
- PostgreSQL (>=14.0)
- Firebase account (for notifications)

### Flutter Setup

```bash
# Clone the repository
git clone https://github.com/Pogs789/Life-Insurance-Monitoring-App.git

# Navigate to project directory
cd life_insurance_monitoring_mobile_application

# Install dependencies
flutter pub get

# Run the app
flutter run
```

### Backend Setup

```bash
# Navigate to backend directory
cd life_insurance_monitoring

# Install dependencies
pnpm install

# Set up environment variables
cp .env.example . env
# Edit .env with your database credentials

# Run migrations
pnpm run migration: run

# Start the server
pnpm run start:dev
```

---

## 📡 API Documentation

### Base URL
```
Development: http://localhost:3000/api
Production: https://life-insurance-demo.vercel.app/api
```

### Authentication
All protected routes require JWT token in the Authorization header:
```
Authorization: Bearer <your_jwt_token>
```

### Endpoints

#### Authentication
- `POST /auth/register` - Register new user
- `POST /auth/login` - Login user
- `POST /auth/refresh` - Refresh access token

#### Policies
- `GET /policies` - Get all policies
- `GET /policies/:id` - Get policy by ID
- `POST /policies` - Create new policy
- `PUT /policies/:id` - Update policy
- `DELETE /policies/:id` - Delete policy

#### Clients
- `GET /clients` - Get all clients
- `GET /clients/:id` - Get client by ID
- `POST /clients` - Create new client
- `PUT /clients/:id` - Update client

#### Premiums
- `GET /premiums` - Get all premiums
- `GET /premiums/policy/:policyId` - Get premiums for specific policy
- `POST /premiums` - Record premium payment
- `POST /premiums/calculate` - Calculate premium amount

---

## 🧪 Testing

### Flutter
```bash
# Run unit tests
flutter test

# Run integration tests
flutter test integration_test
```

### Backend
```bash
# Run unit tests
pnpm run test

# Run e2e tests
pnpm run test: e2e

# Test coverage
pnpm run test:cov
```

---

## 📱 Screenshots

<work in progress>

---

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/<your feature>`)
3. Commit your changes (`git commit -m 'What changes do you made.'`)
4. Push to the branch (`git push origin feature/<your feature>`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 👨‍💻 Author

**Cesphillip M. Lorica**
- GitHub: [@yourusername](https://github.com/Pogs789)
- LinkedIn: [Your LinkedIn](https://www.linkedin.com/in/cesphillip-lorica-5923a523b/)
- Email: loricaphillip@outlook.com

---

## 🙏 Acknowledgments

- Insurance industry requirements gathered from an Insurance Agent, who inspired this project
- Clean Architecture principles by Robert C. Martin
- Flutter and NestJS communities

---

## 📊 Project Status

🚧 **Currently in development** - Version 1.0.0 coming soon!

- [x] Project structure setup
- [x] Blueprint and planning
- [x] Clean architecture implementation
- [ ] Authentication module
- [ ] Policy management
- [ ] Premium tracking
- [ ] Claims processing
- [ ] Push notifications
- [ ] Admin dashboard
- [ ] Testing coverage (>80%)
- [ ] Documentation completion
