import 'package:flutter/foundation.dart' show immutable;

/// A class to hold default error messages used in validators.
@immutable
class ValidationMessages {
  const ValidationMessages._();

  /// Default message for required fields.
  static const String requiredField = 'This field is required';

  /// Default message for time out.
  static const String timedOut = 'Validation timed out';

  /// Default message for minimum length validation.
  static String minLength(int length) => 'Minimum length is $length characters';

  /// Default message for maximum length validation.
  static String maxLength(int length) => 'Maximum length is $length characters';

  /// Default message for invalid format.
  static const String invalidFormat = 'Invalid format';

  /// Default message for date validation.
  static String dateAfter(DateTime date) =>
      'Date must be after ${date.toLocal()}';
}
