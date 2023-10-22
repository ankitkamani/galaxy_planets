import 'package:flutter/material.dart';
import 'package:galaxy_planets/screens/HomeScreen.dart';

class SpleshScreen extends StatefulWidget {
  const SpleshScreen({super.key});

  @override
  State<SpleshScreen> createState() => _SpleshScreenState();
}

class _SpleshScreenState extends State<SpleshScreen> {

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3),() {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Galaxy Planets'),));
    },);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            child: Image.asset('assets/splesh.jpg',fit: BoxFit.fill),
          ),
          const Positioned(bottom:50,child: Text('Welcome To Galaxy World',style: TextStyle(color: Colors.white,fontSize: 30),))
        ],
      ),
    );
  }
}
