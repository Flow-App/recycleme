import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recycleme/blocs/normal/collectTap/collect_bloc.dart';
import 'package:recycleme/screens/normal/Home/collect_tabs/collect_for_recycle.dart';


class CollectTab extends StatefulWidget {
  @override
  _CollectTabState createState() => _CollectTabState();
}

class _CollectTabState extends State<CollectTab> {
  Widget currentStep;

  Widget collectForRecycle = CollectForRecycle();

  @override
  void initState() {
    currentStep = CollectForRecycle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CollectBloc, CollectState>(
      listener: (_, state) {
        if (state is WidgetChanged) {
          setState(() {
            currentStep = state.widget;
          });
        }
      },
      child: Scaffold(
        body: currentStep,
      ),
    );
  }
}

