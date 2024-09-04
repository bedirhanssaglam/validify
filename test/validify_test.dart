import 'package:flutter_test/flutter_test.dart';
import 'package:validify/validify.dart';

void main() {
  group('Validators Class Tests', () {
    test('Required validator should return error for null value', () {
      final validator = Validators.require(message: 'Field is required');
      final result = validator(null);
      expect(result, 'Field is required');
    });

    test('Required validator should return error for empty value', () {
      final validator = Validators.require(message: 'Field is required');
      final result = validator('');
      expect(result, 'Field is required');
    });

    test('Required validator should return null for non-empty value', () {
      final validator = Validators.require(message: 'Field is required');
      final result = validator('Not Empty');
      expect(result, isNull); // Expecting null (no validation error)
    });

    test('MinLength validator should return error for short value', () {
      final validator = Validators.minLength(5, message: (_) => 'Too short');
      final result = validator('123');
      expect(result, 'Too short');
    });

    test('MinLength validator should return null for valid value', () {
      final validator = Validators.minLength(5, message: (_) => 'Too short');
      final result = validator('12345');
      expect(result, isNull); // Expecting null (no validation error)
    });

    test('MaxLength validator should return error for long value', () {
      final validator = Validators.maxLength(5, message: (_) => 'Too long');
      final result = validator('123456');
      expect(result, 'Too long');
    });

    test('MaxLength validator should return null for valid value', () {
      final validator = Validators.maxLength(5, message: (_) => 'Too long');
      final result = validator('12345');
      expect(result, isNull); // Expecting null (no validation error)
    });

    test('Pattern validator should return error for invalid pattern', () {
      final validator =
          Validators.pattern(RegExp(r'^\d+$'), message: 'Only digits allowed');
      final result = validator('abc123');
      expect(result, 'Only digits allowed');
    });

    test('Pattern validator should return null for valid pattern', () {
      final validator =
          Validators.pattern(RegExp(r'^\d+$'), message: 'Only digits allowed');
      final result = validator('123456');
      expect(result, isNull); // Expecting null (no validation error)
    });

    test('Combine validator should return error from second failing validator',
        () {
      final combinedValidator = Validators.combine(
        [
          Validators.minLength(5, message: (_) => 'Too short'),
          Validators.maxLength(
            10,
            message: (_) => 'Too long',
          ),
        ],
      );
      final result = combinedValidator('123456789012');
      expect(result, 'Too long');
    });

    test('Equality validator should return error for non-matching values', () {
      final equalityValidator = Validators.equality(
        'password123',
        'password321',
        message: 'Passwords do not match',
      );
      final result = equalityValidator('password123');
      expect(result, 'Passwords do not match');
    });

    test('Equality validator should return null for matching values', () {
      final equalityValidator = Validators.equality(
        'password123',
        'password123',
        message: 'Passwords do not match',
      );
      final result = equalityValidator('password123');
      expect(result, isNull); // Expecting null (no validation error)
    });

    test('AsyncPattern validator should return error for invalid pattern',
        () async {
      final asyncValidator = Validators.asyncPattern(RegExp(r'^\d+$'),
          message: 'Only digits allowed');
      final result = await asyncValidator('abc123');
      expect(result, 'Only digits allowed');
    });

    test('AsyncPattern validator should return null for valid pattern',
        () async {
      final asyncValidator = Validators.asyncPattern(RegExp(r'^\d+$'),
          message: 'Only digits allowed');
      final result = await asyncValidator('123456');
      expect(result, isNull); // Expecting null (no validation error)
    });

    test('Custom validator should return error when condition is true', () {
      final customValidator = Validators.custom(
        condition: (value) => value == 'error',
        message: 'Custom error',
      );
      final result = customValidator('error');
      expect(result, 'Custom error');
    });

    test('Custom validator should return null when condition is false', () {
      final customValidator = Validators.custom(
        condition: (value) => value == 'error',
        message: 'Custom error',
      );
      final result = customValidator('valid');
      expect(result, isNull); // Expecting null (no validation error)
    });

    test('TrimAndValidate should trim value before validation', () {
      final trimAndValidate = Validators.trimAndValidate(
        Validators.require(
          message: 'Field is required',
        ),
      );
      final result = trimAndValidate('  ');
      expect(result, 'Field is required');
    });

    test(
        'DateAfter validator should return error for date before the specified date',
        () {
      final dateValidator = Validators.dateAfter(
        DateTime(2024),
        message: 'Date must be after January 1, 2024',
      );
      final result = dateValidator('2023-12-31');
      expect(result, 'Date must be after January 1, 2024');
    });

    test(
        'DateAfter validator should return null for date after the specified date',
        () {
      final dateValidator = Validators.dateAfter(
        DateTime(2024),
        message: 'Date must be after January 1, 2024',
      );
      final result = dateValidator('2024-01-02');
      expect(result, isNull); // Expecting null (no validation error)
    });

    test('CombineAsync should return error from first failing validator',
        () async {
      final combinedAsyncValidator = Validators.combineAsync(
        [
          Validators.asyncPattern(RegExp(r'^\d+$'),
              message: 'Only digits allowed'),
          Validators.asyncPattern(
            RegExp(r'^[a-zA-Z]+$'),
            message: 'Only letters allowed',
          ),
        ],
      );
      final result = await combinedAsyncValidator('123abc');
      expect(result, 'Only digits allowed');
    });
  });
}
