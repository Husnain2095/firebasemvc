import 'package:cartexample/login_screen.dart';
import 'package:cartexample/product_fetch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseService{

  final _firebaseAuth = FirebaseAuth.instance;
  final _firebaseFirestore = FirebaseFirestore.instance.collection("Product");

  void userRegister(String userEmail , String userPassword, BuildContext context)async{
    try{
      await _firebaseAuth.createUserWithEmailAndPassword(email: userEmail, password: userPassword);
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("User Registered")));
        Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen(),));
      }
    } catch(ex){
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went Wrong")));
      }
    }
  }

  void userLogin(String userEmail , String userPassword, BuildContext context)async{
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: userEmail, password: userPassword);
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("User Logged In")));
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductFetch(),));
      }
    } catch(ex){
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went Wrong")));
      }
    }
  }

  void productAdd(ProductModel pModel, BuildContext context)async{
    try{
      await _firebaseFirestore.add({
        "pName" : pModel.pName,
        "pPrice" : pModel.pPrice,
        "pDesc" : pModel.pDesc,
      });
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Product Added Successfully")));
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductFetch(),));
      }
    }catch(ex){
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went Wrong")));
      }
    }
  }

  void cartAdd(CartModel cModel, BuildContext context)async{
    try{
      await _firebaseFirestore.add({
        "pName" : cModel.pName,
        "pPrice" : cModel.pPrice,
        "pDesc" : cModel.pDesc,
        "userEmail" :cModel.userEmail
      });
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Product Added to Cart Successfully")));
      }
    }catch(ex){
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went Wrong")));
      }
    }
  }

  Stream<List<ProductModel>> fetchProduct(){
    return _firebaseFirestore.snapshots().map((snapshot){
      return snapshot.docs.map((doc){
        Map<String, dynamic> pData = doc.data();
        return ProductModel(
          pName: pData['pName'],
          pPrice: pData['pPrice'],
          pDesc: pData['pDesc'],
        );
      }).toList();
    });
  }

  Stream<List<CartModel>> cartFetch(){
    return _firebaseFirestore.snapshots().map((snapshot){
      return snapshot.docs.map((doc){
        Map<String, dynamic> pData = doc.data();
        return CartModel(
          pName: pData['pName'],
          pPrice: pData['pPrice'],
          pDesc: pData['pDesc'],
          userEmail: pData['userEmail']
        );
      }).toList();
    });
  }

}

class ProductModel{
  final String? pName;
  final String? pPrice;
  final String? pDesc;

  ProductModel({this.pName, this.pPrice, this.pDesc});
}

class CartModel{
  final String? pName;
  final String? pPrice;
  final String? pDesc;
  final String? userEmail;

  CartModel({this.pName, this.pPrice, this.pDesc, this.userEmail});
}