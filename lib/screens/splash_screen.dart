import 'package:flutter/material.dart';
import 'package:recycleme/entities/UserEntity.dart';
import 'package:recycleme/repos/AuthRepo.dart';
import 'package:recycleme/repos/normal_repo.dart';
import 'package:recycleme/repos/testRepo.dart';
  import 'package:recycleme/screens/admin/AdminHomeScreen.dart';
import 'package:recycleme/screens/Auth/login_screen.dart';
import 'package:recycleme/screens/normal/Home/HomeScreen.dart';

import 'cp/ApprovalRejected.dart';
import 'cp/awaitng.dart';
import 'cp/cpHomeSceen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    setNavigator();
//    TestRepo().insertDummyBrands();
//    TestRepo().insertDummyAvvrgePrices();
//    TestRepo().insertUserDummyFavBrands();
//    TestRepo().insertDummyCp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Image.asset('assets/splash-logo.png'),
        ),
      ),
    );
  }

  setNavigator() async {
    final AuthRepo repo = AuthRepo();
    final bool isLoggedIn = await repo.isLoggedIn();
    if (isLoggedIn) {
      switch (await repo.getCurrentUserRole()) {
        case AuthRoles.User:
          UserEntity user = await NormalRepo().getCurrentUserProfile();
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return HomeScreen(user);
          }));
          break;
        case AuthRoles.Cp:
          switch (await repo.isApproved()) {
            case AuthStatus.gotApproval:
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return CpHomeScreen();
              }));
              break;
            case AuthStatus.awaitingApproval:
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return FinishApprovalScreen();
              }));
              break;
            case AuthStatus.ApproveRejected:
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return ApprovalRejected();
              }));
              break;
            default:
          }
          break;
        case AuthRoles.Admin:
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return AdminHomeScreen();
          }));

          break;
      }
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return LoginScreen();
      }));
    }
  }
}
