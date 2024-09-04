import 'package:flutter/material.dart';
import 'package:validify/validify.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Password validator using the Validators class
  final ValidatorFunction _passwordValidator = Validators.combine([
    Validators.require(message: 'Password is required'),
    Validators.minLength(
      6,
      message: (length) => 'Password must be at least $length characters long',
    ),
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Validators Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: _EmailValidator().validate,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                validator: _passwordValidator,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Use this [_EmailValidator] or like this:
///
/// ```dart
///   final ValidatorFunction _emailValidator = Validators.combine([
///    Validators.require(message: 'Email is required'),
///    Validators.pattern(RegExp(r'^[^@]+@[^@]+\.[^@]+$'), message: 'Invalid email format'),
///  ]);
/// ```
class _EmailValidator extends Validify {
  @override
  List<ValidatorFunction> get validators => [
        Validators.require(message: 'Email is required'),
        Validators.pattern(RegExp(r'^[^@]+@[^@]+\.[^@]+$'),
            message: 'Invalid email format'),
      ];
}
