import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
          () {
        Get.offAllNamed('photo');
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/img/logo.png",
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
               Text.rich(
                 TextSpan(
                   children: [
                     TextSpan(
                       text: "HK",
                       style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.blue.shade900)
                     ),

                     TextSpan(
                       text: " Wallpaper",
                       style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color:Colors.red.shade800)
                     ),
                   ]
                 )
               )
            ],
          ),
        ),
      ),
    );
  }
}
