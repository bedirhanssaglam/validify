import 'package:validify/src/constants/validation_messages.dart';

/// A typedef for the validator function, which returns an error message
/// if validation fails, otherwise null.
typedef ValidatorFunction = String? Function(String? value);

/// A typedef for an asynchronous validator function that returns a `Future`
/// containing an error message if validation fails, or `null` if validation
/// is successful.
///
/// This type is useful for validation scenarios where an asynchronous operation
/// is required, such as checking values against a remote server or performing
/// time-consuming checks. The function takes a nullable `String` value as input
/// and returns a `Future<String?>`:
/// - A `String` containing the error message if the validation fails.
/// - `null` if the validation passes.
typedef AsyncValidatorFunction = Future<String?> Function(String? value);

/// A class that provides a set of built-in validation functions and allows
/// chaining multiple validators for form field validation.
///
/// This class includes both synchronous and asynchronous validators.
class Validators {
  /// A private list to store the synchronous validator functions.
  final List<ValidatorFunction> _validators = [];

  /// Adds a synchronous validator function to the list of validators.
  ///
  /// This method returns the current instance of [Validators] to enable
  /// method chaining for adding multiple validators.
  Validators add(ValidatorFunction validator) {
    _validators.add(validator);
    return this; // Allows chaining: Validators().add(...).add(...);
  }

  /// Removes a synchronous validator function from the list of validators.
  ///
  /// This method returns the current instance of [Validators] to enable
  /// method chaining for removing multiple validators.
  Validators remove(ValidatorFunction validator) {
    _validators.remove(validator);
    return this;
  }

  /// Creates a validator that checks if the value is not empty.
  ///
  /// The [message] parameter can be used to customize the error message.
  /// If not provided, the default message is 'This field is required'.
  static ValidatorFunction require({String? message}) {
    return (value) {
      if (value == null || value.isEmpty) {
        return message ?? ValidationMessages.requiredField;
      }
      return null;
    };
  }

  /// Creates a validator that checks
  /// if the value meets the minimum length requirement.
  /// The [length] parameter specifies the minimum length. The [message]
  /// parameter can be used to customize the error message. If not provided,
  /// the default message is 'Minimum length is [length] characters'.
  static ValidatorFunction minLength(
    int length, {
    String? Function(int)? message,
  }) {
    return (value) {
      if (value == null || value.length < length) {
        return message != null
            ? message(length)
            : ValidationMessages.minLength(length);
      }
      return null;
    };
  }

  /// Creates validator that checks if the value does not exceed maximum length.
  ///
  /// The [length] parameter specifies the maximum length. The [message]
  /// parameter can be used to customize the error message. If not provided,
  /// the default message is 'Maximum length is [length] characters'.
  static ValidatorFunction maxLength(
    int length, {
    String? Function(int)? message,
  }) {
    return (value) {
      if (value != null && value.length > length) {
        return message != null
            ? message(length)
            : ValidationMessages.maxLength(length);
      }
      return null;
    };
  }

  /// Creates a validator that checks
  /// if the value matches the given regular expression pattern.
  ///
  /// The [pattern] parameter specifies the regular expression to match.
  /// The [message] parameter can be used to customize the error message.
  /// If not provided, the default message is 'Invalid format'.
  static ValidatorFunction pattern(RegExp pattern, {String? message}) {
    return (value) {
      if (value != null && !pattern.hasMatch(value)) {
        return message ?? ValidationMessages.invalidFormat;
      }
      return null;
    };
  }

  /// Creates a validator that combines multiple synchronous validators.
  ///
  /// This validator will iterate through the provided [validators] list and
  /// return the first error message encountered.
  /// If all validators pass, it returns null.
  static ValidatorFunction combine(List<ValidatorFunction> validators) {
    return (value) {
      for (final validator in validators) {
        final result = validator(value);
        if (result != null) return result;
      }
      return null;
    };
  }

  /// Creates a validator that checks if two values are equal.
  ///
  /// The [firstValue] and [secondValue] parameters are compared for equality.
  /// If they are not equal, the [message] is returned.
  /// Otherwise, it returns null.
  static ValidatorFunction equality(
    String firstValue,
    String secondValue, {
    required String message,
  }) {
    return (value) {
      if (firstValue != secondValue) return message;
      return null;
    };
  }

  /// Creates an asynchronous validator that checks
  /// if the value matches the given regular expression pattern.
  ///
  /// The [pattern] parameter specifies the regular expression to match.
  /// The [message] parameter can be used to customize the error message.
  /// If not provided, the default message is 'Invalid format'.
  static AsyncValidatorFunction asyncPattern(
    RegExp pattern, {
    String? message,
  }) {
    return (value) async {
      if (value != null && !pattern.hasMatch(value)) {
        return message ?? ValidationMessages.invalidFormat;
      }
      return null;
    };
  }

  /// Creates a custom validator based on a user-defined condition.
  ///
  /// The [condition] parameter is a function that determines if the validation
  /// should fail. If the condition returns true, the [message] is returned.
  /// Otherwise, it returns null.
  static ValidatorFunction custom({
    required bool Function(String? value) condition,
    required String message,
  }) {
    return (value) {
      if (condition(value)) return message;
      return null;
    };
  }

  /// Creates a validator that trims the input value and
  /// then applies the provided validator.
  ///
  /// This can be useful to ensure that whitespace is removed before validation.
  static ValidatorFunction trimAndValidate(ValidatorFunction validator) {
    return (value) {
      return validator(value?.trim());
    };
  }

  /// Creates a validator that checks if the date parsed from
  /// the value is after a specified date.
  ///
  /// The [date] specifies the date that the parsed date should be after.
  /// The [message] can be used to customize the error message.
  /// If not provided, the default message is 'Date must be after [date]'.
  static ValidatorFunction dateAfter(DateTime date, {String? message}) {
    return (value) {
      if (value == null) return null;
      final parsedDate = DateTime.tryParse(value);
      if (parsedDate == null || parsedDate.isBefore(date)) {
        return message ?? ValidationMessages.dateAfter(date);
      }
      return null;
    };
  }

  /// Creates an async validator that combines multiple asynchronous validators.
  ///
  /// This validator will iterate through the provided [validators] list and
  /// return the first error message encountered.
  /// If all validators pass, it returns null.
  static AsyncValidatorFunction combineAsync(
    List<AsyncValidatorFunction> validators,
  ) {
    return (value) async {
      for (final validator in validators) {
        final result = await validator(value);
        if (result != null) return result;
      }
      return null;
    };
  }
}
