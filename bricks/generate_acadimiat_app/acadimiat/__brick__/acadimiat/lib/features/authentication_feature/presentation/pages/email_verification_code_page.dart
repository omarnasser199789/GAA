import 'dart:async';
import 'package:acadmiat/Theme/style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../core/functions.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../../../core/widgets/custom_botton.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/authenticate_entity.dart';
import '../../domain/use_cases/facheck_usecase.dart';
import '../bloc/authenticate_bloc.dart';
import '../bloc/authenticate_event.dart';
import '../bloc/authenticate_state.dart';
import '../../../../nav_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailVerificationCodePage extends StatefulWidget {
  const EmailVerificationCodePage({Key? key,required this.authenticateEntity}) : super(key: key);
  final AuthenticateEntity authenticateEntity;
  @override
  State<EmailVerificationCodePage> createState() => _EmailVerificationCodePageState();
}

class _EmailVerificationCodePageState extends State<EmailVerificationCodePage> with SingleTickerProviderStateMixin {

  final StreamController<ErrorAnimationType> errorController =
  StreamController<ErrorAnimationType>();
  final TextEditingController textEditingController = TextEditingController();
  String currentText = "";
  bool loading=false;

  Duration oneDecimal = const Duration(milliseconds: 100);
  int start = 0;
  late Timer timer;
  bool allowBack=true;
  bool allowGo=true;
  bool allowShowMsg=false;
  bool firstOne=true;

  @override
  void initState() {
    super.initState();
    Duration timerTastoPremuto = const Duration(seconds:60);
    start = timerTastoPremuto.inMilliseconds;
    timer= Timer.periodic(oneDecimal,
            (Timer timer) => setState(() {
          if (start < 100) {
            timer.cancel();
          } else {
            start = start - 100;
          }
        }));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
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
              if (kDebugMode) {
                print(state);
              }
              if(state is Loading){
                loading=true;
              }
              if(state is Error){
                loading=false;
                if(mounted && allowShowMsg){
                  allowShowMsg =false;
                  showMessage(message: "الرجاء التآكد من رمز OTP", context: context);
                }
              }
              if(state is SuccessFacheck){
                loading=false;
                  if(allowGo) {
                    allowGo=false;
                    timer.cancel();
                    Future.delayed(const Duration(milliseconds: 100), () {
                      Navigator.push(context, PageRouteBuilder(transitionDuration: const Duration(seconds: 2),pageBuilder: (_, __, ___) => const NavPage()));
                    });
                  }
              }

              return Scaffold(
                appBar: appBarWidget("", context, true, null, null),
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
                            Text("برجاء إدخال كود التفعيل المرسل إليك على هذا البريد",style: blackBoldTextStyle(fontSize: 13, context: context),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Row(
                          children: [

                            Directionality(
                                textDirection: TextDirection.ltr,
                                child: Text("  "+widget.authenticateEntity.email ,style: blackBoldTextStyle(fontSize: 13, context: context),)),
                            Text("والمكون من 6 ارقام" ,style: blackBoldTextStyle(fontSize: 13, context: context),),


                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20,top: 100),
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: PinCodeTextField(
                            length: 6,
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(6),
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
                            animationDuration: const Duration(milliseconds: 300),
                            enableActiveFill: true,
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
                      ///Button
                      Padding(
                        padding: const EdgeInsets.only(top: 51),
                        child: Hero(
                          tag: "otpBtn",
                          child: CustomButton(
                              title: "تآكيد",
                              loading: loading,
                              borderRadius: 8,
                              onTap: () {
                                if(currentText.length>5) {
                                  firstOne=true;
                                  allowShowMsg=true;
                                  BlocProvider.of<AuthenticateBloc>(context).add(Facheck(facheckParams:
                                  FacheckParams(email: widget.authenticateEntity.email, userId: widget.authenticateEntity.userId,
                                      code: textEditingController.text)));/// => SuccessRegisterUserInFirebase
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
            })
    );

  }
}
