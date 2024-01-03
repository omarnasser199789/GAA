import 'package:acadmiat/core/globals.dart';
import 'package:acadmiat/core/widgets/app_bar_widget.dart';
import 'package:acadmiat/core/widgets/custom_botton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../Locale/locale.dart';
import '../../../../../../Theme/style.dart';
import '../../../../../../core/util/assets_manager.dart';
import '../../../../../../core/widgets/custom_text_field.dart';
import 'Info.dart';

class DeleteAccountPage extends StatefulWidget {
  const DeleteAccountPage({super.key});

  @override
  State<DeleteAccountPage> createState() => _DeleteAccountPageState();

}

class _DeleteAccountPageState extends State<DeleteAccountPage> {
  var val ;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar:appBarWidget(locale.deleteAccount!,context,true,null,null),
      body: Padding(
        padding: defaultPadding,
        child: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Column(
                children: [

                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12)
                    ),

                    child: Padding(
                      padding: const EdgeInsets.only(left: 15,right: 15,bottom: 15),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 12  ),
                            child: Row(
                              children: [

                                SvgPicture.asset(
                                  ImgAssets.featherAlertTriangle,
                                ),
                                const SizedBox(width: 13,),
                                Text(locale.whenTheAccountIsDeletedItWillBe!,style: blackBoldTextStyle(context: context,fontSize: 14,color: Theme.of(context).primaryColor),),
                              ],
                            ),
                          ),
                           Padding(
                            padding: const EdgeInsets.only(top: 5  ),
                            child: Info(svg:ImgAssets.warning ,text:locale.logoutAllDevices!,)
                          ),
                           Info(svg:ImgAssets.warning ,text: locale.deleteAllAccountData!,),
                           Info(svg:ImgAssets.warning ,text: locale.theAccountCannotBeRestoredAgain!,),


                        ],
                      ),
                    ),

                  ),


                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Container(
                      width: double.infinity,
                      // height: 380,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        border: Border.all(width: 1,color:borderColor)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15,right: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 17),
                              child: Text(locale.pleaseWhatAreTheReasonsRorYourAccountDeletion!,style: blackBoldTextStyle(context: context,fontSize: 14),),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  Radio(

                                    fillColor: MaterialStateColor.resolveWith((states) => activeColor),
                                    value: 0,
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    groupValue: val,
                                    onChanged: (value) {
                                      setState(() {
                                        val = value;

                                      });
                                    },
                                    activeColor: Theme.of(context).primaryColor,
                                  ),
                                  Text(locale.iDoNotWantTheAccountAnymore!,style: blackBoldTextStyle(context: context,fontSize: 13),)
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Radio(

                                  fillColor: MaterialStateColor.resolveWith((states) => activeColor),
                                  value: 1,

                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  groupValue: val,
                                  onChanged: (value) {
                                    setState(() {
                                      val = value;

                                    });
                                  },
                                  activeColor: Theme.of(context).primaryColor,
                                ),
                                Text(locale.iDidNotBenefitFromTheTrainingProgramme!,style: blackBoldTextStyle(context: context,fontSize: 13),)
                              ],
                            ),
                            Row(
                              children: [
                                Radio(

                                  fillColor: MaterialStateColor.resolveWith((states) => activeColor),
                                  value: 2,

                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  groupValue: val,
                                  onChanged: (value) {
                                    setState(() {
                                      val = value;

                                    });
                                  },
                                  activeColor: Theme.of(context).primaryColor,
                                ),
                                Text(locale.coursesAreTooExpensive!,style: blackBoldTextStyle(context: context,fontSize: 13),maxLines: 1,)
                              ],
                            ),
                            Row(
                              children: [
                                Radio(

                                  fillColor: MaterialStateColor.resolveWith((states) => activeColor),
                                  value: 3,

                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  groupValue: val,
                                  onChanged: (value) {
                                    setState(() {
                                      val = value;

                                    });
                                  },
                                  activeColor: Theme.of(context).primaryColor,
                                ),
                                Text(locale.iHaveAnotherAccount!,style: blackBoldTextStyle(context: context,fontSize: 13),)
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  fillColor: MaterialStateColor.resolveWith((states) => activeColor),
                                  value: 4,
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  groupValue: val,
                                  onChanged: (value) {
                                    setState(() {
                                      val = value;
                                    });
                                  },
                                  activeColor: Theme.of(context).primaryColor,
                                ),
                                Text(locale.other!,style: blackBoldTextStyle(context: context,fontSize: 13),)
                              ],
                            ),
                            if(val==4)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 17),
                              child: CustomTextField(title: '', hint: locale.giveTheReasonsForDeletingTheAccount!,width: size.width-15,maxLines: 3, onTap: () {  },),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),


                ],
              ),

              Container(
                height: size.height*0.85,
                alignment: Alignment.bottomCenter,
                child: SafeArea(
                  child: Padding(
                    padding:  const EdgeInsets.only(bottom: bottomPadding),
                    child: CustomButton(title: locale.confirmAccountDeletion!, onTap: (){

                    }),
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



