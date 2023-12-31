import 'package:acadmiat/core/widgets/app_bar_widget.dart';
import 'package:acadmiat/features/authentication_feature/presentation/pages/signup_page.dart';
import 'package:flutter/foundation.dart';
import 'package:acadmiat/core/widgets/custom_botton.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../../../Locale/locale.dart';
import '../../../../Theme/style.dart';
import '../../../../core/functions.dart';
import '../../../../core/globals.dart';
import '../../../../core/widgets/custom_text_field.dart';
import 'email_verification_code_page.dart';
import 'forget_password_page.dart';
import '../../../../injection_container.dart';
import '../../../../nav_page.dart';
import '../bloc/authenticate_bloc.dart';
import '../bloc/authenticate_event.dart';
import '../bloc/authenticate_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key,this.from}) : super(key: key);
  final int ? from;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _visible = false;
  bool theFirst = true;
  bool loading = true;
  bool msgShow = true;
  bool firstTime = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController  = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    page = 0;
    lastPage = 0;
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    var locale = AppLocalizations.of(context)!;

    if (theFirst) {
      Future.delayed(const Duration(milliseconds: 600), () {
        setState(() {
          _visible = true;
          theFirst = false;
        });
      });
    }

    return BlocProvider(
        create: (BuildContext context) => sl<AuthenticateBloc>(),
        child: BlocBuilder<AuthenticateBloc, AuthenticateState>(
            builder: (context, state) {
              if (kDebugMode) {
                print("state:$state");
              }
              if(state is Error ){

              }
              if (state is Loading) {
                loading = true;
              } else {
                loading = false;
              }
              if(state is SuccessAuthenticate && firstTime){
                firstTime = false;
                Future.delayed(Duration.zero, () {
                  goTo(context, (context) => EmailVerificationCodePage(authenticateEntity: state.authenticateEntity,));
                });
              }

              if (state is SuccessLogin) {
                if(widget.from==null) {
                  Future.delayed(Duration.zero, () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => const NavPage()),
                            (Route<dynamic> route) => false);
                  });//

                }
                ///The user came from CartPage and we need to bring it back to CartPage.
                else{
                  Future.delayed(Duration.zero, () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) =>  NavPage(from:widget.from)),
                            (Route<dynamic> route) => false);
                  });//

                }
              }
              if (state is Error) {
                if (msgShow) {
                  showMessage(message: "الايميل او كلمة السر خطآ",
                      context: context,
                  );
                  msgShow = false;
                }
              }
              return Scaffold(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          child:GestureDetector(
                            onTap: () {
                              FocusScopeNode currentFocus = FocusScope.of(context);
                              if (!currentFocus.hasPrimaryFocus &&
                                  currentFocus.focusedChild != null) {
                                currentFocus.focusedChild!.unfocus();
                              }
                            },
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


                                AnimatedOpacity(
                                  opacity: _visible ? 1 : 0,
                                  duration: const Duration(seconds: 1),
                                  child: Column(
                                    children: [
                                      /// EMAIL FIELD
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: size.height * 0.05,
                                            bottom: size.height * 0.022321428571428572),
                                        child: CustomTextField(
                                          title: locale.email!,
                                          onChange: (value){
                                            return validateEmail(value);
                                          },
                                          hint: locale.enterTheEmail!,
                                          maxLines: 1,
                                          controller:emailController ,
                                          onTap: () {},
                                        ),
                                      ),

                                      ///PASSWORD FIELD
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: size.height * 0.034642857142857144),
                                        child: CustomTextField(
                                          title: locale.password!,
                                          hint: locale.enterThePassword!,
                                          controller: passwordController,
                                          onChange: (value){
                                            if (value == null || value=="") {
                                              return 'كلمة السر مطلوبة';
                                            }
                                          },

                                          isPassword: true,
                                          maxLines: 1,
                                          onTap: () {},
                                        ),
                                      ),

                                      ///FORGET PASSWORD AND CREATE NEW ACCOUNT
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          /// FORGET PASSWORD
                                          GestureDetector(
                                              onTap: () {
                                                goTo(context, (context) =>
                                                const ForgetPasswordPage());
                                              },
                                              child: Text(
                                                locale.iForgotThePassword!,
                                                style: blackBoldTextStyle(
                                                    context: context,
                                                    fontSize: 12,
                                                    color:
                                                    Theme.of(context).primaryColor),
                                              )),
                                          /// CREATE NEW ACCOUNT
                                          GestureDetector(
                                              onTap: () async {
                                                goTo(context,
                                                        (context) => const SignupPage());
                                              },
                                              child: Text(
                                                locale.createANewAccount!,
                                                style: blackBoldTextStyle(
                                                    context: context,
                                                    fontSize: 12,
                                                    color:
                                                    Theme.of(context).primaryColor),
                                              )),
                                        ],
                                      ),

                                      /// LOGIN BUTTON
                                      Padding(
                                        padding:
                                        EdgeInsets.only(top: size.height * 0.1),
                                        child: CustomButton(
                                            title: locale.signIn!,
                                            borderRadius: 8,
                                            loading: loading,
                                            onTap: () {
                                              FormState form =  _formKey.currentState!;
                                              if (form.validate()) {
                                                msgShow = true;
                                                firstTime = true;
                                                BlocProvider.of<AuthenticateBloc>(
                                                    context)
                                                    .add(GetLoginUser(
                                                    loginName: emailController.text,
                                                    password: passwordController
                                                        .text));


                                              } else {
                                                print('Form is invalid');
                                              }

                                              setState(() {

                                              });
                                            }),
                                      ),

                                      ///LOGIN LATER
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(top: 30),
                                        child: GestureDetector(
                                          onTap: (){
                                            Future.delayed(Duration.zero, () {

                                              Navigator.of(context)
                                                  .pushAndRemoveUntil(
                                                  MaterialPageRoute(builder: (
                                                      context) => const NavPage()),
                                                      (
                                                      Route<dynamic> route) => false);

                                            });
                                          },child: Container(
                                          width: size.width*0.6,
                                          alignment: Alignment.center,
                                          color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.1),
                                          child: Padding(
                                            padding: const EdgeInsets.only(top:15,bottom: 15),
                                            child: Text("تسجيل الدخول لاحقا",style: blackBoldTextStyle(fontSize: 13, context: context,color: Theme.of(context).primaryColor),),
                                          ),
                                        ),
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),)


                    ),
                  ),
                ),
              );
            }));
  }
}
