import 'package:acadmiat/Theme/style.dart';
import 'package:acadmiat/core/functions.dart';
import 'package:acadmiat/injection_container.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../Locale/locale.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../../../core/widgets/custom_botton.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../bloc/authenticate_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/authenticate_event.dart';
import '../bloc/authenticate_state.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  bool messageOrEmail = false;
  TextEditingController emailController = TextEditingController();
  bool loading = false;
  bool goToGmail = false;
  bool firstTime = true;
  FocusNode inputNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    if (firstTime) {
      firstTime = false;
      FocusScope.of(context).requestFocus(inputNode);
    }
    var locale = AppLocalizations.of(context)!;
    Size size = MediaQuery.of(context).size;

    return BlocProvider(
        create: (BuildContext context) => sl<AuthenticateBloc>(),
        child: BlocBuilder<AuthenticateBloc, AuthenticateState>(
            builder: (context, state) {
          if (kDebugMode) {
            print("state:$state");
          }
          if (state is Loading) {
            loading = true;
          } else {
            loading = false;
          }
          if (state is SuccessResetPassword) {
            if (state.statusCode == 404) {
              showMessage(
                  message: "الرجاء التآكد من الايميل المدخل", context: context);
            }
            if (state.statusCode == 200) {
              goToGmail = true;
            }
          }

          return Scaffold(
            appBar: appBarWidget("", context, true, null, null),
            body: Padding(
              padding: const EdgeInsets.only(left: 17, right: 17, top: 41),
              child: Form(
                key: _formKey,
                child: Stack(
                  children: [
                    AnimatedOpacity(
                      duration: const Duration(seconds: 1),
                      opacity: goToGmail ? 1 : 0,
                      child: Column(
                        children: [

                          SvgPicture.asset(
                            "assets/svgs/emailsvg.svg",
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:17),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: size.width - 35,
                                  child: Text(
                                    "افحص البريد الالكتروني",
                                    style: blackBoldTextStyle(
                                        fontSize: 16,
                                        context: context,
                                        height: 1.7),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:17),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: size.width - 35,
                                  child: Text(
                                    "لقد قمنا بإرسال التعليمات الخاصة باستعادة كلمة السر الخاصة بك عبر البريد الالكتروني",
                                    style: blackBoldTextStyle(
                                        fontSize: 13,
                                        context: context,
                                        height: 1.7),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 80),
                            child: CustomButton(
                                title: "اذهب الى البريد الالكتروني",
                                borderRadius: 8,
                                onTap: () async {
                                  var url = 'mailto:example@gmail.com';
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                }),
                          ),
                        ],
                      ),
                    ),
                    AnimatedOpacity(
                      duration: const Duration(seconds: 1),
                      opacity: goToGmail ? 0 : 1,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "استعادة كلمة السر",
                                style: blackBoldTextStyle(
                                    fontSize: 18, context: context),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Row(
                              children: [
                                Container(
                                    width: size.width - 34,
                                    child: Text(
                                      "أدخل بريدك الالكتروني الذي قمت باستخدامه أثناء إنشاء الحساب لاستعادة الكلمة",
                                      style: blackBoldTextStyle(
                                          fontSize: 13,
                                          context: context,
                                          height: 1.7),
                                    )),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 30,
                                bottom: size.height * 0.022321428571428572),
                            child: CustomTextField(
                              title: locale.email!,
                              hint: locale.enterTheEmail!,
                              focusNode: inputNode,
                              onChange: (value) {
                                return validateEmail(value);
                              },
                              maxLines: 1,
                              controller: emailController,
                              onTap: () {},
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: CustomButton(
                                title: "إرسال",
                                borderRadius: 8,
                                loading: loading,
                                onTap: () {
                                  FormState form = _formKey.currentState!;
                                  if (form.validate()) {
                                    FocusScopeNode currentFocus =
                                        FocusScope.of(context);
                                    if (!currentFocus.hasPrimaryFocus &&
                                        currentFocus.focusedChild != null) {
                                      currentFocus.focusedChild!.unfocus();
                                    }
                                    BlocProvider.of<AuthenticateBloc>(context)
                                        .add(ResetPassword(
                                      email: emailController.text,
                                    ));
                                  }
                                }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }));
  }
}

class BoxInfo extends StatefulWidget {
  final String svg;
  final String text1;
  final String text2;
  final bool enable;
  final Function() onTap;
  const BoxInfo(
      {Key? key,
      required this.text1,
      required this.enable,
      required this.text2,
      required this.onTap,
      required this.svg})
      : super(key: key);

  @override
  State<BoxInfo> createState() => _BoxInfoState();
}

class _BoxInfoState extends State<BoxInfo> {
  @override
  Widget build(BuildContext context) {
    Decoration decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: Theme.of(context).cardColor,
    );
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        // height: 82,
        width: double.infinity,
        decoration: decoration,

        child: Padding(
          padding:
              const EdgeInsets.only(left: 17, right: 17, top: 25, bottom: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    widget.svg,
                    color: iconsColor,
                  ),
                  const SizedBox(
                    width: 13,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.text1,
                        style:
                            blackBoldTextStyle(fontSize: 12, context: context),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          widget.text2,
                          style: blackBoldTextStyle(
                              fontSize: 12, context: context),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              if (widget.enable)
                SvgPicture.asset(
                  "assets/svgs/check2.svg",
                ),
            ],
          ),
        ),
      ),
    );
  }
}
