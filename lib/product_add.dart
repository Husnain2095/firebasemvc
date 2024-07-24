import 'package:cartexample/firebase_services.dart';
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

  final FirebaseService _services = FirebaseService();

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
            _services.productAdd(ProductModel(

              pName: productName.text,
              pDesc: productDesc.text,
              pPrice: productPrice.text

            ), context);
          }, child: const Text("Add Product"))

        ],
      ),
    );
  }
}
