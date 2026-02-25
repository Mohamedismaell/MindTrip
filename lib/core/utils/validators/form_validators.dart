import '../../enums/validation_type.dart';

class FormValidators {
  String? _validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your full name';
    }

    // Check for numbers
    if (value.contains(RegExp(r'[0-9]'))) {
      return 'Full name cannot contain numbers';
    }

    // Check for special characters (allow only letters and spaces)
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return 'Full name cannot contain special characters';
    }

    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    }

    // Check if email contains @
    if (!value.contains('@')) {
      return 'Email must contain @';
    }

    // Check for special characters (only allow letters, numbers, @, and .)
    if (!RegExp(r'^[a-zA-Z0-9@.]+$').hasMatch(value)) {
      return 'Email can only contain letters, numbers, @ and .';
    }

    // Basic email format validation
    if (!RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+$').hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }

    // Check minimum length
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    // Check for at least one capital letter
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least 1 capital letter';
    }

    return null;
  }

  String? getValidator(ValidationType validationType, String? value) {
    switch (validationType) {
      case ValidationType.fullName:
        return _validateFullName(value);
      case ValidationType.email:
        return _validateEmail(value);
      case ValidationType.password:
        return _validatePassword(value);
    }
  }
}
