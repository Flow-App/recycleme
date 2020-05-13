part  of 'collect_bloc.dart';

//@immutable
abstract class CollectEvent {}

class BackToMainCollectTab extends CollectEvent {}

class UserSelectedCategory extends CollectEvent {
  final Category category;

  UserSelectedCategory(this.category);
}

class GoToCategoreies extends CollectEvent {}

class UserChoseCategory extends CollectEvent {
  final Category category;

  UserChoseCategory(this.category);
}

class AddByType extends CollectEvent {}

class AddByFav extends CollectEvent {}

class BackToAddToList extends CollectEvent {}

class BackToSelectedItemsScreen extends CollectEvent {}

class BackToTypesScreen extends CollectEvent {}

class GetBrandByName extends CollectEvent {
  String name;

  GetBrandByName({this.name});
}

class UserPickedAType extends CollectEvent {
  final TypeEntity typeEntity;

  UserPickedAType(this.typeEntity);
}

class UserAddedByWeight extends CollectEvent {
  final int grams;

  UserAddedByWeight(this.grams);
}

class ListItemPlusPlus extends CollectEvent {
  final ListItemEntity item;

  ListItemPlusPlus(this.item);
}

class ListItemMinMin extends CollectEvent {
  final ListItemEntity item;

  ListItemMinMin(this.item);
}

class ListItemAdded extends CollectEvent {
  final ListItemEntity entity;

  ListItemAdded(this.entity);
}

class ListItemRemoved extends CollectEvent {
  final ListItemEntity entity;

  ListItemRemoved(this.entity);
}

class UserPickedABrand extends CollectEvent {
  final BrandEntity brandEntity;

  UserPickedABrand(this.brandEntity);
}
class UserAddedItemsToMainList extends CollectEvent {}
class UserClickedFinish extends CollectEvent {}
class UserPickedCollectionPoint extends CollectEvent {
  final CPEntity cpEntity;
  UserPickedCollectionPoint(this.cpEntity);
}
class UserConfirmed extends CollectEvent {

}



