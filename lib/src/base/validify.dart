import 'package:validify/src/validators/index.dart';

/// An abstract base class for creating custom validators.
///
/// Subclasses should implement the [validators] property to provide
/// a list of validation functions that will be used to validate
/// input values. The [validate] method will then apply these validators
/// in sequence and return the first encountered error message, if any.
///
/// Subclasses should define their own set of validation rules by overriding
/// the [validators] property with a list of [ValidatorFunction]s.
abstract class Validify {
  /// A list of [ValidatorFunction]s that define the validation rules.
  ///
  /// Subclasses should override this property to provide their own
  /// validation functions. Each function in the list will be applied
  /// to the input value in the order they are specified.
  ///
  /// The validation functions should return an error message if the value
  /// is invalid, or `null` if the value passes the validation.
  abstract final List<ValidatorFunction> validators;

  /// Validates the given [value] using the list of validators.
  ///
  /// Iterates through the list of [validators] and applies each one to
  /// the provided [value]. The method returns the first error message
  /// encountered during the validation process. If all validators pass,
  /// the method returns `null`, indicating that the value is valid.
  ///
  /// This method is used to execute the defined validation rules and
  /// provide feedback on any validation errors.
  String? validate(String? value) {
    for (final validator in validators) {
      final result = validator(value);
      if (result != null) return result;
    }
    return null; // Return null if all validations pass.
  }
}
