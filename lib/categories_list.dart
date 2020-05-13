 import 'package:recycleme/entities/TypeEntity.dart';
import 'package:recycleme/config.dart';

Map<Category, List<TypeEntity>> types = {
  Category.Plastic: [
    TypeEntity(
        name: 'PET / PETE / Polyester',
        iconPath: 'assets/pet01.png',
        picPath: 'assets/bottles.png',
        samples: 'Polyester fibers, soft drink bottles, food containers'),
    //1
    TypeEntity(
        name: 'HDPE',
        iconPath: 'assets/hdpe.png',
        picPath: 'assets/detergent.png',
        samples: 'Plastic milk containers, plastic bags, bottle caps'),
    // 2
    TypeEntity(
        name: 'PVC',
        iconPath: 'assets/pvc.webp',
        picPath: '',
        samples:
        'Window frames, bottles for chemicals, flooring, plumbing pipes'),
    //3
    TypeEntity(
        name: 'LDPE',
        iconPath: 'assets/hdpe.png',
        picPath: '',
        samples:
        'Plastic bags, Ziploc bags, buckets, squeeze bottles, plastic tubes'),
    //4
    TypeEntity(
        name: 'PP',
        iconPath: 'assets/LDPE.png',
        picPath: '',
        samples:
        'Flower pots, bumpers, car interior trim, industrial fibers'),
    //5
    TypeEntity(
        name: 'PS',
        iconPath: 'assets/PS.png',
        picPath: '',
        samples:
        'Toys, video cassettes, ashtrays, trunks, beverage/food coolers, beer cups'),
    //6
    TypeEntity(
        name: 'Other',
        iconPath: 'assets/plastic_other.webp',
        picPath: '',
        samples: ''),
    // 7
    TypeEntity(
        name: 'Undefined',
        iconPath: '',
        picPath: '',
        samples: ''),
    // 8
  ],
  Category.Paper: [
//    TypeEntity(
//        name: 'PAP 20',
//        iconPath: 'assets/pap20.png',
//        picPath: '',
//        samples: 'Cardboard boxes'),
//    //1
//    TypeEntity(
//        name: 'PAP 21',
//        iconPath: 'assets/pap21.png',
//        picPath: '',
//        samples: 'Cereal and snack boxes'),
//    //2
//    TypeEntity(
//        name: 'PAP 22',
//        iconPath: 'assets/pap22.png',
//        picPath: '',
//        samples:
//        'Newspaper, books, magazines, wrapping paper, wallpaper, paper bags'),
//    //3
//    TypeEntity(
//        name: 'Undefined / Other', iconPath: '', picPath: '', samples: ''),
    //4
  ],
  Category.Glass: [
    TypeEntity(
        name: 'colorless transparent (CT)',
        iconPath: '',
        picPath: '',
        samples: ''),
    //1
    TypeEntity(name: 'green (G)', iconPath: '', picPath: '', samples: ''),
    //2
    TypeEntity(name: 'brown (B)', iconPath: '', picPath: '', samples: ''),
    //3
    TypeEntity(
        name: 'Undefined / Other', iconPath: '', picPath: '', samples: ''),
    // 4
  ],
  Category.Tin: [
    TypeEntity(
        name: 'Steel',
        iconPath: 'assets/steel.png',
        picPath: '',
        samples: 'Food cans'),
    //1
    TypeEntity(
        name: 'Aluminum',
        iconPath: 'assets/alu.png',
        picPath: '',
        samples:
        'Soft drink cans, deodorant cans , aluminium foil, heat sinks'),
    //2
    TypeEntity(
        name: 'Undefined / Other', iconPath: '', picPath: '', samples: ''),
    // 3
  ],
  Category.Battery: [
    TypeEntity(
        name: 'Steel',
        iconPath: 'assets/steel.png',
        picPath: '',
        samples: 'Food cans'),
    //1
    TypeEntity(
        name: 'Aluminum',
        iconPath: 'assets/alu.png',
        picPath: '',
        samples:
        'Soft drink cans, deodorant cans , aluminium foil, heat sinks'),
    //2
    TypeEntity(
        name: 'Undefined / Other', iconPath: '', picPath: '', samples: ''),
    //3
  ]
};