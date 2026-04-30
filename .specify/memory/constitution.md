<!--
Sync Impact Report:
- Version change: [CONSTITUTION_VERSION] -> 1.0.0
- Modified principles:
  - Added: I. Architecture Principles (Clean Architecture)
  - Added: II. State Management (bloc-cubit)
  - Added: III. Data Handling (Repositories, DTOs)
  - Added: IV. Error Handling (Result/Either pattern)
  - Added: V. UI & UX Standards (Responsive, Material)
  - Added: VI. Code Quality (camelCase, PascalCase, DRY)
  - Added: VII. Feature Development (Feature-based structure)
  - Added: VIII. Testing (Unit tests for Use cases and Repositories)
  - Added: IX. Performance (Avoid rebuilds, const widgets)
  - Added: X. Maintainability (Readable, self-explanatory)
  - Added: XI. Dependencies (Minimal, stable)
  - Added: XII. Security (No API keys in code, secure storage)
  - Removed template placeholders (PRINCIPLE_1_NAME to PRINCIPLE_5_NAME)
- Templates requiring updates:
  - ✅ .specify/templates/plan-template.md
  - ✅ .specify/templates/tasks-template.md
  - ⚠ .specify/templates/spec-template.md (No explicit changes required, verified alignment)
- Follow-up TODOs: None.
-->
# MindTrip Constitution

## Core Principles

### I. Architecture Principles
The project must follow Clean Architecture: Presentation Layer (UI), Domain Layer (Business Logic), and Data Layer (API, Local Storage). Each layer must be independent and decoupled. No direct dependency from Presentation to Data.

### II. State Management
Use bloc-cubit for state management. Avoid mixing multiple state management solutions. State must be predictable and testable.

### III. Data Handling
All data access must go through Repositories. No direct API calls inside UI. Use DTOs for API models and map them to domain entities.

### IV. Error Handling
All failures must be handled explicitly. No silent failures or ignored exceptions. Use Result/Either pattern for domain operations.

### V. UI & UX Standards
UI must be responsive across devices and consistent with the design system. Avoid hardcoded values by using constants and themes. Follow Material Design best practices.

### VI. Code Quality
Follow consistent naming conventions: camelCase for variables, PascalCase for classes. Keep functions small and focused. Avoid duplicated logic (DRY principle).

### VII. Feature Development
Development must be feature-based. Each feature must include its own Model, Repository, Use cases, and UI. Features must be modular and scalable.

### VIII. Testing (NON-NEGOTIABLE)
Write unit tests for Use cases and Repositories. Critical logic must be tested. Avoid untested business logic.

### IX. Performance
Avoid unnecessary rebuilds in UI. Use const widgets where possible. Optimize network calls and caching.

### X. Maintainability
Code must be readable and self-explanatory. Avoid overly complex abstractions. Refactor when needed to keep code clean.

### XI. Dependencies
Keep external dependencies minimal. Prefer stable and well-maintained packages. Avoid unnecessary libraries.

### XII. Security
Never expose API keys in code. Use secure storage when needed. Validate all external data.

## Governance

The Constitution supersedes all other practices. Amendments require documentation, approval, and a migration plan. All PRs/reviews must verify compliance with the Core Principles. Complexity must be justified.

**Version**: 1.0.0 | **Ratified**: 2026-04-30 | **Last Amended**: 2026-04-30
