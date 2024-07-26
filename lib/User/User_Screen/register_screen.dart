import 'package:cartexample/User/User_Controller/user_controller.dart';
import 'package:cartexample/User/User_Model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController userEmail = TextEditingController();
  final TextEditingController userName = TextEditingController();
  final TextEditingController userPassword = TextEditingController();

  FirebaseUserServices uServices = FirebaseUserServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          const SizedBox(height: 10,),

          TextFormField(
            controller: userName,
          ),

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

            uServices.registerUser(UserModel(
              userID: const Uuid().v1(),
              userName: userName.text,
              userEmail: userEmail.text,
              userPassword: userPassword.text
            ), context);

          }, child: const Text("Register"))

        ],
      ),
    );
  }
}
