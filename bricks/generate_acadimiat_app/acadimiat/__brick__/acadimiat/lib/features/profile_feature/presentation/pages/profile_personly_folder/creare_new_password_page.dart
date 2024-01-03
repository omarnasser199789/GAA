import 'package:acadmiat/core/globals.dart';
import 'package:acadmiat/core/widgets/app_bar_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:acadmiat/core/widgets/custom_botton.dart';
import 'package:flutter/material.dart';
import '../../../../../Locale/locale.dart';
import '../../../../../Theme/style.dart';
import '../../../../../core/functions.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../injection_container.dart';
import '../../bloc/profile_bloc.dart';
import '../../bloc/profile_event.dart';
import '../../bloc/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateNewPasswordPage extends StatefulWidget {
  const CreateNewPasswordPage({super.key});

  @override
  State<CreateNewPasswordPage> createState() => _CreateNewPasswordPageState();
}

class _CreateNewPasswordPageState extends State<CreateNewPasswordPage> {
  bool loading=false;
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool ? capitalLetters;
  bool ? lowerLetters;
  bool? numbers;
  bool? symbols;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var locale = AppLocalizations.of(context)!;


    return BlocProvider(
        create: (BuildContext context) => sl<ProfileBloc>(),
        child:
        BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
          if (kDebugMode) {
            print("state:$state");
          }

          if (state is Loading) {
            loading = true;
          } else {
            loading = false;
          }
          if(state is SuccessChangePassword){
            showMessage(message: "تم تغير كلمة المرور بنجاح", context: context,bgColor: percentIndicatorColor);
          }

          return Scaffold(
            appBar:appBarWidget("تغير كلمة السر",context,true,null,null),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: GestureDetector(
              onTap: (){
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Padding(
                padding: defaultPadding,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    SizedBox(
                      height: size.height-200,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [

                            Row(
                              children: [
                                Text("من فضلك يجب ان تحتوي كلمة السر على",style: blackBoldTextStyle(context: context,fontSize: 13),),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:37),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  Column(
                                    children: [
                                      Text("A",style: blackBoldTextStyle(context: context,fontSize: 17,color: const Color.fromRGBO(119, 209, 75, 1)),),
                                      const SizedBox(height: 15,),
                                      Text(locale.largeLetters!,style: blackBoldTextStyle(context: context,fontSize: 13,color: const Color.fromRGBO(119, 209, 75, 1)),),

                                    ],
                                  ),



                                  Column(
                                    children: [
                                      Text("a",style: blackBoldTextStyle(context: context,fontSize: 17),),
                                      const SizedBox(height: 15,),
                                      Text(locale.smallLetters!,style: blackBoldTextStyle(context: context,fontSize: 13),),

                                    ],
                                  ),


                                  Column(
                                    children: [
                                      Text("123",style: blackBoldTextStyle(context: context,fontSize: 17,color: Theme.of(context).primaryColor),),
                                      const SizedBox(height: 15,),
                                      Text(locale.numbers!,style: blackBoldTextStyle(context: context,fontSize: 13,color: Theme.of(context).primaryColor),),

                                    ],
                                  ),


                                  Column(
                                    children: [
                                      Text("#\$&",style: blackBoldTextStyle(context: context,fontSize: 17),),
                                      const SizedBox(height: 15,),
                                      Text("رموز",style: blackBoldTextStyle(context: context,fontSize: 13),),

                                    ],
                                  ),
                                ],),
                            ),

                            Padding(
                              padding:  const EdgeInsets.only(top: 35),
                              child: CustomTextField(
                                controller: currentPasswordController,
                                title: "كلمة السر الحالية",
                                hint: locale.enterNewPassword!,
                                textInputAction: TextInputAction.next,
                                keyboardType:TextInputType.text,
                                onTap: () {  },),
                            ),

                            Padding(
                              padding:  const EdgeInsets.only(top: 15),
                              child: CustomTextField(
                                controller: newPasswordController,
                                textInputAction: TextInputAction.next,
                                title: locale.newPassword!, hint: locale.enterNewPassword!, onTap: () {  },),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 15,bottom: 150),
                              child: CustomTextField(
                                controller: confirmPasswordController,
                                textInputAction: TextInputAction.done,
                                title: locale.confirmNewPassword!, hint: locale.enterNewPassword!, onTap: () {  },),
                            ),




                          ],
                        ),
                      ),
                    ),

                    Container(
                      height: size.height*0.85,
                      alignment: Alignment.bottomCenter,
                      child: SafeArea(
                        child: Padding(
                          padding:  EdgeInsets.only(bottom: bottomPadding),
                          child: CustomButton(title: "تحديث كلمة السر",  loading: loading,onTap: () {

                            if(currentPasswordController.text!="") {
                              if(newPasswordController.text!="") {
                                if(confirmPasswordController.text!="") {
                                  if(newPasswordController.text==confirmPasswordController.text) {
                                    BlocProvider.of<ProfileBloc>(context)
                                        .add(
                                        ChangePassword(
                                            currentpassword: currentPasswordController
                                                .text,
                                            newpassword: newPasswordController
                                                .text,
                                            useId: userId()
                                        ));
                                  }else{
                                    showMessage(message: "لم يتم تآكيد كلمة المرور الجديدة بشكل صحيح", context: context);
                                  }
                                }else{
                                  showMessage(message: "الرجاء تآكيد كلمة السر الجديدة", context: context);
                                }
                              }else{
                                showMessage(message: "الرجاء ادخال كلمة السر الجديدة", context: context);
                              }
                            }else{
                              showMessage(message: "الرجاء ادخال كلمة السر الحالية", context: context);
                            }
                          }),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }));


  }
}
