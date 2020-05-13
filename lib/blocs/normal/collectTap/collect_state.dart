part of  'collect_bloc.dart';

//@immutable


abstract class CollectState {}
class CollectInitial extends CollectState{

}
class WidgetChanged extends CollectState{
 final Widget widget ;
 WidgetChanged(this.widget);
}
class PickType extends CollectState{
  final Category category ;
  PickType(this.category);
}
class AddListChanged extends CollectState{
 final List<ListItemEntity>  list;
 AddListChanged(this.list);
}


class BrandsListChanged extends CollectState{
  final List<BrandEntity>  list;
  BrandsListChanged(this.list);
}

class MakeingDealFeild extends CollectState{

  }

