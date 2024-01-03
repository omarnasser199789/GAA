import 'package:acadmiat/core/widgets/custom_botton.dart';
import 'package:acadmiat/features/authentication_feature/presentation/pages/login_page.dart';
import 'package:acadmiat/features/profile_feature/presentation/bloc/bloc.dart';
import 'package:acadmiat/features/profile_feature/presentation/pages/profile_personly_folder/profile_personly_page.dart';
import 'package:acadmiat/features/profile_feature/presentation/pages/training_plan_folder/training_plan_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:image_cropper/image_cropper.dart';
import '../../../../../../core/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../Locale/locale.dart';
import '../../../../../Theme/style.dart';
import '../../../../../core/functions.dart';
import '../../../../../core/util/assets_manager.dart';
import '../../../../../injection_container.dart';
import '../../../../../launch_page.dart';
import '../../widgets/app_versio.dart';
import '../privacy_policy_page.dart';
import '../../../domain/entities/user_info_entity.dart';
import '../terms_and_conditions_page.dart';
import '../certificates_page.dart';
import '../../../../../core/globals.dart';
import '../../widgets/info_box_widget.dart';
import '../../../../../core/widgets/cached_net_work_image.dart';
import '../file_explorer_page.dart';
import '../help_page.dart';
import '../my_notes_page.dart';
import '../my_requests_page.dart';
import 'package:share_plus/share_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:in_app_review/in_app_review.dart';
import 'header_option_widget.dart';
import 'option_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.context_});
  final BuildContext context_;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var darkMode = false;
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  UserInfoEntity userInfoEntity = UserInfoEntity(id: -1, groupId: -1, userId: -1, sex: -1, dateOfBirth: '', active: false, name: '', email: '', phone: null, profileImage: '', notes: null, addedDate: '', addedBy: -1, updateAt: '', user: null, group: null, courses: null, b2Bcourses: null, path: null);

  _reviewApp()async{
    final InAppReview inAppReview = InAppReview.instance;
    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
    }
  }

  @override
  Widget build(BuildContext context) {
    _reviewApp();
    var locale = AppLocalizations.of(context)!;
    if (globalSH.getString("ThemeMode") == "") {
      darkMode = false;
    } else if (globalSH.getString("ThemeMode") == "dark") {
      darkMode = true;
    } else if (globalSH.getString("ThemeMode") == "light") {
      darkMode = false;
    }
    return BlocProvider(
        create: (BuildContext context) => sl<ProfileBloc>(),
        child:
            BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
              if (kDebugMode) {
                print("state:$state");
              }
              if ((state is Empty || state is SuccessUpdateUserAvtarEntity) &&
                  isLoggedIn()) {
                BlocProvider.of<ProfileBloc>(context).add(GetUserInfo(userId: userId()));
              }

              if (state is SuccessGetUserInfoEntity) {
                userInfoEntity = state.userInfoEntity;
              }


              return Scaffold(
               appBar: appBarWidget(locale.myAccount!, context, false, null, null),
               backgroundColor: Theme.of(context).scaffoldBackgroundColor,
               body: SingleChildScrollView(
                 child: Column(
                   children: [
                     isLoggedIn()
                         ? Column(
                         children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 15, left: 17, right: 17),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${locale.welcome} ${userInfoEntity.name}",
                                        style: blackBoldTextStyle(context: context, fontSize: 15),
                                      ),
                                      const SizedBox(height: 9),
                                      Text(
                                        userInfoEntity.email,
                                        style: blackBoldTextStyle(context: context, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      (userInfoEntity.profileImage!="")?
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          width: 55,
                                          height: 55,
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(5000),
                                              child: (image == null)
                                                  ? CachedNetWorkImage(borderRadius: const BorderRadius.all(Radius.circular(6)),
                                                      url: userInfoEntity.profileImage,
                                                      boxFit: BoxFit.fill,
                                                    )
                                                  : Image(image: AssetImage(image!.path),fit: BoxFit.fill,)),
                                        ),
                                      ):
                                      Container(
                                        width: 55,
                                        height: 55,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: iconsColor,width: 1.7),
                                          borderRadius: BorderRadius.circular(5000),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(2),
                                          child: SvgPicture.asset(
                                            ImgAssets.profileIcon,
                                            color: iconsColor,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          var img = await _picker.pickImage(source: ImageSource.gallery);
                                          setState(() {});
                                          CroppedFile? croppedFile =
                                              await ImageCropper().cropImage(
                                            sourcePath: img!.path,
                                            cropStyle: CropStyle.circle,
                                          );
                                          image = XFile(croppedFile!.path);
                                          BlocProvider.of<ProfileBloc>(context).add(UpdateMyAvatar(image: image!.path, userId: userId().toString()));
                                        },
                                        child: Container(
                                            width: 28,
                                            height: 28,
                                            decoration: BoxDecoration(
                                                color: Theme.of(context).primaryColor,
                                                borderRadius: BorderRadius.circular(5000)),
                                            child: Padding(
                                              padding: const EdgeInsets.all(6.0),
                                              child: SvgPicture.asset(
                                                ImgAssets.camera,
                                              ),
                                            )),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 31, left: 17, right: 17, bottom: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InfoBoxType2(
                                    svg: ImgAssets.file,
                                    title: '5',
                                    text: "التنزيلات",
                                    onTap: () {
                                      goTo(context,
                                          (context) =>const FileExplorerPage());
                                    },
                                  ),
                                  InfoBoxType2(
                                    svg: ImgAssets.noteblock,
                                    title: '2',
                                    text: "دفتر الملاحظات",
                                    onTap: () {
                                      goTo(context, (context) =>const MyNotePage());
                                    },
                                  ),
                                  InfoBoxType2(
                                    svg: ImgAssets.planIcon,
                                    title: '2',
                                    text: "الخطة التدريبية",
                                    onTap: () {
                                      goTo(context, (context) =>const TrainingPlanPage());
                                    },
                                  ),
                                  InfoBoxType2(
                                    svg: ImgAssets.medalStar,
                                    title: '2',
                                    text: "شهاداتي",
                                    onTap: () async {
                                      var res = await goTo(context,
                                          (context) =>const CertificatesPage());
                                      if (res == 200) {}
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 17, right: 17, bottom: 15, top: 16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("أهلا بك، في ماستري", style: blackBoldTextStyle(fontSize: 15, context: context),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text("تعلم ونمى مهارتك مع أفضل الدورات والخبراء ", style: blackBoldTextStyle(
                                        fontSize: 12, context: context),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      goTo(context, (context) =>const LoginPage());
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 18.8),
                                      child: Text(
                                        "تسجيل الدخول/ اشتراك جديد",
                                        style: blackBoldTextStyle(fontSize: 12, context: context, color: Theme.of(context).primaryColor),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Column(
                      children: [
                        if (isLoggedIn())
                          Container(
                            color: Theme.of(context).cardColor,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: Column(
                                children: [
                                   HeaderOptionWidget(
                                    svg: ImgAssets.user,
                                    text: 'حسابي',
                                  ),
                                  OptionWidget(
                                    onTap: () async {
                                    await goTo(
                                          context,
                                          (context) => ProfilePersonlyPage(
                                              userInfoEntity: userInfoEntity));
                                      setState(() {});
                                    },
                                    title: "الملف الشخصي",
                                  ),
                                  OptionWidget(
                                    onTap: () {
                                      goTo(context,
                                          (context) =>const MyRequestsPage());
                                    },
                                    title: "طلباتي",
                                  ),

                                ],
                              ),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Container(
                            color: Theme.of(context).cardColor,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: Column(
                                children: [
                                   HeaderOptionWidget(
                                    svg: ImgAssets.setting,
                                    text: 'إعدادات التطبيق',
                                    svgWidth: 23,
                                  ),

                                  Container(
                                    color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.1),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 16,
                                          top: 16,
                                          left: 17,
                                          right: 17),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "تفعيل الوضع الليلي",
                                                style: blackBoldTextStyle(context: context, fontSize: 13),
                                              ),

                                              const SizedBox(width: 20),

                                              GestureDetector(
                                                onTap: () {
                                                  LaunchPage.themeNotifier.value = ThemeMode.system;
                                                  globalSH.setString("ThemeMode", "");
                                                  setState(() {});
                                                },
                                                child: Text("تلقائي",
                                                    style: blackBoldTextStyle(context: context, fontSize: 13, color: (globalSH.getString("ThemeMode") == "") ? Theme.of(context).primaryColor : iconsColor,)),
                                              ),
                                            ],
                                          ),

                                          CupertinoSwitch(
                                            value: darkMode,
                                            onChanged: (value) {
                                              darkMode = value;
                                              if (darkMode == true) {
                                                LaunchPage.themeNotifier.value = ThemeMode.dark;
                                                globalSH.setString("ThemeMode", "dark");
                                              } else {
                                                LaunchPage.themeNotifier.value = ThemeMode.light;
                                                globalSH.setString("ThemeMode", "light");
                                              }
                                              setState(() {});
                                            },
                                          ),
                                          // const Icon(Icons.arrow_forward_ios,color: Colors.grey,size: 20,),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Container(
                            color: Theme.of(context).cardColor,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: Column(
                                children: [
                                   HeaderOptionWidget(
                                    svg: ImgAssets.info,
                                    text: 'عن التطبيق',
                                    svgWidth: 29,
                                  ),
                                  OptionWidget(
                                    onTap: () {
                                      goTo(context, (context) => const PrivacyPolicyPage());
                                    },
                                    title: "سياسة الاستخدام",
                                  ),
                                  OptionWidget(
                                    onTap: () {
                                      goTo(context, (context) => const TermsAndConditionsPage());
                                    },
                                    title: "الشروط والأحكام",
                                  ),
                                  OptionWidget(
                                    onTap: () {
                                      goTo(context,
                                          (context) => const HelpPage());
                                    },
                                    title: "مركز المساعدة",
                                  ),
                                  OptionWidget(
                                    onTap: () {
                                      Share.share(
                                          "watch--------- \n https://google.com  \n\n downloadTheAppFromGooglePlay \n https://play.google.com \n\n downloadTheAppFromAppStore\n https://apps.apple.com");
                                    },
                                    title: "شارك التطبيق مع أصدقائك",
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        if (isLoggedIn())
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 17, right: 17, top: 26),
                            child: CustomButton(
                              title: "تسجيل خروج",
                              onTap: () {
                                showCustomDialog(context);
                              },
                            ),
                          ),
                        ///Version section
                        const AppVersion(),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 60, right: 60, top: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ///INSTAGRAM
                              GestureDetector(
                                onTap: () async {
                                  const url = 'https://www.instagram.com/emasteryacademy/#wp';
                                  if (await canLaunch(url)) {
                                  await launch(url);
                                  } else {
                                  throw 'Could not launch $url';
                                  }
                                },
                                child: SvgPicture.asset(
                                  ImgAssets.iconInstagram,
                                  color: iconsColor,
                                ),
                              ),

                              ///YOUTUBE
                              GestureDetector(
                                onTap: () async {
                                  const url = 'https://www.youtube.com/c/eMasteryAcademy/#wp';
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                },
                                child: SvgPicture.asset(
                                  ImgAssets.iconYoutube,
                                  color: iconsColor,
                                ),
                              ),

                              ///TWITTER
                              GestureDetector(
                                onTap: () async {
                                  const url = 'https://twitter.com/emasteryacademy/#wp';
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                },
                                child: SvgPicture.asset(
                                  ImgAssets.iconTwitter,
                                  color: iconsColor,
                                ),
                              ),

                              ///LINKEDIN
                              GestureDetector(
                                onTap: () async {
                                  const url = 'https://www.linkedin.com/company/emasteryacademy/#wp';
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                },
                                child: SvgPicture.asset(
                                  ImgAssets.iconLinkedin,
                                  color: iconsColor,
                                ),
                              ),

                              ///FACEBOOK
                              GestureDetector(
                                onTap: () async {
                                  const url = 'https://www.facebook.com/emasteryacademy/#wp';
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                },
                                child: SvgPicture.asset(
                                  ImgAssets.iconFacebook,
                                  color: iconsColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 120,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }));
  }
}




void showCustomDialog(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: iconsColor.withOpacity(0.3),
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (contextt, __, ___) {
      var locale = AppLocalizations.of(context)!;
      return Center(
        child: Container(
          height: 130,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: Padding(
                padding: const EdgeInsets.only(right: 27, left: 35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 17, bottom: 9.7),
                      child: Text(
                        locale.checkoutConfirmation!,
                        style: blackBoldTextStyle(context: context, fontSize: 14),
                      ),
                    ),
                    Text(
                      locale.areYouSureYouAreLoggedOut!,
                      style: blackBoldTextStyle(context: context, fontSize: 12),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 31),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(contextt);
                              },
                              child: Text(
                                locale.cancel!,
                                style: blackBoldTextStyle(context: context, fontSize: 12, color: Theme.of(context).primaryColor),)),
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context, 200);
                              },
                              child: Text(
                                locale.logOut!,
                                style: blackBoldTextStyle(context: context, fontSize: 12, color: Theme.of(context).primaryColor),
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      Tween<Offset> tween;
      if (anim.status == AnimationStatus.reverse) {
        tween = Tween(begin: const Offset(-1, 0), end: Offset.zero);
      } else {
        tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
      }

      return SlideTransition(
        position: tween.animate(anim),
        child: FadeTransition(
          opacity: anim,
          child: child,
        ),
      );
    },
  ).then((value) {
    if (value == 200) {
      globalSH.clear();
      globalSH.setBool(iS_Show_Case, true);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (route) => false);
    }
  });
}
