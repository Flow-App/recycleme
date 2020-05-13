part of 'deals_bloc.dart';

//@immutable


abstract class DealState {}
class DealInitial extends DealState{

}

class TabChanged extends DealState{
final Widget tab;

TabChanged(this.tab);

}

