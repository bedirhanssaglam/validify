<p float="center">
  <img src="https://github.com/user-attachments/assets/4042c25d-4c92-4370-afd3-69bd035b3887" />
</p>

## Table of contents

- [Features](#features)

- [Installation](#installation)

- [Usage](#usage)

- [API Reference](#api-reference)

- [Why Use This System](#why-use-this-system)

- [Dart Version](#dart-version)

- [Issues](#issues)

- [Contribute](#contribute)

- [Author](#author)

- [License](#license)

### Features

The code in this repository is designed to streamline the validation process in your Flutter projects. It consists of:

- **Custom Validators**: Easily create and combine validators tailored to your needs.

- **Synchronous and Asynchronous Validation**: Supports both types of validation, including remote checks and complex operations.

- **Built-in Validators**: Includes a variety of common validators like required fields, min/max length, regex pattern matching, and more.

- **Flexible Error Messages**: Customize error messages for each validation rule.

### Installation

To use `validify` in your Dart or Flutter project, add the following dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  validify: ^0.0.1
```

Then, run `flutter pub get` to install the package.

### Usage

```dart
class EmailValidator extends Validify {
  @override
  List<ValidatorFunction> get validators => [
        Validator.require(message: 'Email is required'),
        Validator.pattern(r'^[^@]+@[^@]+\.[^@]+$', message: 'Invalid email format'),
      ];
}

TextFormField(
  controller: _emailController,
  decoration: const InputDecoration(
    labelText: 'Email',
    border: OutlineInputBorder(),
  ),
  validator: EmailValidator().validate,
),

/// ------------ or ------------

final ValidatorFunction _passwordValidator = Validators.combine([
  Validators.require(message: 'Password is required'),
  Validators.minLength(6, message: (length) => 'Password must be at least $length characters long'),
]);

TextFormField(
  controller: _passwordController,
  obscureText: true,
  decoration: const InputDecoration(
    labelText: 'Password',
    border: OutlineInputBorder(),
  ),
  validator: _passwordValidator,
),
```

### API Reference

#### Validators
A utility class for creating and managing validation rules:

- `require({String? message})`: Validator for checking if a value is not empty.
- `minLength(int length, {String? Function(int)? message})`: Validator for minimum length.
- `maxLength(int length, {String? Function(int)? message})`: Validator for maximum length.
- `pattern(RegExp pattern, {String? message})`: Validator for matching a regex pattern.
- `combine(List<ValidatorFunction> validators)`: Combines multiple validators.
- `equality(String firstValue, String secondValue, {required String message})`: Checks if two values are equal.
- `asyncPattern(RegExp pattern, {String? message})`: Asynchronous validator for regex pattern matching.
- `custom({required bool Function(String? value) condition, required String message})`: Custom validator based on a condition.
- `trimAndValidate(ValidatorFunction validator)`: Trims whitespace and then applies the provided validator.
- `dateAfter(DateTime date, {String? message})`: Validator for checking if a date is after a specified date.
- `combineAsync(List<AsyncValidatorFunction> validators)`: Combines multiple asynchronous validators.

### Why Use This System?

- **Reusable**: Once set up, you can reuse these validators across different projects.

- **Extensible**: Easily extend and customize validators for specific use cases.

- **Clean Code**: Encourages clean and maintainable code by abstracting validation logic.

### Dart Version

```yaml
  sdk: '>=2.17.0 <4.0.0'
```

### Issues

Please file any issues, bugs, or feature requests as an issue on [GitHub](https://github.com/bedirhanssaglam/validify/issues) page.

### Contribute

If you would like to contribute to the plugin (e.g. by improving the documentation, solving a bug, or adding a cool new feature), please carefully review our [contribution guide](./CONTRIBUTING.md) and send us your [pull request](https://github.com/bedirhanssaglam/validify/pulls).

### Author

This `validify` package is developed by [Bedirhan Sağlam](https://github.com/bedirhanssaglam). You can contact me at <bedirhansaglam270@gmail.com>

### License

MIT
