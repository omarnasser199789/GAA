import 'package:acadmiat/core/widgets/app_bar_widget.dart';
import 'package:acadmiat/core/widgets/custom_botton.dart';
import 'package:acadmiat/features/authentication_feature/presentation/pages/login_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../Locale/locale.dart';
import '../../../../Theme/style.dart';
import '../../../../core/functions.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../injection_container.dart';
import '../../../../nav_page.dart';
import '../../domain/use_cases/register_usecase.dart';
import '../bloc/authenticate_bloc.dart';
import '../bloc/authenticate_event.dart';
import '../bloc/authenticate_state.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool checkBoxValue = false;
  bool isLoading = false;
  bool shouldCheck = false;
  bool loading = false;
  bool editPickerPhone = false;
  String countryCodePicker = "+973";
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool allowGo = true;
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    Size size = MediaQuery.of(context).size;

    return BlocProvider(
        create: (BuildContext context) => sl<AuthenticateBloc>(),
        child: BlocBuilder<AuthenticateBloc, AuthenticateState>(
            builder: (context, state) {
          if (kDebugMode) {
            print("state:$state");
          }

          if (state is SuccessLogin) {
            loading = false;

            if (state.statusCode == 200) {
              if (allowGo) {
                allowGo = false;

                Future.delayed(const Duration(milliseconds: 1000), () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          transitionDuration: const Duration(seconds: 2),
                          pageBuilder: (_, __, ___) => const NavPage()));
                });
              }
            } else if (state.statusCode == 600) {
              allowGo = false;
              Future.delayed(const Duration(milliseconds: 1000), () {
                Navigator.of(context).pop();
              });
              showMessage(
                  message: "هذا الايميل موجود مسبقاً الرجاء ادخال ايميل آخر",
                  context: context,
                  bgColor: Colors.red);
            } else {
              allowGo = false;
              Future.delayed(const Duration(milliseconds: 1000), () {
                Navigator.of(context).pop();
              });
              showMessage(
                  message: "حذث خطآ ما الرجاء المحاولة مرة آخرى",
                  context: context,
                  bgColor: Colors.red);
            }
          }

          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            // appBar: appBarWidget(locale.newSubscription!, context, true, [],null),
            body: GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus &&
                    currentFocus.focusedChild != null) {
                  currentFocus.focusedChild!.unfocus();
                }
              },
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: SingleChildScrollView(
                    child: GestureDetector(
                      onTap: () {
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus &&
                            currentFocus.focusedChild != null) {
                          currentFocus.focusedChild!.unfocus();
                        }
                      },
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            ///LOGO WIDGET
                            Padding(
                              padding: EdgeInsets.only(top: size.height * 0.05),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:  [
                                  Hero(
                                    tag: "logo",
                                    // child:SvgCodeWidget(code: logo,)
                                    child: SizedBox(
                                        width: 130,
                                        child: Image(image: AssetImage("assets/logo.png"),)),
                                  ),
                                ],
                              ),
                            ),

                            ///NAME FIELD
                            Padding(
                              padding: const EdgeInsets.only(top: 40, bottom: 15),
                              child: CustomTextField(
                                controller: nameController,
                                title: locale.fullName!,
                                hint: locale.example!,
                                onTap: () {},
                                onChange: (value) {
                                  if (value == null || value == "") {
                                    return 'الرجاء ادخال الاسم الكامل';
                                  }
                                  return null;
                                },
                              ),
                            ),

                            ///E-MAIL FIELD
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: CustomTextField(
                                controller: emailController,
                                title: locale.email!,
                                hint: '----@----',
                                onTap: () {},
                                onChange: (value) {
                                  return validateEmail(value);
                                },
                              ),
                            ),

                            ///PHONE NUMBER FIELD
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ///PHONE FIELD
                                  SizedBox(
                                    width: size.width - 160,
                                    child: CustomTextField(
                                      title: locale.mobileNumberOptional!,
                                      keyboardType: TextInputType.phone,
                                      textAlign: TextAlign.left,
                                      controller: _phoneNumberController,
                                      hint: '000 000 0000', onTap: () {},
                                    ),
                                  ),

                                  ///PICKER PHONE
                                  Padding(
                                    padding: EdgeInsets.only(top: 33),
                                    child: Container(
                                      height:
                                          50, //deviceData.screenHeight * 0.065,
                                      decoration: BoxDecoration(
                                        color: textFormFieldFillColor,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Directionality(
                                        textDirection: isEnglish(context)
                                            ? TextDirection.rtl
                                            : TextDirection.ltr,
                                        child: Theme(
                                          data: Theme.of(context).copyWith(
                                            unselectedWidgetColor: Colors.red,
                                            cardColor: Colors.red,
                                            canvasColor: Colors.red,
                                            textTheme: isLight()
                                                ? Typography(
                                                        platform:
                                                            TargetPlatform.iOS)
                                                    .black
                                                : Typography(
                                                        platform:
                                                            TargetPlatform.iOS)
                                                    .white,
                                            cardTheme: const CardTheme(
                                                color: Colors.red),
                                          ),
                                          child: CountryCodePicker(
                                            onChanged: (value) {
                                              setState(() {
                                                countryCodePicker =
                                                    value.toString();
                                              });
                                            },
                                            textStyle: blackBoldTextStyle(
                                                fontSize: 12, context: context),
                                            searchStyle: blackBoldTextStyle(
                                                fontSize: 12, context: context),
                                            boxDecoration: BoxDecoration(
                                              color:
                                                  Theme.of(context).cardColor,
                                            ),
                                            closeIcon: Icon(
                                              Icons.close,
                                              color: iconsColor,
                                            ),
                                            searchDecoration: InputDecoration(
                                              border: InputBorder.none,
                                              // hintText: widget.hint,

                                              hintStyle: blackBoldTextStyle(
                                                  context: context,
                                                  fontSize: 12,
                                                  color: hintTextColor),
                                              filled: true,
                                              fillColor: textFormFieldFillColor,

                                              // suffixIcon: (widget.isPassword!=null&&widget.isPassword==true)? GestureDetector(
                                              //     onTap: (){
                                              //
                                              //       setState((){
                                              //         widget.isPassword=false;
                                              //       });
                                              //
                                              //     },
                                              //     child: const Icon(Icons.remove_red_eye_outlined,color: Colors.grey,)):null,

                                              prefixIcon: Icon(
                                                Icons.search,
                                                color: hintTextColor,
                                              ),

                                              contentPadding:
                                                  const EdgeInsets.all(8),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Theme.of(context)
                                                        .cardColor),
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                            ),
                                            initialSelection: 'BH',
                                            favorite: const [
                                              "+963",
                                              "+971",
                                              "+20",
                                              "+974",
                                              '+973',
                                              '+964',
                                            ], // 'IQ','BH',
                                            // optional. Shows only country name and flag
                                            showCountryOnly: false,
                                            // optional. Shows only country name and flag when popup is closed.
                                            showOnlyCountryWhenClosed: false,
                                            // optional. aligns the flag and the Text left
                                            alignLeft: false,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            ///PASSWORD FIELD
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: CustomTextField(
                                controller: passwordController,
                                title: locale.password!,
                                hint: locale.enterThePassword!,
                                onTap: () {},
                                isPassword: true,
                                maxLines: 1,
                                onChange: (value) {
                                  if (value == null || value == "") {
                                    return 'كلمة السر مطلوبة';
                                  }
                                  return null;
                                },
                              ),
                            ),

                            ///CONFIRM PASSWORD FIELD
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: CustomTextField(
                                controller: rePasswordController,
                                title: "تآكيد كلمة السر",
                                hint: "اعد كتابة كلمة السر",
                                isPassword: true,
                                maxLines: 1,
                                onTap: () {},
                                onChange: (value) {
                                  if (value == null || value == "") {
                                    return 'كلمة السر مطلوبة';
                                  }
                                  if (passwordController.text != value) {
                                    return "كلمة السر غير متطابقة";
                                  }
                                  return null;
                                },
                              ),
                            ),

                            /// ACCEPT PRIVATE POLICE
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 0, bottom: 45),
                              child: Row(
                                children: [
                                  Theme(
                                    data: Theme.of(context).copyWith(
                                      unselectedWidgetColor:
                                          Theme.of(context).primaryColor,
                                    ),
                                    child: Checkbox(
                                      value: checkBoxValue,
                                      activeColor:
                                          Theme.of(context).primaryColor,
                                      checkColor: Colors.white,
                                      onChanged: (value) {
                                        setState(() {
                                          checkBoxValue = value!;
                                        });
                                      },
                                    ),
                                  ),
                                  Text(
                                    "وافق على سياسة الخصوصية وشروط الاستخدام",
                                    style: blackBoldTextStyle(
                                        context: context,
                                        fontSize: 12,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: CustomButton(
                                  title: "حساب جديد",
                                  loading: loading,
                                  borderRadius: 8,
                                  onTap: () async {
                                    /// to make phone field optional
                                    /// if user enter the phone number go to OTP page
                                    /// else is user dose not enter phone number we will register user
                                    if (_phoneNumberController.text != '') {
                                      FormState form = _formKey.currentState!;
                                      if (form.validate()) {
                                        if (checkBoxValue == true) {
                                          FocusScopeNode currentFocus =
                                              FocusScope.of(context);
                                          if (!currentFocus.hasPrimaryFocus &&
                                              currentFocus.focusedChild !=
                                                  null) {
                                            currentFocus.focusedChild!
                                                .unfocus();
                                          }

                                          setState(() {
                                            loading = true;
                                          });

                                        } else {
                                          showMessage(
                                              message:
                                                  "الرجاء الموافقة علي سياسة الخصوصية وشروط الاستخدام",
                                              context: context);
                                        }
                                      }
                                    } else {
                                      if (checkBoxValue == true) {
                                        setState(() {
                                          loading = true;
                                        });

                                        BlocProvider.of<AuthenticateBloc>(
                                                context)
                                            .add(RegisterUserEvent(
                                          registerParams: RegisterParams(
                                            email: emailController.text,
                                            phone: "",
                                            password: passwordController.text,
                                            fullName: nameController.text,
                                            rePassword:
                                                rePasswordController.text,
                                            acceptTerms: checkBoxValue,
                                          ),
                                        ));

                                        /// => SuccessLogin

                                      } else {
                                        showMessage(
                                            message:
                                                "الرجاء الموافقة علي سياسة الخصوصية وشروط الاستخدام",
                                            context: context);
                                      }
                                    }
                                  }),
                            ),

                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 50, bottom: 71),
                              child: GestureDetector(
                                onTap: () {
                                  goTo(context, (context) => const LoginPage());
                                },
                                child: RichText(
                                  text: TextSpan(
                                    text: "${locale.iDoNotHaveAnAccount}  ",
                                    style: blackBoldTextStyle(
                                        context: context, fontSize: 14),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: locale.signIn!,
                                        style: blackBoldTextStyle(
                                            context: context,
                                            fontSize: 14,
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }));
  }
}
