import 'package:cartexample/User/User_Controller/user_controller.dart';
import 'package:cartexample/User/User_Model/user_model.dart';
import 'package:flutter/material.dart';

class FetchScreen extends StatefulWidget {
  const FetchScreen({super.key});

  @override
  State<FetchScreen> createState() => _FetchScreenState();
}

class _FetchScreenState extends State<FetchScreen> {

  FirebaseUserServices uServices = FirebaseUserServices();
  String uEmail = "";
  @override
  void initState() {
    FirebaseUserServices.getUserCred().then((value){
      setState(() {
        uEmail = value;
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: uServices.fetchUser(uEmail),
          builder: (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
            if (snapshot.hasData) {
              var userLength = snapshot.data!.length;
              return ListView.builder(
                itemCount: userLength,
                itemBuilder: (context, index) {

                  UserModel userData = snapshot.data![index];

                return ListTile(
                  title: Text(userData.userName!),
                  subtitle: Text(userData.userEmail!),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [

                        IconButton(onPressed: (){}, icon: const Icon(Icons.update)),
                        IconButton(onPressed: (){
                          uServices.deleteUser(userData.userID!, context);
                        }, icon: const Icon(Icons.delete)),

                      ],
                    ),
                  ),
                );
              },);
            } else if (snapshot.hasError) {
              return const Icon(Icons.error_outline);
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }
}
