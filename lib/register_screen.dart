import 'package:cartexample/firebase_services.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController userEmail = TextEditingController();
  final TextEditingController userPassword = TextEditingController();

  final FirebaseService _service = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          const SizedBox(height: 10,),

          TextFormField(
            controller: userEmail,
          ),

          const SizedBox(height: 10,),

          TextFormField(
            controller: userPassword,
          ),

          const SizedBox(height: 10,),

          ElevatedButton(onPressed: (){
            _service.userRegister(userEmail.text, userPassword.text, context);
          }, child: const Text("Register"))

        ],
      ),
    );
  }
}
