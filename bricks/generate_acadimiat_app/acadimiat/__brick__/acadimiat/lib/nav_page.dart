import 'dart:async';
import 'package:acadmiat/core/globals.dart';
import 'package:acadmiat/features/home_feature/presentation/pages/home/pages/home_page.dart';
import 'package:acadmiat/features/profile_feature/presentation/pages/profile/profile_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'Locale/locale.dart';
import 'Theme/style.dart';
import 'core/bottom_sheet/update_bottom_sheet.dart';
import 'core/functions.dart';
import 'core/widgets/double_back_to_close_widget.dart';
import 'features/authentication_feature/data/data_sources/remot_data_sources/authenticate_remote_data_functions.dart';
import 'features/authentication_feature/presentation/pages/login_page.dart';
import 'features/consultancies_feature/presentation/pages/consultation/consultation_page.dart';
import 'features/home_feature/presentation/pages/favorite/pages/favorite_page.dart';
import 'features/my_courses_feature/presentation/pages/my_courses/my_courses_page.dart';
import 'package:app_version_update_lite/app_version_update_lite.dart';

class NavPage extends StatefulWidget {
  const NavPage({Key? key,this.from}) : super(key: key);
  final int ? from;
  @override
  _NavPageState createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  Timer? timer;
  @override
  void initState() {
    super.initState();
    _verifyVersion();

    ///If user login we have to refresh token each 10 minutes.
    if(isLoggedIn()){
      refreshToken();
    }
  }

  void _verifyVersion() async {
    await AppVersionUpdate.checkForUpdates(
      appleId: '1661460868',
    ).then((result) async {
      if (result.canUpdate!) {
        _showUpdateBottomSheet(context);
      }
    });
  }


  ///Function to refresh token each period of time
  Future<void> refreshToken() async {
    AuthenticateRemoteDataFunctions functions = AuthenticateRemoteDataFunctions();
    int statusCode = await functions.testRefreshToken();

    timer = Timer.periodic(
        const Duration(minutes: 10), (Timer t) async {

      statusCode= await functions.testRefreshToken();

    });

    if(statusCode==400){
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginPage()),
              (Route<dynamic> route) => false);
    }

  }


  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return DoubleBackToCloseWidget(
      child: Scaffold(
        extendBody: true,
        bottomNavigationBar: CurvedNavigationBar(
          animationCurve: Curves.easeInOut,
          key: bottomNavigationKey,
          index: page,
          height: 70, //size.height * 0.086,
          items: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 45,
                  child: SvgPicture.asset(
                    "assets/svgs/bottomHome.svg",
                    color: (page == 0) ? Colors.white : Colors.grey,
                  ),
                ),
                if (page != 0)
                  Text(
                    locale.main!,
                    maxLines: 1,
                    style: blackBoldTextStyle(context: context,fontSize: 10, color: Colors.grey),
                  ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 45,
                  child: SvgPicture.asset(
                    "assets/svgs/bottomFavorite.svg",
                    color: (page == 1) ? Colors.white : Colors.grey,
                  ),
                ),
                if (page != 1)
                  Text(
                    locale.favorite!,
                    maxLines: 1,
                    style: blackBoldTextStyle(context: context,fontSize: 10, color: Colors.grey),
                  ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 45,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SvgPicture.asset(
                      "assets/svgs/bottomCourse.svg",
                      color: (page == 2) ? Colors.white : Colors.grey,
                    ),
                  ),
                ),
                if (page != 2)
                  Text(
                    locale.myCourses!,
                    maxLines: 1,
                    style: blackBoldTextStyle(context: context,fontSize: 10, color: Colors.grey),
                  ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 45,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: SvgPicture.asset(
                      "assets/svgs/consulting.svg",
                      color: (page == 3) ? Colors.white : Colors.grey,
                    ),
                  ),
                ),
                if (page != 3)
                  Text(
                    locale.myConsultation!,
                    maxLines: 1,
                    style: blackBoldTextStyle(context: context,fontSize: 10, color: Colors.grey),
                  ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                SizedBox(
                  width: 45,
                  child: SvgPicture.asset(
                    "assets/svgs/profileIcon.svg",
                    color: (page == 4) ? Colors.white : Colors.grey,
                  ),
                ),
                if (page != 4)
                  Text(
                    locale.profile!,
                    maxLines: 1,
                    style: blackBoldTextStyle(context: context,fontSize: 10, color: Colors.grey),
                  ),
              ],
            ),
          ],
          color: Theme.of(context).cardColor,
          backgroundColor: const Color.fromRGBO(236, 82, 82, 0),
             buttonBackgroundColor:Theme.of(context).primaryColor,

          animationDuration: const Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              lastPage = page;
              page = index;
            });
          },
          letIndexChange: (index) => true,
        ),
        body: buildColumn(page),
      ),
    );
  }

  Widget buildColumn(int page) {
    switch (page) {
      case 0:
        return const HomePageViewCase();
      case 1:
        return const FavoritePage();
      case 2:
        return   const MyCoursesPage();
      case 3:
        return  const ConsultationPage();
      case 4:
        return  ProfilePage(context_: context,);

      default:
        return Container();
    }

  }

  /// Function to show the bottom sheet
  Future<void> _showUpdateBottomSheet(BuildContext context) async {
     showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return const UpdateBottomSheet();
      },
    );

  }
}
