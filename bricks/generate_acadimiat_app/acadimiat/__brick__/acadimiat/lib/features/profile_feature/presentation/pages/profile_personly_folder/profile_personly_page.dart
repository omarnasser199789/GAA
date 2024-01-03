import 'package:acadmiat/Theme/style.dart';
import 'package:acadmiat/features/profile_feature/presentation/pages/profile_personly_folder/edit_personal_info_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../Locale/locale.dart';
import '../../../../../core/globals.dart';
import '../../../../../core/widgets/app_bar_widget.dart';
import '../../../domain/entities/user_info_entity.dart';
import 'creare_new_password_page.dart';
import 'delete_account/delete_account_page.dart';

class ProfilePersonlyPage extends StatefulWidget {
  const ProfilePersonlyPage({super.key,required this.userInfoEntity});
  final UserInfoEntity userInfoEntity;
  @override
  State<ProfilePersonlyPage> createState() => _ProfilePersonlyPageState();
}

class _ProfilePersonlyPageState extends State<ProfilePersonlyPage> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar:appBarWidget("الملف الشخصي",context,true,null,null),
      body: Padding(
        padding: defaultPadding,
        child: SingleChildScrollView(
          child: Column(
            children: [

              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12,right: 12,top: 16,bottom: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [

                      Row(

                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/svgs/profile-circle.svg",
                                color: iconsColor,
                              ),
                              const SizedBox(width: 7,),
                              Text("البيانات الشخصية",style: blackBoldTextStyle(fontSize: 13, context: context),),
                            ],
                          ),


                          GestureDetector(
                              onTap: ()async{
                             var v= await   goTo(context,(context)=>  EditPersonalInfoPage(userInfoEntity:widget.userInfoEntity));
                             setState(() {

                             });
                              },
                              child: Text("تعديل ",style: blackBoldTextStyle(fontSize: 12, context: context,color: Theme.of(context).primaryColor),)),

                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top:17),
                        child:  TextWidget(title:  locale.email! ,text: widget.userInfoEntity.email,),
                      ),
                      TextWidget(title: locale.name!,text:widget.userInfoEntity.name,),
                      TextWidget(title: locale.mobileNumber!,text:widget.userInfoEntity.phone,),




                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top:12),
                child: GestureDetector(
                  onTap: (){
                    goTo(context,(context)=> const CreateNewPasswordPage());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12,right: 12,top: 20,bottom: 20),
                      child: Row(

                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/svgs/lock.svg",
                                color: iconsColor,
                              ),
                              SizedBox(width: 7,),
                              Text("تغيير كلمة المرور",style: blackBoldTextStyle(fontSize: 13, context: context),),
                            ],
                          ),


                          Text("تغيير كلمة المرور",style: blackBoldTextStyle(fontSize: 12, context: context,color: Theme.of(context).primaryColor),),

                        ],
                      ),
                    ),
                  ),
                ),
              ),


              Padding(
                padding: const EdgeInsets.only(top:12),
                child: GestureDetector(
                  onTap: (){
                    goTo(context,(context)=> const DeleteAccountPage());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12,right: 12,top: 20,bottom: 20),
                      child: Row(

                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/svgs/deleteIcon.svg",
                                color: iconsColor,
                              ),
                              const SizedBox(width: 7,),
                              Text("حذف الحساب",style: blackBoldTextStyle(fontSize: 13, context: context),),
                            ],
                          ),
                          Text("حذف الحساب",style: blackBoldTextStyle(fontSize: 12, context: context,color: Theme.of(context).primaryColor),),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class TextWidget extends StatelessWidget {
  const TextWidget({super.key,required this.title,required this.text});
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return   Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top:10),
          child: Text(title,style: blackBoldTextStyle(context: context,fontSize: 12,)),
        ),
        Padding(
          padding: const EdgeInsets.only(top:8),
          child: Container(
            width: double.infinity,
            alignment: Alignment.center,
            height: 45,
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(8)
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 8,right: 8),
              child: Row(
                children: [
                  Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text(text,style: blackBoldTextStyle(fontSize: 12, context: context,color: iconsColor,),)),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
