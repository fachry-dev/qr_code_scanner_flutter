import 'package:flutter/material.dart';

import 'package:qr_scanner/home/home_controller.dart';





class HomeView extends StatelessWidget {
  

  final HomeController controller = HomeController();

 

  HomeView({super.key});



  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar:  AppBar(

        title: Text('EvenPass'),

        actions: [

          IconButton(

            onPressed: () => controller.goToQRCodeView(context),

            icon: Icon(Icons.qr_code_scanner)),

        ],

      ),

      body: Center(child: Text("Welcome to EvenPass"),),

    );
  }
  
  }
