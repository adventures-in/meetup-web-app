import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AuthGate(),
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // User is not signed in
        if (!snapshot.hasData) {
          return const SignInScreen(providerConfigs: [
            EmailProviderConfiguration(),
          ]);
        }

        // Render your application if authenticated
        return const MyCustomForm();
      },
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      appBar: AppBar(title: const Text('Profile page')),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              const TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Phone number',
                ),
              ),
              const TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// https://docs.flutter.dev/cookbook/forms/validation
