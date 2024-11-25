import 'package:get/get.dart';

import '../models/Animal.dart';

class GenerateAnimalList {
  List<Animal> animalsList = [
    Animal("ant".tr, "assets/images/animals/ant.png"),
    Animal("bears".tr, "assets/images/animals/bears.png"),
    Animal("cat".tr, "assets/images/animals/cat.png"),
    Animal("cheetah".tr, "assets/images/animals/cheetah.png"),
    Animal("crocodile".tr, "assets/images/animals/crocodile.png"),
    Animal("dog".tr, "assets/images/animals/dog.png"),
    Animal("elephant".tr, "assets/images/animals/elephant.png"),
    Animal("fox".tr, "assets/images/animals/fox.png"),
    Animal("gazelle".tr, "assets/images/animals/gazelle.png"),
    Animal("hedgehog".tr, "assets/images/animals/hedgehog.png"),
    Animal("lion".tr, "assets/images/animals/lion.png"),
    Animal("lizard".tr, "assets/images/animals/lizard.png"),
    Animal("owl".tr, "assets/images/animals/owl.png"),
    Animal("panda".tr, "assets/images/animals/panda.png"),
    Animal("parrot".tr, "assets/images/animals/parrot.png"),
    Animal("pelican".tr, "assets/images/animals/pelican.png"),
    Animal("pig".tr, "assets/images/animals/pig.png"),
    Animal("rabbit".tr, "assets/images/animals/rabbit.png"),
    Animal("raccoon".tr, "assets/images/animals/raccoon.png"),
    Animal("squirrel".tr, "assets/images/animals/squirrel.png"),
    Animal("tiger".tr, "assets/images/animals/tiger.png"),
    Animal("turtle".tr, "assets/images/animals/turtle.png"),
    Animal("zebra".tr, "assets/images/animals/zebra.png"),
  ];

  List<Animal> getRandomAnimal() {
    List<Animal> result = [];
    List<Animal> animals = animalsList;
    for (int i = 0; i < 6; i++) {
      var randomItem = (animals..shuffle()).first;
      result.add(randomItem);
      animals.remove(randomItem);
    }
    return result;
  }
}
