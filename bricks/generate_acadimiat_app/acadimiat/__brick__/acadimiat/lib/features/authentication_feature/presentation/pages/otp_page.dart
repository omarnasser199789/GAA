import 'dart:async';

import 'package:acadmiat/Theme/style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../Locale/locale.dart';
import '../../../../core/functions.dart';
import '../../../../core/widgets/custom_botton.dart';
import '../../../../injection_container.dart';
import '../../domain/use_cases/register_usecase.dart';
import '../bloc/authenticate_bloc.dart';
import '../bloc/authenticate_event.dart';
import '../bloc/authenticate_state.dart';
import '../../../../nav_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({Key? key,required this.phoneNumber, this.registerParams,required this.verificationId, this.updateUserInfo}) : super(key: key);
  final String phoneNumber;
  final String verificationId;
  final UpdateUserInfo ? updateUserInfo;
  final RegisterParams ? registerParams;
  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final StreamController<ErrorAnimationType> errorController =
  StreamController<ErrorAnimationType>();
  final TextEditingController textEditingController = TextEditingController();
  String currentText = "";
  bool loading=false;

  Duration oneDecimal = const Duration(milliseconds: 100);
  int start = 0;
  late Timer timer;
  @override
  void initState() {
    Duration timerTastoPremuto = Duration(seconds:60);
    start = timerTastoPremuto.inMilliseconds;

    timer= Timer.periodic(
        oneDecimal,
            (Timer timer) => setState(() {
          if (start < 100) {
            timer.cancel();
          } else {
            start = start - 100;
          }
        }));
  }
  bool allowBack=true;
  bool allowGo=true;
  bool firstOne=true;
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    Size size = MediaQuery.of(context).size;


    Duration duration = Duration(milliseconds: start);

    if (duration.inSeconds == 0 && allowBack==true) {
      allowBack=false;

      Future.delayed(const Duration(milliseconds: 1000), () {
        Navigator.of(context).pop();
      });
    }


    return BlocProvider(
        create: (BuildContext context) => sl<AuthenticateBloc>(),
        child: BlocBuilder<AuthenticateBloc, AuthenticateState>(
            builder: (context, state) {
              if(state is Loading){
                loading=true;
              }
              if(state is Error){
                loading=false;
              }
              if(state is SuccessLogin){
                loading=false;

                if  (state.statusCode==200){
                  if(allowGo) {
                    allowGo=false;
                    timer.cancel();
                    Future.delayed(const Duration(milliseconds: 100), () {
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                              transitionDuration: const Duration(seconds: 2),
                              pageBuilder: (_, __, ___) =>
                              const NavPage()
                          ));
                    });
                  }

                }else if(state.statusCode == 600){
                  allowGo=false;
                  timer.cancel();
                  Future.delayed(const Duration(milliseconds: 1000), () {
                    Navigator.of(context).pop();
                  });
                  showMessage(message: "هذا الايميل موجود مسبقاً الرجاء ادخال ايميل آخر",
                      context: context,
                      bgColor: Colors.red);
                }


                else{
                  allowGo=false;
                  timer.cancel();
                  Future.delayed(const Duration(milliseconds: 1000), () {
                    Navigator.of(context).pop();
                  });
                  showMessage(message: "حذث خطآ ما الرجاء المحاولة مرة آخرى",
                      context: context,
                      bgColor: Colors.red);

                }



              }

              if(state is SuccessRegisterUserInFirebase){

                if(state.statusCode==200) {
                  ///Coming from edit user info page
                  if (widget.updateUserInfo != null) {
                    BlocProvider.of<AuthenticateBloc>(context)
                        .add(widget.updateUserInfo!);
                  }

                  if(widget.registerParams!=null){
                    BlocProvider.of<AuthenticateBloc>(context)
                        .add(RegisterUserEvent(registerParams:widget.registerParams!));/// => SuccessLogin
                  }



                }else{
                  if(firstOne) {
                    firstOne=false;
                    loading = false;

                    showMessage(message: "الرجاء التآكد من رمز OTP",
                        context: context,
                        bgColor: Colors.red);
                  }
                }
              }
              if(state is SuccessUpdateUserInfoEntity){
                loading=false;
                if(allowGo) {
                  allowGo=false;
                  timer.cancel();
                  Future.delayed(const Duration(milliseconds: 100), () {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                            transitionDuration: const Duration(seconds: 2),
                            pageBuilder: (_, __, ___) =>
                            const NavPage()
                        ));
                  });
                }
              }


              return Scaffold(
                body: Padding(
                  padding: const EdgeInsets.only(left: 17,right: 17,top: 52),
                  child: Column(

                    children: [

                      Row(
                        children: [
                          Text("كود التفعيل",style: blackBoldTextStyle(fontSize: 18, context: context),),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Row(
                          children: [
                            Text("برجاء إدخال كود التفعيل المرسل إليك على هذا الرقم",style: blackBoldTextStyle(fontSize: 13, context: context),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Row(
                          children: [

                            Directionality(
                                textDirection: TextDirection.ltr,
                                child: Text("  "+"${widget.phoneNumber}" ,style: blackBoldTextStyle(fontSize: 13, context: context),)),
                            Text("والمكون من 4 ارقام" ,style: blackBoldTextStyle(fontSize: 13, context: context),),


                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20,top: 100),
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: PinCodeTextField(
                            length: 6,
                            // pinTheme:  PinTheme(shape:PinCodeFieldShape.circle
                            //
                            //     shape: PinCodeFieldShape.underline,
                            //     fieldHeight: 40,
                            //     fieldWidth: 40,
                            // ),
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(6),
                              //
                              borderWidth: 2,

                              fieldHeight: 40,
                              fieldWidth: 40,
                              activeFillColor: Colors.transparent,
                              inactiveColor: iconsColor ,
                              activeColor:Theme.of(context).primaryColor,
                              selectedColor: Theme.of(context).primaryColor,
                              selectedFillColor: Colors.transparent,


                              errorBorderColor: Colors.white,
                              inactiveFillColor: Colors.transparent,

                            ),
                            textStyle: blackBoldTextStyle(fontSize: 20, context: context,color: Theme.of(context).primaryColor),
                            obscureText: false,
                            animationType: AnimationType.fade,
                            // textAlign: TextAlign.left,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],


                            keyboardType: TextInputType.phone,


                            animationDuration: Duration(milliseconds: 300),
                            // backgroundColor: Colors.white,
                            enableActiveFill: true,
                            // errorAnimationController: errorController,
                            controller: textEditingController,
                            onCompleted: (v) {

                            },
                            onChanged: (value) {

                              setState(() {
                                currentText = value;
                              });
                            },
                            beforeTextPaste: (text) {
                              if (kDebugMode) {
                                print("Allowing to paste $text");
                              }
                              return true;
                            },
                            appContext: context,
                          ),
                        ),
                      ),


                      Padding(
                        padding: const EdgeInsets.only(top: 51),
                        child: Hero(
                          tag: "otpBtn",
                          child: CustomButton(
                              title: locale.newSubscription!,
                              loading: loading,
                              borderRadius: 8,
                              onTap: () {
                                if(currentText.length>5) {
                                  firstOne=true;
                                  PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: widget.verificationId, smsCode: currentText);
                                  BlocProvider.of<AuthenticateBloc>(context).add(
                                      RegisterUserInFirebaseEvent(phoneAuthCredential: phoneAuthCredential));/// => SuccessRegisterUserInFirebase
                                }else{
                                  showMessage(message: "الرجاء ادخال رمز الOTP",
                                      context: context,
                                      bgColor: Colors.red);
                                  setState(() {

                                  });
                                }

                              }),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child:RichText(
                          text: TextSpan(
                            text: "إعادة الإرسال في خلال   ",
                            style: blackBoldTextStyle(
                                context: context, fontSize: 14),
                            children: <TextSpan>[
                              TextSpan(
                                text: "${formatDuration(duration)} ثانية",
                                style: blackBoldTextStyle(
                                    context: context,
                                    fontSize: 14,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }));


  }
}
