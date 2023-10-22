
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../modal/PlanetModal.dart';

class FavProvider extends ChangeNotifier {
  PlanetModal? planetModal;
  List<Planet> favPlanet = [];
  ThemeMode themeMode = ThemeMode.light;

  changeTheme(){
    themeMode = themeMode==ThemeMode.light?ThemeMode.dark:ThemeMode.light;
    notifyListeners();
  }

  bool isFavPlanet(String id) {
    bool isFav = false;
    favPlanet.forEach((element) {
      if (element.position == id) {
        isFav = true;
      }
    });
    notifyListeners();
    return isFav;
  }

  void addFav(Planet planet) {
    favPlanet.add(planet);
    notifyListeners();
  }

  void removeFav(Planet planet) {
    favPlanet.remove(planet);
    notifyListeners();
  }


  void loadData() async {
    planetModal = planetModalFromJson(await rootBundle.loadString('assets/planet.json'));
    notifyListeners();
  }


}
