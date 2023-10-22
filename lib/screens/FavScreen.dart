import 'package:flutter/material.dart';
import 'package:galaxy_planets/controllers/FavProvider.dart';
import 'package:provider/provider.dart';

import 'DetailsScreen.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({super.key});

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorite Planets')),
      body: Column(children: [
        Consumer<FavProvider>(
          builder: (context, value, child) =>
          Expanded(
            child: ListView.builder(itemBuilder: (context, index) {
              return SingleChildScrollView(
                child: Column(
                    children:
                    List.generate(value.favPlanet.length, (index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 30, horizontal: 15)
                            .copyWith(bottom: 0),
                        child: Container(
                          alignment: Alignment.topCenter,
                          child: Column(
                            children: [
                              SizedBox.square(
                                child: Image.network(
                                    value.favPlanet[index].image ?? ''),
                              ),
                              Text(value.favPlanet[index].name ?? '',
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
                                              planet: value.favPlanet[index]),
                                        ));
                                  },
                                  child: Text.rich(TextSpan(
                                      text:
                                      value.favPlanet[index].description ??
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
                    })),
              );
            },itemCount: value.favPlanet.length,),
          ),
        )
      ],),
    );
  }
}
