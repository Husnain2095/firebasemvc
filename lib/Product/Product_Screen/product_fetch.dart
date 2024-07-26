import 'package:cartexample/Product/Product_Screen/product_add.dart';
import 'package:flutter/material.dart';

class ProductFetch extends StatefulWidget {
  const ProductFetch({super.key});

  @override
  State<ProductFetch> createState() => _ProductFetchState();
}

class _ProductFetchState extends State<ProductFetch> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: StreamBuilder(
      //     stream: _service.fetchProduct(),
      //     builder: (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
      //       if (snapshot.hasData) {
      //         var dataLength = snapshot.data!.length;
      //         return ListView.builder(
      //           itemCount: dataLength,
      //           itemBuilder: (context, index) {
      //
      //             ProductModel pData = snapshot.data![index];
      //
      //           return ListTile(
      //             title: Text(pData.pName!),
      //             subtitle: Text(pData.pPrice!),
      //             trailing: IconButton(onPressed: (){}, icon: const Icon(Icons.add_shopping_cart)),
      //           );
      //         },);
      //       } else if (snapshot.hasError) {
      //         return const Icon(Icons.error_outline);
      //       } else {
      //         return const CircularProgressIndicator();
      //       }
      //     }),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddProduct(),));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
