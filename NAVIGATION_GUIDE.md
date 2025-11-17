# GoRouter Navigation Setup for MindTrip

## Project Structure

```
lib/
├── core/
│   └── routes/
│       ├── app_routes.dart          # Route constants
│       ├── app_router.dart          # Main router configuration
│       ├── navigation_helper.dart   # Navigation utility methods
│       └── routes.dart             # Barrel export file
├── features/
│   ├── splash/
│   │   └── routes/
│   │       └── splash_routes.dart   # Splash & onboarding routes
│   └── authetication/
│       └── routes/
│           └── auth_routes.dart     # Authentication routes
└── main.dart                       # App entry point
```

## Key Features

### ✅ **Modular Route Organization**

- Each feature has its own route configuration
- Easy to maintain and scale
- Clear separation of concerns

### ✅ **Type-Safe Navigation**

- Centralized route constants
- Helper methods for navigation
- Compile-time route validation

### ✅ **Advanced Navigation Features**

- Error handling with custom error screen
- Redirect logic support
- Debug logging in development

## How to Use

### 1. Basic Navigation

```dart
import 'package:flutter/material.dart';
import '../../../../../core/routes/navigation_helper.dart';

class MyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => NavigationHelper.goToOnBoarding1(context),
      child: Text('Go to Onboarding'),
    );
  }
}
```

### 2. Available Navigation Methods

```dart
// Basic navigation
NavigationHelper.goToSplash(context);
NavigationHelper.goToOnBoarding1(context);
NavigationHelper.goToLogin(context);

// Navigation with stack management
NavigationHelper.goAndReplace(context, AppRoutes.login);
NavigationHelper.goAndClearStack(context, AppRoutes.home);

// Navigation with parameters
NavigationHelper.goWithParams(context, AppRoutes.profile, {'userId': '123'});

// Stack operations
NavigationHelper.goBack(context);
NavigationHelper.pushTo(context, AppRoutes.settings);
```

### 3. Adding New Routes

#### Step 1: Add route constant

```dart
// In app_routes.dart
class AppRoutes {
  static const String newScreen = '/new-screen';
}
```

#### Step 2: Create route configuration

```dart
// In your feature's routes file
GoRoute(
  path: AppRoutes.newScreen,
  name: 'newScreen',
  builder: (context, state) => const NewScreen(),
),
```

#### Step 3: Add navigation helper (optional)

```dart
// In navigation_helper.dart
static void goToNewScreen(BuildContext context) {
  context.go(AppRoutes.newScreen);
}
```

#### Step 4: Register route in main router

```dart
// In app_router.dart, add to routes list
routes: [
  ...SplashRoutes.routes,
  ...AuthenticationRoutes.routes,
  ...NewFeatureRoutes.routes, // <- Add your new feature routes
],
```

### 4. Route Parameters

For routes that need parameters:

```dart
// Define parameterized route
GoRoute(
  path: '/user/:userId',
  name: 'userProfile',
  builder: (context, state) {
    final userId = state.pathParameters['userId']!;
    return UserProfileScreen(userId: userId);
  },
),

// Navigate with parameters
context.go('/user/123');
// or
NavigationHelper.goWithParams(context, '/user', {'userId': '123'});
```

### 5. Query Parameters

```dart
// Navigate with query parameters
context.go('/search?query=flutter&category=mobile');

// Access in destination screen
final query = state.uri.queryParameters['query'];
final category = state.uri.queryParameters['category'];
```

## Error Handling

The router includes built-in error handling:

```dart
errorBuilder: (context, state) => ErrorScreen(error: state.error),
```

## Authentication & Guards

Add route guards in the redirect function:

```dart
redirect: (context, state) {
  // Check authentication status
  final isAuthenticated = AuthService.instance.isLoggedIn;

  // Define public routes that don't require authentication
  final publicRoutes = [
    AppRoutes.splash,
    AppRoutes.onBoarding1,
    AppRoutes.login,
    AppRoutes.register,
  ];

  // Redirect to login if not authenticated and trying to access private route
  if (!isAuthenticated && !publicRoutes.contains(state.location)) {
    return AppRoutes.login;
  }

  // Redirect to home if authenticated and trying to access auth pages
  if (isAuthenticated && [AppRoutes.login, AppRoutes.register].contains(state.location)) {
    return AppRoutes.home;
  }

  return null; // No redirect needed
},
```

## Benefits of This Structure

1. **🔧 Maintainable**: Each feature manages its own routes
2. **📈 Scalable**: Easy to add new features without touching existing code
3. **🛡️ Type-Safe**: Centralized route constants prevent typos
4. **🎯 Testable**: Each route module can be tested independently
5. **🔍 Debuggable**: Built-in logging and error handling
6. **📱 Flutter-Friendly**: Follows Flutter best practices

## Migration from Old Setup

Your old main.dart routing is now replaced with this modular system. The new setup provides:

- Better organization
- Easier maintenance
- Type safety
- Advanced navigation features
- Future-proof architecture

## Next Steps

1. ✅ Routes are set up and working
2. 🔄 Update all navigation calls to use `NavigationHelper`
3. 🔒 Add authentication logic to redirect function
4. 📊 Add analytics tracking to navigation events
5. 🧪 Write tests for navigation flows
