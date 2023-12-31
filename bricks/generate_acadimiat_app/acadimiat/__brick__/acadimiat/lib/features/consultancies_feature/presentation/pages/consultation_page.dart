import 'package:acadmiat/core/globals.dart';
import 'package:acadmiat/core/widgets/waiting_widget.dart';
import 'package:acadmiat/features/consultancies_feature/presentation/pages/session_page.dart';
import 'package:flutter/foundation.dart';
import '../../../../../core/widgets/app_bar_widget.dart';
import 'package:acadmiat/core/widgets/custom_botton.dart';
import 'package:flutter/material.dart';
import '../../../../Locale/locale.dart';
import '../../../../Theme/style.dart';
import '../../../../core/functions.dart';
import '../../../../core/widgets/cached_net_work_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../../../injection_container.dart';
import 'package:jiffy/jiffy.dart';

import '../../../home_feature/presentation/pages/consulting/consulting_page.dart';
import '../../domain/entities/my_consultancies_entity.dart';
import '../bloc/bloc.dart';
import '../widgets/session_number.dart';

class ConsultationPage extends StatefulWidget {
  const ConsultationPage({Key? key}) : super(key: key);

  @override
  State<ConsultationPage> createState() => _ConsultationPageState();
}

class _ConsultationPageState extends State<ConsultationPage> {



   List<MyConsultanciesEntity> consultanciesEntityList=[];
   bool loading = false;


  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;

    var locale = AppLocalizations.of(context)!;
    Jiffy.locale("ar");

    return BlocProvider(
        create: (BuildContext context) => sl<ConsultanciesBloc>(),
    child: Scaffold(
    body: BlocBuilder<ConsultanciesBloc, ConsultanciesState>(
    builder: (context, state) {

    if (kDebugMode) {
    print("State:$state");
    }

    if (state is Empty && isLoggedIn()) {
    BlocProvider.of<ConsultanciesBloc>(context).add(GetMyConsultanciesEvent(id: userId()));
    }
    if(state is Loading){
      loading = true;
    }else{
      loading = false;
    }
    if(state is SuccessGetMyConsultancies ){

      consultanciesEntityList=  state.consultanciesEntityList;

    }


    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar:appBarWidget(locale.myConsultation!,context,false,null,null),
      body: (
          consultanciesEntityList.isNotEmpty && loading == false
      )? SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200 * consultanciesEntityList.length/1,
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: consultanciesEntityList.length,itemBuilder: (context,index){
                return  SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(top:9,bottom: 9,left: 17,right: 17),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Theme.of(context).cardColor,
                          border: Border.all(
                            width: 0.5,
                            color: Colors.grey,
                          )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10,left: 12,right: 12,top:10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [








                            Padding(
                              padding: const EdgeInsets.only(top:10,bottom: 10),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                      width: 75,
                                      height: 75,
                                      child: CachedNetWorkImage(borderRadius: BorderRadius.circular(10),
                                        boxFit: BoxFit.fill,
                                        url:consultanciesEntityList[index].consultancyImage ,)),
                                  const SizedBox(width: 20,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Text(consultanciesEntityList[index].id.toString()),
                                      Text(
                                        Jiffy(consultanciesEntityList[index].date).yMMMdjm,
                                        style: blackBoldTextStyle(context: context, fontSize: 11,color: hintTextColor),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top:10),
                                        child: SizedBox(
                                          width: size.width-170,

                                          child: Text(
                                            consultanciesEntityList[index].consultancy,
                                            style: blackBoldTextStyle(context: context,fontSize: 13),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top:10),
                                        child: Text(
                                          consultanciesEntityList[index].consultant,
                                          style: blackBoldTextStyle(context: context,fontSize: 12,color: hintTextColor),
                                        ),
                                      ),

                                    ],
                                  ),

                                ],
                              ),
                            ),


                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SessionNumber(numberOfSessions: consultanciesEntityList[index].numberOfSessions,),
                                // Row(
                                //   children: [
                                //     SvgPicture.asset(
                                //       "assets/svgs/question.svg",
                                //       color:iconsColor,
                                //     ),
                                //     const SizedBox(width: 10,),
                                //     Column(
                                //       crossAxisAlignment: CrossAxisAlignment.start,
                                //       children: [
                                //         Text("${consultanciesEntityList[index].numberOfSessions} جلسة",style: blackBoldTextStyle(context: context,fontSize: 12),),
                                //
                                //         Padding(
                                //           padding: const EdgeInsets.only(top:5),
                                //           child: Text("عدد الجلسات",style: blackBoldTextStyle(context: context,fontSize: 11,color:  hintTextColor),),
                                //         ),
                                //       ],
                                //     ),
                                //
                                //
                                //   ],
                                // ),
                                 CustomButton(title: 'متابعة',width: 90,height: 37,borderRadius:8,onTap: (){
                                  goTo(context, (context) => SessionPage(
                                    consultationID: consultanciesEntityList[index].id,
                                    consultancy: consultanciesEntityList[index].consultancy,
                                    consultant: consultanciesEntityList[index].consultant,
                                    image: consultanciesEntityList[index].consultancyImage,
                                    date: consultanciesEntityList[index].date,
                                    numberOfSessions: consultanciesEntityList[index].numberOfSessions,
                                  ));
                                },),
                              ],
                            ),



                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 80,),

          ],
        ),
      ):
      (consultanciesEntityList.isEmpty && loading == false)?
      EmptyStateWidget(svg:"assets/svgs/consultations.svg",
        text1:"هل انت بحاجة لاستشارة خبير؟",
      text3: "احجز استشارتك",
        onTap: () async {

        await goTo(context, (context) => ConsultingPage(consultanciesEntity:[]));

        if(isLoggedIn()) {
          BlocProvider.of<ConsultanciesBloc>(context).add(GetMyConsultanciesEvent(id: userId()));
        }

        },
      ):const WaitingWidget(),
    );
    })));



  }
}


