import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {

  final TextEditingController productName = TextEditingController();
  final TextEditingController productPrice = TextEditingController();
  final TextEditingController productDesc = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          const SizedBox(height: 10,),

          TextFormField(
            controller: productName,
          ),

          const SizedBox(height: 10,),

          TextFormField(
            controller: productPrice,
          ),

          const SizedBox(height: 10,),

          TextFormField(
            controller: productDesc,
          ),

          const SizedBox(height: 10,),


          ElevatedButton(onPressed: (){

          }, child: const Text("Add Product"))

        ],
      ),
    );
  }
}
