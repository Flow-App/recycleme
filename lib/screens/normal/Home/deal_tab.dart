import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recycleme/blocs/normal/collectTap/collect_bloc.dart';
import 'package:recycleme/blocs/normal/deals_bloc/deals_bloc.dart';
import 'package:recycleme/screens/normal/Home/collect_tabs/collect_for_recycle.dart';

import 'deals_tabs/deals_tab .dart';


class DealsMainTab extends StatefulWidget {
  @override
  _DealsMainTabState createState() => _DealsMainTabState();
}

class _DealsMainTabState extends State<DealsMainTab> {
  Widget currentStep;

  Widget collectForRecycle = CollectForRecycle();

  @override
  void initState() {
    currentStep = DealsTab();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DealsBloc, DealState>(
      listener: (_, state) {
        if (state is TabChanged) {
          setState(() {
            currentStep = state.tab;
          });
        }
      },
      child: Scaffold(
        body: currentStep,
      ),
    );
  }
}

