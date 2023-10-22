import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:galaxy_planets/controllers/FavProvider.dart';
import 'package:provider/provider.dart';

import 'DetailsScreen.dart';
import 'FavScreen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> rotateAnimation;
  late Animation<double> revAnimation;

  @override
  void initState() {
    super.initState();

    Provider.of<FavProvider>(context,listen: false).loadData();
    animationController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 10),
        lowerBound: 0.0,
        upperBound: 1.0);

    rotateAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        reverseCurve: Curves.easeInOutCubic,
        parent: animationController,
        curve: Curves.easeInOutCubic,
      ),
    );

    revAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        reverseCurve: Curves.easeInOutCubic,
        parent: animationController,
        curve: Curves.bounceInOut,
      ),
    );

    animationController.repeat();
    rotateAnimation.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    animationController;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(actions: [
          Consumer<FavProvider>(
            builder: (context, value, child) =>
            IconButton(onPressed: () {
              value.changeTheme();
            }, icon: Icon(value.themeMode==ThemeMode.light?Icons.nights_stay:Icons.light_mode)),
          ),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FavScreen(),
                    ));
              },
              icon: const Icon(Icons.favorite))
        ], title: Text(widget.title)),
        body: AnimatedBuilder(
          animation: animationController,
          builder: (context, child) {
            return Consumer<FavProvider>(
              builder: (context, value, child) =>
              Container(
                  decoration: BoxDecoration(
                      gradient: SweepGradient(
                          transform: const GradientRotation(5),
                          center: Alignment.bottomCenter,
                          startAngle: revAnimation.value * 2,
                          endAngle: revAnimation.value * 2 * pi,
                          colors: [
                        Colors.blue.shade100,
                        Colors.blue.shade200,
                        Colors.blue.shade300,
                        Colors.blue.shade400,
                        Colors.blue.shade500,
                        Colors.blue.shade600,
                        Colors.blue.shade700,
                        Colors.blue.shade800,
                        Colors.blue.shade900,
                        Colors.blue.shade50,
                      ])),
                  child: SingleChildScrollView(
                    child: Column(
                        children:
                            List.generate(value.planetModal?.planets?.length ?? 0, (index) {
                      return AnimatedBuilder(
                        animation: animationController,
                        builder: (BuildContext context, Widget? child) {
                          return Card(
                            margin: const EdgeInsets.symmetric(
                                    vertical: 30, horizontal: 15)
                                .copyWith(bottom: 0),
                            child: Container(
                              alignment: Alignment.topCenter,
                              child: Column(
                                children: [
                                  Transform.rotate(
                                    angle: index != 6
                                        ? rotateAnimation.value * 2 * pi
                                        : 0,
                                    child: SizedBox.square(
                                      child: Image.network(
                                          value.planetModal?.planets![index].image ?? ''),
                                    ),
                                  ),
                                  Text(value.planetModal?.planets?[index].name ?? '',
                                      style:
                                          Theme.of(context).textTheme.bodyLarge),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => DetailsScreen(
                                                  planet: value.planetModal!.planets![index]),
                                            ));
                                      },
                                      child: Text.rich(TextSpan(
                                          text:
                                          value.planetModal?.planets?[index].description ??
                                                  '',
                                          children: const [
                                            TextSpan(
                                                text: '  View More...  ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.green))
                                          ])),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    })),
                  )),
            );
          },
        ));
  }
}
