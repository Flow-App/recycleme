import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recycleme/entities/DealEntity.dart';
import 'package:recycleme/repos/deals_rebo.dart';
import 'package:recycleme/screens/normal/Home/deals_tabs/deals_tab%20.dart';
import 'package:recycleme/screens/normal/Home/deals_tabs/deal_details_screen.dart';

part 'deals_event.dart';

part 'deals_state.dart';




class DealsBloc extends Bloc<DealEvent, DealState> {

  @override
  DealState get initialState => DealInitial();

  @override
  Stream<DealState> mapEventToState(DealEvent event,) async* {
    if(event is GoToDealProfile){
      yield TabChanged(DealDetailsScreen(event.dealEntity));
    }else if(event is BackToMainTab){
      yield TabChanged(DealsTab());

    } else if(event is UserAddedADeal){
      List<DealEntity> deals = await DealsRepo().getUserDeals();
      yield TabChanged(DealDetailsScreen(deals[0]));
    }


  }
}
