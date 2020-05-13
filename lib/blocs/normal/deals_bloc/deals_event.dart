part of 'deals_bloc.dart';

//@immutable
abstract class DealEvent {}

class GoToDealProfile extends DealEvent {
  final DealEntity dealEntity;

  GoToDealProfile(this.dealEntity);
}

class BackToMainTab extends DealEvent {}

class UserAddedADeal extends DealEvent {}
