import 'package:cartexample/User/User_Controller/user_controller.dart';
import 'package:cartexample/User/User_Model/user_model.dart';
import 'package:flutter/material.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController userEmail = TextEditingController();
  final TextEditingController userPassword = TextEditingController();

  FirebaseUserServices uServices = FirebaseUserServices();

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
            uServices.loginUser(UserModel(
              userEmail: userEmail.text,
              userPassword: userPassword.text
            ), context);
          }, child: const Text("Login"))

        ],
      ),
    );
  }
}
