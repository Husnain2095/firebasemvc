import 'package:cartexample/User/User_Screen/fetch_screen.dart';
import 'package:cartexample/User/User_Screen/login_screen.dart';
import 'package:cartexample/User/User_Screen/register_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../User_Model/user_model.dart';

class FirebaseUserServices{

  final CollectionReference _userServices = FirebaseFirestore.instance.collection("User");

  void registerUser(UserModel userModel, BuildContext context)async{

    try{
      FirebaseAuth.instance.createUserWithEmailAndPassword(email: userModel.userEmail!, password: userModel.userPassword!);

      Map<String, dynamic> addUser = {
        "userID" : userModel.userID!,
        "userName" : userModel.userName!,
        "userEmail" : userModel.userEmail!,
        "userPassword" : userModel.userPassword!,
      };

      await _userServices.doc(userModel.userID).set(addUser);
    if(context.mounted){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("User Registered")));
      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen(),));
    }

     } catch (ex){
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went wrong")));
      }
    }

  }

  Stream<List<UserModel>> fetchUser(String userEmail){
    return _userServices.where('userEmail', isEqualTo: userEmail).snapshots().map((snapshot){
      return snapshot.docs.map((doc){
        Map<String, dynamic> uData = doc.data() as Map<String, dynamic>;
        return UserModel(
          userID: uData['userID'],
          userName: uData['userName'],
          userEmail: uData['userEmail'],
          userPassword: uData['userPassword']
        );
      }).toList();
    });
  }

  static Future getUserCred()async{
    SharedPreferences userCred = await SharedPreferences.getInstance();
    var userEmail = userCred.getString("email");
    return userEmail;
  }

  void loginUser(UserModel userModel, BuildContext context)async{

    try{
      FirebaseAuth.instance.signInWithEmailAndPassword(email: userModel.userEmail!, password: userModel.userPassword!);

      SharedPreferences userCred = await SharedPreferences.getInstance();
      userCred.setString("email", userModel.userEmail!);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("User LoggedIn")));
      Navigator.push(context, MaterialPageRoute(builder: (context) => const FetchScreen(),));
    }catch (ex){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went wrong")));
    }

  }

  void updateUser(UserModel userModel, BuildContext context){

    try{
      _userServices.doc(userModel.userID!).update({
        "userName" : userModel.userName!,
        "userEmail" : userModel.userEmail!,
        "userPassword" : userModel.userPassword!
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("User Updated")));
    }catch (ex){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went wrong")));
    }

  }

  void deleteUser(String userID, BuildContext context){
    try{
      FirebaseAuth.instance.currentUser!.delete();
      _userServices.doc(userID).delete();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("User Deleted")));
      Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen(),));
    }catch (ex){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went wrong")));
    }
  }

  void logOutUser(BuildContext context)async{
    FirebaseAuth.instance.signOut();
    SharedPreferences userCred = await SharedPreferences.getInstance();
    userCred.clear();
    Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen(),));
  }
}