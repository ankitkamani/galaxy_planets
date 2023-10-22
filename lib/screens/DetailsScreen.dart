import 'package:flutter/material.dart';
import 'package:galaxy_planets/controllers/FavProvider.dart';
import 'package:galaxy_planets/modal/PlanetModal.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatefulWidget {
  final Planet planet;

  const DetailsScreen({super.key, required this.planet});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    Planet planet = widget.planet;
    return Scaffold(
      appBar: AppBar(
          actions: [
            Consumer<FavProvider>(
              builder: (context, value, child) => IconButton(
                  onPressed: () {
                    value.isFavPlanet(planet.position??'')?value.removeFav(planet):value.addFav(planet);
                  },
                  icon: Icon(value.isFavPlanet(planet.position??'')?Icons.favorite:Icons.favorite_border_rounded)),
            )
          ],
          title: Text(
            planet.name ?? '',
            style: const TextStyle(fontWeight: FontWeight.bold),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox.square(
              child: Image.network(planet.image ?? ''),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Type',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const Text('Velocity',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const Text('Distance',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const Text('Distance From Sun',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const Text('Distance In Unit',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const Text('Diameter',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const Text('Diameter Unit',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const Text('Mass',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const Text('Mass Unit',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const Text('Gravity',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const Text('Gravity Unit',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    planet.atmosphere?.isEmpty ?? false
                        ? const SizedBox()
                        : const Text('Atmosphere\n',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                    const Text('Moon',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const Text('Description',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 5,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(planet.type ?? '-'),
                      Text(planet.velocity ?? '-'),
                      Text(planet.distance ?? '-'),
                      Text(planet.distanceFromSun?.value ?? '-'),
                      Text(planet.distanceFromSun?.unit.toString() ?? '-'),
                      Text(planet.diameter?.value.toString() ?? '-'),
                      Text(planet.diameter?.unit.toString() ?? '-'),
                      Text(planet.mass?.value.toString() ?? '-'),
                      Text(planet.mass?.unit.toString() ?? '-'),
                      Text(planet.gravity?.value.toString() ?? '-'),
                      Text(planet.gravity?.unit.toString() ?? '-'),
                      planet.atmosphere?.isEmpty ?? false
                          ? const SizedBox()
                          : SizedBox(
                              width: MediaQuery.sizeOf(context).width * .5,
                              child: Text(planet.atmosphere.toString().isEmpty
                                  ? '-'
                                  : planet.atmosphere.toString() ?? '-')),
                      Text(planet.moons?.length.toString() ?? '0'),
                      SizedBox(
                          width: MediaQuery.sizeOf(context).width * .5,
                          child: Text(planet.description ?? '-'))
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
