import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recycleme/entities/CPEntity.dart';
import 'package:recycleme/entities/ListItemEntity.dart';
import 'package:recycleme/entities/TypeEntity.dart';
import 'package:recycleme/entities/brand_entity.dart';
import 'package:recycleme/repos/collect_repo.dart';
import 'package:recycleme/repos/deals_rebo.dart';
import 'package:recycleme/screens/normal/Home/collect_tabs/SelectedItems.dart';
import 'package:recycleme/screens/normal/Home/collect_tabs/WhatToCollectScreen.dart';
import 'package:recycleme/screens/normal/Home/collect_tabs/add_by_weight.dart';
import 'package:recycleme/screens/normal/Home/collect_tabs/add_to_list.dart';
import 'package:recycleme/screens/normal/Home/collect_tabs/application_submitted.dart';
import 'package:recycleme/screens/normal/Home/collect_tabs/chose_collection_point.dart';
import 'package:recycleme/screens/normal/Home/collect_tabs/collect_for_recycle.dart';
import 'package:recycleme/screens/normal/Home/collect_tabs/favorite_brands.dart';
import 'package:recycleme/screens/normal/Home/collect_tabs/final_tab.dart';
import 'package:recycleme/screens/normal/Home/collect_tabs/main_list.dart';
import 'package:recycleme/screens/normal/Home/collect_tabs/types_screen.dart';
import 'package:recycleme/config.dart';

part 'collect_event.dart';

part 'collect_state.dart';

Map<String, Widget> tabs = {
  'categores': WhatToCollectScreen(),
  'AddToList': AddToList(),
  'Types': TypesScreen(),
  'SelectedItems': SelectedItems(),
  'AddbyWeight': AddbyWeight(),
  'addFromFav': FavoriteBrands(),
  'MainList': MainList(),
  'zeroPAge': CollectForRecycle(),
  'ChoseACpToDealWith': ChoseCpToMakeADealWith(),
  'sucess': ApplicationSubmitted(),
  'FinshCollectiong' : FinshColletiong()
};

class CollectBloc extends Bloc<CollectEvent, CollectState> {
  Category selectedCategoery;
  TypeEntity selectedTypeEntity;
  List<ListItemEntity> itemsToAdd = [];
  List<ListItemEntity> allSelectedItems = [];
  Map<String, double> prices = {};
  CPEntity selectedCp;
  @override
  CollectState get initialState => CollectInitial();

  @override
  Stream<CollectState> mapEventToState(
    CollectEvent event,
  ) async* {
    if (event is UserSelectedCategory) {
      selectedCategoery = event.category;
      yield WidgetChanged(tabs['AddToList']);
    } else if (event is GoToCategoreies) {
      itemsToAdd.clear();
      yield WidgetChanged(tabs['categores']);
    } else if (event is BackToTypesScreen) {
      yield WidgetChanged(tabs['Types']);
    } else if (event is AddByType) {
      if (selectedCategoery == Category.Paper) {
        selectedTypeEntity = TypeEntity(
          name: 'paper',
        );
        yield WidgetChanged(tabs['AddbyWeight']);
      } else {
        yield WidgetChanged(tabs['Types']);
      }
    } else if (event is BackToAddToList) {
      yield WidgetChanged(tabs['AddToList']);
    } else if (event is BackToSelectedItemsScreen) {
      if (allSelectedItems.length == 0) {
        yield WidgetChanged(tabs['categores']);
      } else {
        yield WidgetChanged(tabs['categores']);
      }
    } else if (event is UserPickedAType) {
      selectedTypeEntity = event.typeEntity;
      yield WidgetChanged(tabs['AddbyWeight']);
    } else if (event is UserAddedByWeight) {
//      Map<String, int> prices = await CollectRepo().getTypesAvrPrice();
      List<ListItemEntity> newList = [];
      if (itemsToAdd.length == 0) {
        newList.add(ListItemEntity(
            brand: BrandEntity(
                weight: event.grams,
                brandName: selectedTypeEntity.name,
//         TODO       price:  double.parse(prices['undefined'].toString()),
                price: 12.5,
                type: selectedTypeEntity.name,
                category: categoryName[selectedCategoery]),
            quntity: 1));
      } else {
        bool added = false;
        itemsToAdd.forEach((item) {
          if (item.brand.brandName == selectedTypeEntity.name) {
            item.brand.weight += event.grams;
            newList.add(item);
            added = true;
          } else {
            newList.add(item);
          }
        });

        if (!added) {
          newList.add(ListItemEntity(
              brand: BrandEntity(
                  weight: event.grams,
                  brandName: selectedTypeEntity.name,
                  price: 0),
              quntity: 1));
        }
      }
      itemsToAdd.clear();
      itemsToAdd.addAll(newList);
      selectedTypeEntity = null;

      yield WidgetChanged(tabs['AddToList']);
    } else if (event is ListItemPlusPlus) {
      List<ListItemEntity> newList = [];
      itemsToAdd.forEach((item) {
        if (item.brand.brandName == event.item.brand.brandName) {
          event.item.quntity++;
          newList.add(event.item);
        } else {
          newList.add(item);
        }
      });
      itemsToAdd.clear();
      itemsToAdd.addAll(newList);
      yield AddListChanged(itemsToAdd);
    } else if (event is ListItemMinMin) {
      List<ListItemEntity> newList = [];
      itemsToAdd.forEach((item) {
        if (item.brand.brandName == event.item.brand.brandName) {
          if (event.item.quntity == 1) {
            // usere wana delete
          } else {
            event.item.quntity--;
            newList.add(event.item);
          }
        } else {
          newList.add(item);
        }
      });
      itemsToAdd.clear();
      itemsToAdd.addAll(newList);
      yield AddListChanged(itemsToAdd);
    } else if (event is AddByFav) {
      yield WidgetChanged(tabs['addFromFav']);
    } else if (event is UserPickedABrand) {
      yield BrandsListChanged([]);
      List<ListItemEntity> newList = [];
      if (itemsToAdd.length == 0) {
        newList.add(ListItemEntity(brand: event.brandEntity, quntity: 1));
      } else {
        bool added = false;
        itemsToAdd.forEach((item) {
          if (item.brand.brandName == event.brandEntity.brandName) {
            newList.add(ListItemEntity(
                brand: event.brandEntity, quntity: item.quntity + 1));
            added = true;
          } else {
            newList.add(item);
          }
        });

        if (!added) {
          newList.add(ListItemEntity(brand: event.brandEntity, quntity: 1));
        }
      }
      itemsToAdd.clear();
      itemsToAdd.addAll(newList);
      selectedTypeEntity = null;
      yield WidgetChanged(tabs['AddToList']);
    } else if (event is GetBrandByName) {
      List<BrandEntity> list = await CollectRepo()
          .getBrandsByCategory(category: selectedCategoery, name: event.name);
      print(list.length);
      yield BrandsListChanged(list);
    } else if (event is UserAddedItemsToMainList) {
      allSelectedItems.addAll(itemsToAdd);
      itemsToAdd.clear();
      yield WidgetChanged(tabs['MainList']);
    } else if (event is BackToMainCollectTab) {
      if (allSelectedItems.length > 0) {
        yield WidgetChanged(tabs['MainList']);
      } else {
        yield WidgetChanged(tabs['zeroPAge']);
      }
    } else if (event is UserClickedFinish) {
      yield WidgetChanged(tabs['ChoseACpToDealWith']);
    } else if (event is UserPickedCollectionPoint) {
      selectedCp = event.cpEntity ;
      yield WidgetChanged(tabs['FinshCollectiong']);
    } else if (event is UserConfirmed) {
      bool result = await DealsRepo()
          .makeAdeal(cp:selectedCp , items: allSelectedItems);
      if (result) {
        allSelectedItems = [];
      } else {
        yield MakeingDealFeild();
      }
    }
  }
}
