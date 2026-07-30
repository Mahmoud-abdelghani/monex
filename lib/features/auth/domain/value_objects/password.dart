class Password {
  final String value;
  Password(this.value) {
    if (value.isEmpty) {
      throw ArgumentError('Password cannot be empty');
    }  if (value.length < 6) {
      throw ArgumentError('Password must be at least 6 characters');
    }  if (!upperCase() && !lowerCase()) {
      throw ArgumentError(
        'Password must contain at least one uppercase and one lowercase letter',
      );
    }  if (!specialCharacter()) {
      throw ArgumentError(
        'Password must contain at least one special character',
      );
    }
  }

  bool upperCase() {
    return value.contains(RegExp(r'[A-Z]'));
  }

  bool lowerCase() {
    return value.contains(RegExp(r'[a-z]'));
  }

  bool specialCharacter() {
    return value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  }
}
