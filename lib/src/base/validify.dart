import 'package:validify/src/validators/index.dart';

/// Abstract class for creating custom validators.
abstract class Validify {
  //// List of validators that need to be implemented in subclasses.
  abstract final List<ValidatorFunction> validators;

  /// Method that iterates over the list of validators and
  /// returns the first error message encountered.
  String? validate(String? value) {
    for (final validator in validators) {
      final result = validator(value);
      if (result != null) return result;
    }
    return null; // Return null if all validations pass.
  }
}
