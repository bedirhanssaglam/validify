import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:validify/validify.dart';

class _EmailValidator extends Validify {
  @override
  List<ValidatorFunction> get validators => [
        Validators.require(message: 'Email is required'),
        Validators.pattern(
          RegExp(r'^[^@]+@[^@]+\.[^@]+$'),
          message: 'Invalid email format',
        ),
      ];
}

void main() {
  group('TextFormField Widget Tests', () {
    testWidgets('TextFormField displays error for invalid email format', (
      WidgetTester tester,
    ) async {
      // Build the TextFormField widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      key: const Key('emailField'),
                      controller: TextEditingController(),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: _EmailValidator().validate,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        final form = Form.of(
                          tester.element(find.byType(TextFormField)),
                        );
                        form.validate(); // Trigger form validation
                      },
                      child: const Text('Validate'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      // Enter an invalid email
      await tester.enterText(
        find.byKey(const Key('emailField')),
        'invalidemail',
      );
      await tester.pump(); // Rebuild the widget

      // Tap the Validate button to trigger validation
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump(); // Rebuild the widget to show validation results

      // Find the error text
      expect(find.text('Invalid email format'), findsOneWidget);
    });

    testWidgets('TextFormField displays no error for valid email format', (
      WidgetTester tester,
    ) async {
      // Build the TextFormField widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      key: const Key('emailField'),
                      controller: TextEditingController(),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: _EmailValidator().validate,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        final form = Form.of(
                          tester.element(
                            find.byType(TextFormField),
                          ),
                        );
                        form.validate(); // Trigger form validation
                      },
                      child: const Text('Validate'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      // Enter a valid email
      await tester.enterText(
        find.byKey(const Key('emailField')),
        'test@example.com',
      );
      await tester.pump(); // Rebuild the widget

      // Tap the Validate button to trigger validation
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump(); // Rebuild the widget to show validation results

      // Ensure no error is displayed
      expect(find.text('Invalid email format'), findsNothing);
    });
  });
}
