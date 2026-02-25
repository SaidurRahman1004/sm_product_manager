<div align="center">
  <img src="https://i.postimg.cc/4xCPWH3w/logo.jpg" alt="App Logo" width="150" style="border-radius: 20px;"/>

# 📦 Product Management App

  <p align="center">
    A robust, clean architecture-based Product Management application built with <strong>Flutter</strong> and <strong>GetX</strong>
  </p>

![Flutter](https://img.shields.io/badge/Flutter-3.11.0+-02569B?style=flat&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?style=flat&logo=dart&logoColor=white)
![GetX](https://img.shields.io/badge/GetX-State%20Management-8A2BE2?style=flat)
![License](https://img.shields.io/badge/License-MIT-green?style=flat)

</div>

---

## 📋 Overview

A pixel-perfect, production-ready Product Management application featuring seamless REST API integration, multipart image uploads, and an offline-first experience using local database caching. Built with Clean Architecture principles for maximum maintainability and scalability.

---

## ✨ Key Features

- 🔐 **Authentication System** - Secure Login, Registration, Forgot Password, and OTP verification flows
- 👤 **Profile Management** - Dynamic user profile setup with multipart image uploads, language selection, and personal details
- 📦 **Product CRUD Operations** - Complete inventory control with Add, Edit, View, and Delete functionality
- 💾 **Offline Support (Sqflite)** - Local database caching allows users to view products without internet connection
- 🎨 **Pixel-Perfect UI** - Fully responsive design matching Figma prototypes with custom dotted borders and dynamic validations
- 🏗️ **Clean Architecture** - Separation of concerns (Data, Domain, Presentation layers) for highly maintainable code
- 🌐 **Multi-language Support** - Language selection feature for better user experience
- 📱 **Responsive Design** - Adapts perfectly to all screen sizes using Flutter ScreenUtil

---

## 📸 App Screenshots

<details open>
<summary>View All Screenshots</summary>

### Authentication Flow
| Splash & Onboarding | Auth & Login | Registration |
|:---:|:---:|:---:|
| <img src="https://i.postimg.cc/NjhDd20m/1.png" width="250"/> | <img src="https://i.postimg.cc/XYMLsBvL/2.png" width="250"/> | <img src="https://i.postimg.cc/2SpG0L5w/3.png" width="250"/> |

### Password Recovery
| Forgot Password | OTP Verification | Reset Password |
|:---:|:---:|:---:|
| <img src="https://i.postimg.cc/RZrdgJ07/4.png" width="250"/> | <img src="https://i.postimg.cc/Dy45QP7C/5.png" width="250"/> | <img src="https://i.postimg.cc/PrvKbQdS/6.png" width="250"/> |

### Profile Setup
| Success Screens | Location Setup | Language Selection |
|:---:|:---:|:---:|
| <img src="https://i.postimg.cc/3J09jF3n/7.png" width="250"/> | <img src="https://i.postimg.cc/xTNgG39g/8.png" width="250"/> | <img src="https://i.postimg.cc/L6gvk3mV/9.png" width="250"/> |

| Setup Profile | Profile Success | Home Dashboard |
|:---:|:---:|:---:|
| <img src="https://i.postimg.cc/RVJG1LvR/10.png" width="250"/> | <img src="https://i.postimg.cc/gkL4yHGq/11.png" width="250"/> | <img src="https://i.postimg.cc/VL049WzW/12.png" width="250"/> |

### Product Management
| Product Details | Delete Confirmation | Add/Edit Product |
|:---:|:---:|:---:|
| <img src="https://i.postimg.cc/4NHwvQXt/13.png" width="250"/> | <img src="https://i.postimg.cc/WbqSmws0/14.png" width="250"/> | <img src="https://i.postimg.cc/BQPN5BJx/15.png" width="250"/> |

### User Profile
| Profile Menu |
|:---:|
| <img src="https://i.postimg.cc/L6gvk3mP/16.png" width="250"/> |

</details>

---

## 🛠️ Tech Stack & Packages

This project utilizes powerful Dart packages to ensure high performance and clean code:

### Core Packages
| Package | Purpose |
|---------|---------|
| **[get](https://pub.dev/packages/get)** | State Management, Dependency Injection (Bindings), and context-less Route Navigation |
| **[http](https://pub.dev/packages/http)** | RESTful API requests (GET, POST, PUT, DELETE) and multipart/form-data for image uploads |
| **[sqflite](https://pub.dev/packages/sqflite)** | Local database for offline caching |
| **[path_provider](https://pub.dev/packages/path_provider)** | Platform-specific directory paths for local storage |
| **[shared_preferences](https://pub.dev/packages/shared_preferences)** | Lightweight local storage for authentication tokens |

### UI & UX Packages
| Package | Purpose |
|---------|---------|
| **[flutter_screenutil](https://pub.dev/packages/flutter_screenutil)** | Responsive UI scaling across all screen sizes |
| **[cached_network_image](https://pub.dev/packages/cached_network_image)** | Image loading and caching for better performance |
| **[pinput](https://pub.dev/packages/pinput)** | Customizable OTP input fields |
| **[dotted_border](https://pub.dev/packages/dotted_border)** | Custom dashed borders matching Figma design |
| **[flutter_spinkit](https://pub.dev/packages/flutter_spinkit)** | Beautiful loading animations |
| **[flutter_svg](https://pub.dev/packages/flutter_svg)** | High-quality vector graphics rendering |
| **[smooth_page_indicator](https://pub.dev/packages/smooth_page_indicator)** | Interactive dot indicators for onboarding |
| **[google_fonts](https://pub.dev/packages/google_fonts)** | Modern typography directly from Google |

### Utility Packages
| Package | Purpose |
|---------|---------|
| **[connectivity_plus](https://pub.dev/packages/connectivity_plus)** | Real-time internet connectivity status |
| **[image_picker](https://pub.dev/packages/image_picker)** | Image selection from gallery or camera |

---

## 🏗️ Project Architecture

```
📁 lib/
│
├── 📂 controllers/               # GetX Controllers (Business Logic)
│   ├── 📂 auth/
│   │   └── auth_controller.dart
│   ├── 📂 product/
│   │   ├── product_controller.dart
│   │   └── add_edit_product_controller.dart
│   └── 📂 profile/
│       ├── profile_controller.dart
│       └── profile_setup_controller.dart
│
├── 📂 core/                      # Core configs & constants
│   ├── 📂 constants/
│   │   ├── api_constants.dart
│   │   ├── app_assets.dart
│   │   ├── app_colors.dart
│   │   ├── app_sizes.dart
│   │   └── app_strings.dart
│   └── 📂 network/
│       └── network_info.dart
│
├── 📂 data/                      # Data layer (Models, Repositories, API, Local DB)
│   ├── 📂 data_sources/
│   │   ├── 📂 local/
│   │   │   ├── shared_prefs_helper.dart
│   │   │   └── sqflite_helper.dart
│   │   └── 📂 remote/
│   │       └── api_client.dart
│   ├── 📂 models/
│   │   ├── product_model.dart
│   │   └── user_model.dart
│   └── 📂 repositories/
│       └── product_repository.dart
│
├── 📂 routes/                    # App routing management
│   ├── app_pages.dart
│   └── app_routes.dart
│
├── 📂 ui/                        # Presentation layer (Screens & Widgets)
│   ├── 📂 screens/
│   │   ├── 📂 auth/
│   │   │   ├── login_screen.dart
│   │   │   ├── register_screen.dart
│   │   │   ├── forgot_password_screen.dart
│   │   │   ├── verify_otp_screen.dart
│   │   │   └── reset_password_screen.dart
│   │   ├── 📂 home/
│   │   │   ├── home_screen.dart
│   │   │   ├── product_details_screen.dart
│   │   │   └── add_edit_product_screen.dart
│   │   └── 📂 profile/
│   │       ├── enable_location_screen.dart
│   │       ├── select_language_screen.dart
│   │       ├── setup_profile_screen.dart
│   │       └── profile_screen.dart
│   └── 📂 widgets/               # Reusable UI components
│       ├── custom_button.dart
│       ├── custom_textfield.dart
│       └── product_card.dart
│
└── 📄 main.dart                  # Application entry point
```

---

## 🚀 Getting Started

Follow these steps to run the application on your local machine:

### Prerequisites

- Flutter SDK (`^3.11.0` or higher)
- Dart SDK (`^3.0.0` or higher)
- Android Studio / VS Code
- An emulator or physical device

### Installation

**1. Clone the repository**

```bash
git clone https://github.com/SaidurRahman1004/sm_product_manager.git
cd sm_product_manager
```

**2. Install dependencies**

```bash
flutter clean
flutter pub get
```

**3. Run the application**

```bash
flutter run
```

---

## 📱 Platform Support

| Platform | Status |
|----------|--------|
| Android  | ✅ Supported |
| iOS      | ✅ Supported |
| Web      | 🚧 Coming Soon |
| Desktop  | 🚧 Coming Soon |

---

