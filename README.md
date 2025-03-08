# New College UofT Mobile App

A comprehensive mobile application for New College students at the University of Toronto to access college services, information, and resources.

## 📱 About

This Flutter application serves as a one-stop portal for New College students to access:

- Registrar information and academic services
- Dining hall menus and meal plans
- Residence details and maintenance requests
- Campus events and activities
- Academic resources and support services

The app aims to improve student experience by providing a centralized, easy-to-use platform for accessing all college-related information.

## ✨ Features

### Authentication

- **Secure Login**: UToronto email authentication
- **Account Creation**: Streamlined signup process with student verification
- **Guest Access**: Limited browsing without authentication

### Home Dashboard

- **Announcements**: Important updates from college administration
- **Quick Links**: Fast access to frequently used resources
- **Upcoming Events**: Calendar of college events and activities

### College Services

- **Dining Information**: Cafeteria menus, hours, and meal plan details
- **Residence Portal**: Housing information, maintenance requests, and important contacts
- **Events Calendar**: Comprehensive listing of academic and social events
- **Academic Resources**: Access to academic advising, tutoring services, and resources

## 🏗️ Architecture

The application follows a modular architecture with clear separation of concerns to ensure maintainability and scalability.

```
┌───────────────────────────────────────────────────────────────┐
│                      Presentation Layer                       │
│                                                               │
│  ┌───────────┐  ┌─────────────┐  ┌─────────────┐  ┌────────┐  │
│  │  Welcome  │  │     Auth    │  │    Home     │  │ Service│  │
│  │  Screen   │  │   Screens   │  │   Screen    │  │ Screens│  │
│  └───────────┘  └─────────────┘  └─────────────┘  └────────┘  │
│         │              │                │              │      │
└─────────┼──────────────┼────────────────┼──────────────┼──────┘
          │              │                │              │       
┌─────────┼──────────────┼────────────────┼──────────────┼──────┐
│         ▼              ▼                ▼              ▼      │
│                       Services                                │
│                                                               │
│  ┌───────────┐  ┌─────────────┐  ┌─────────────┐  ┌────────┐  │
│  │   Auth    │  │    Data     │  │ Notification│  │ Storage│  │
│  │  Service  │  │   Service   │  │   Service   │  │ Service│  │
│  └───────────┘  └─────────────┘  └─────────────┘  └────────┘  │
│         │              │                │              │      │
└─────────┼──────────────┼────────────────┼──────────────┼──────┘
          │              │                │              │       
┌─────────┼──────────────┼────────────────┼──────────────┼──────┐
│         ▼              ▼                ▼              ▼      │
│                         Models                                │
│                                                               │
│  ┌───────────┐  ┌─────────────┐  ┌─────────────┐  ┌────────┐  │
│  │   User    │  │ Announcement│  │    Event    │  │ College│  │
│  │   Model   │  │    Model    │  │    Model    │  │ Service│  │
│  └───────────┘  └─────────────┘  └─────────────┘  └────────┘  │
│                                                               │
└───────────────────────────────────────────────────────────────┘
```

### Design Patterns

- **Separation of Concerns**: Clear division between UI, business logic, and data
- **Repository Pattern**: For data management and API interactions
- **Provider Pattern**: For state management (to be implemented)
- **Dependency Injection**: For loosely coupled components

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (version 3.0.0 or newer)
- Dart SDK (version 2.17.0 or newer)
- Android Studio / VS Code with Flutter extensions
- A physical device or emulator for testing

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/minjaedavidpark/CollegeHelp.git
   cd college_help
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

## 📖 Usage

### User Authentication

1. Open the app and select "Sign Up" to create a new account
2. Enter your UToronto email, student ID, and other required information
3. Set a secure password for your account
4. Once verified, you'll have access to all app features

### Navigation

The app uses a bottom navigation bar with five main sections:

1. **Home**: Dashboard with announcements and quick links
2. **Dining**: Cafeteria information and meal plans
3. **Residence**: Housing information and services
4. **Events**: Calendar of college events and activities
5. **Academics**: Course information and academic resources

## 📊 Future Roadmap

- **Authentication Integration**: Connect with UToronto authentication services
- **Push Notifications**: Real-time updates for important announcements
- **Real-time Dining Menus**: Daily and weekly menu updates
- **Room Booking System**: Reserve study spaces and meeting rooms
- **Maintenance Request Tracking**: Submit and track residence maintenance requests
- **Campus Map Integration**: Interactive map of New College and UofT campus
- **Course Registration Integration**: Direct links to course enrollment
- **Dark Mode**: Toggle between light and dark themes

## 👥 Contributing

We welcome contributions from New College students and developers! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for detailed guidelines on how to contribute to this project, including:

- Development workflow
- Code style guidelines
- Testing requirements
- Bug reporting process
- Feature request process

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

Made with ❤️ for New College students at the University of Toronto
