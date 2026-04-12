# MindTrip App - User Flow Diagram

## Authentication & Onboarding Flow

```mermaid
flowchart TD
    A([App Launch]) --> B[Splash Screen]
    B --> C{First Time User?}

    C -->|Yes| D[Onboarding Screen]
    D --> E[Interests Screen]
    E --> F[Welcome/Auth Screen]
    F --> G{Sign In / Sign Up}

    C -->|No| H{Valid Token?}
    H -->|Yes| I[Home Screen]
    H -->|No| J[Login Screen]

    G -->|Sign Up| K[Sign Up Screen]
    G -->|Sign In| J

    K --> L{Forgot Password?}
    J --> L

    L -->|Yes| M[Forget Password Screen]
    L -->|No| I

    M --> N[OTP Verification]
    N --> O[Reset Password Screen]
    O --> P[Complete Reset Screen]
    P --> I

    K --> Q[Complete Sign Up Screen]
    Q --> I

    I --> R{Home Screen}
    R --> S[Logout]
    S --> J
```

## Navigation Flow

```mermaid
flowchart LR
    subgraph Splash
        A1[Splash Screen]
    end

    subgraph Onboarding
        B1[Onboarding] --> B2[Interests] --> B3[Welcome Auth]
    end

    subgraph Authentication
        C1[Login] <--> C2[Sign Up]
        C1 --> C3[Forgot Password]
        C3 --> C4[OTP Verification]
        C4 --> C5[Reset Password]
        C5 --> C6[Complete Reset]
    end

    subgraph MainApp
        D1[Home Screen]
    end

    A1 --> B1
    A1 --> D1
    B3 --> C1
    C1 --> D1
    C6 --> D1
```

## State-Based Routing Logic

```mermaid
stateDiagram-v2
    [*] --> Loading: App Start

    state Loading {
        [*] --> CheckStorage
        CheckStorage --> Onboarding: First Time
        CheckStorage --> ValidateToken: Returning User
    }

    Loading --> Onboarding: isFirstTime == true
    Loading --> Auth: No Token
    Loading --> Home: Token Valid

    Onboarding --> Auth: Complete

    state Auth {
        [*] --> Login
        Login --> SignUp
        SignUp --> Login
        Login --> ForgotPassword
        ForgotPassword --> Login: Reset Complete
        SignUp --> Home: Signup Complete
    }

    Auth --> Home: Login Success
    Home --> Auth: Logout
```

## Key Screens

| Screen           | Route                          | Description                   |
| ---------------- | ------------------------------ | ----------------------------- |
| Splash           | `/splash`                      | App initialization            |
| Onboarding       | `/onboarding`                  | Welcome screens for new users |
| Interests        | `/interests`                   | Select user interests         |
| Welcome Auth     | `/welcomeauth`                 | Prompt to login/signup        |
| Login            | `/login`                       | Sign in form                  |
| Sign Up          | `/signup`                      | Registration form             |
| Forgot Password  | `/forgetPassword`              | Password reset request        |
| OTP Verification | `/otpVerification`             | Verify reset code             |
| Reset Password   | `/resetPassword`               | Set new password              |
| Complete Sign Up | `/completeSignUpScreen`        | Finish registration           |
| Complete Reset   | `/completeResetPasswordScreen` | Confirm password reset        |
| Home             | `/home`                        | Main app screen               |

## Gate States (AppGateCubit)

```
AppGateLoading → AppGateOnboarding → AppGateUnauthenticated → AppGateAuthenticated
                        ↓                   ↓                       ↓
                   (isFirstTime)       (no token)              (logged in)
```
