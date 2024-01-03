import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../Locale/locale.dart';
import '../../../../Theme/style.dart';

class CourseCertificatesWidget extends StatefulWidget {
  const CourseCertificatesWidget({super.key});

  @override
  State<CourseCertificatesWidget> createState() => _CourseCertificatesWidgetState();
}

class _CourseCertificatesWidgetState extends State<CourseCertificatesWidget> {
  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    var locale = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.only(top:26,left: 17,right: 17,bottom: 100),
      child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context,index){
        return Padding(
          padding: const EdgeInsets.only(bottom: 13),
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12)
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Container(
                          width: size.width-54,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(locale.managementAndSmallAndMediumEnterprises!,style: blackBoldTextStyle(context: context,fontSize: 10,color: hintTextColor ),),

                              // SizedBox(width: 80,),
                              Container(
                                alignment: Alignment.center,
                                height: 24,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      width: 1,
                                      color: const Color.fromRGBO(38, 96, 164, 1),
                                    )
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 9,right: 9),
                                  child: Text(locale.packages!,style: blackBoldTextStyle(context: context,fontSize: 11,color: const Color.fromRGBO(38, 96, 164, 1),),),
                                ),
                              )

                            ],
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Text(locale.howToWriteAndImplementASalesPlan!,style: blackBoldTextStyle(context: context,fontSize: 12),),
                      ),

                      SizedBox(
                        width: size.width-54,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 9),
                              child: Container(height: 27,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(14)
                                ),
                                child:  Padding(
                                  padding: const EdgeInsets.only(left: 9,right: 9),
                                  child: Text("5/5 ${locale.trainingCertificate!}",style: blackBoldTextStyle(context: context,fontSize: 10,color: Colors.white),),
                                ),

                              ),
                            ),
                            Container(
                              width: 45,
                              height: 45,
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                "assets/svgs/certificate with bg.svg",
                                // width: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16,)
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      })
    );
  }
}
