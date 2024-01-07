import 'package:acadmiat/core/globals.dart';
import 'package:acadmiat/core/widgets/custom_botton.dart';
import 'package:acadmiat/features/consultancies_feature/presentation/bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jiffy/jiffy.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../domain/entities/consultation_session_entity.dart';
import '../../browser_pages/browser.dart';
import '../book_consultation/book_consultation_page.dart';
import 'title_widget.dart';
import '../../../../../core/functions.dart';
import '../../../../../core/util/assets_manager.dart';
import '../../../../../core/widgets/app_bar_widget.dart';
import '../../../../../injection_container.dart';
import '../../../../../Theme/style.dart';

class SessionPage extends StatefulWidget {
  SessionPage({
    super.key,
    required this.consultationID,
    required this.consultancy,
    required this.numberOfSessions,
    required this.consultant,
    required this.image,
    required this.date,
  });

  final int consultationID;
  final int numberOfSessions;
  final String consultancy;
  final String consultant;
  final String image;
  final DateTime date;

  @override
  State<SessionPage> createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  List<ConsultationSessionEntity> consultationSessionList = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Jiffy.locale("ar");
    return BlocProvider(
      create: (BuildContext context) => sl<ConsultanciesBloc>(),
      child: Scaffold(
        body: BlocBuilder<ConsultanciesBloc, ConsultanciesState>(
          builder: (context, state) {
            if (kDebugMode) {
              print("State:$state");
            }
            if (state is Empty) {
              BlocProvider.of<ConsultanciesBloc>(context)
                  .add(GetConsultationSessionsEvent(consultationID: widget.consultationID));
            }
            if (state is SuccessGetConsultationSession) {
              consultationSessionList = state.consultationSessionList;
            }

            return Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              appBar: appBarWidget("", context, true, null, null),
              body: _buildBody(context, size),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBookConsultationButton(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      height: 70,
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.only(left: 17, right: 17),
        child: CustomButton(
          title: 'احجز موعد الاستشارة',
          onTap: () async {
            final result = await showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
                builder: (context) {
                  List<DateTime> takenDate  =[];
                  for(var item in consultationSessionList){
                    DateTime date = item.date;
                    date = date.add(Duration(hours: date.hour));
                    takenDate.add(item.date);
                  }
                  return Material(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    child: StatefulBuilder(builder:
                        (BuildContext context, StateSetter mystate) {
                      return BookConsultationPage(
                        consultancyId: widget.consultationID,
                        takenDate:takenDate,
                      );
                    }
                    ),
                  );
                }).whenComplete(() {

            });

            if(result == 200){
              BlocProvider.of<ConsultanciesBloc>(context).add(GetConsultationSessionsEvent(consultationID: widget.consultationID));
            }else if (result == 500 || result == 501) {
              showMessage(
                message: result == 500 ? "الرجاء اختيار الوقت والتاريخ" : "لم يتم حجز الجلسة الرجاء التواصل مع مركذ الدعم",
                context: context,
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context,Size size) {

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          width: double.infinity,
          height: size.height,
          child: Padding(
            padding: defaultPadding,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleWidget(
                    date: widget.date,
                    numberOfSessions: widget.numberOfSessions,
                    image: widget.image,
                    consultancy: widget.consultancy,
                    consultant: widget.consultant,
                  ),
                  _buildSessionsList(context,size),
                ],
              ),
            ),
          ),
        ),
        if (widget.numberOfSessions > consultationSessionList.length)
          _buildBookConsultationButton(context),
      ],
    );
  }

  Widget _buildSessionsList(BuildContext context,Size size) {
   return Column(
     children: [
       Padding(
         padding: const EdgeInsets.only(top: 11, bottom: 5),
         child: Text(
           "الجلسات", style: blackBoldTextStyle(fontSize: 14, context: context),
         ),
       ),

       if (consultationSessionList.isNotEmpty)
         SizedBox(
           height: size.height - 315,
           child: ListView.builder(
             itemCount: consultationSessionList.length,
             itemBuilder: (context, index) => _buildSessionItem(context, index),
           ),
         ),
       if (consultationSessionList.isEmpty)
         _buildEmptySessionsList(context),
     ],
   );
  }

  Widget _buildEmptySessionsList(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10)
      ),
      child: Padding(
        padding: const EdgeInsets.only(top:15,bottom: 15),
        child: Column(children: [
          SvgPicture.asset(ImgAssets.date),
          Padding(
            padding: const EdgeInsets.only(top:10),
            child: Text("قم باضافة موعد لجلستك",style: blackBoldTextStyle(fontSize: 11, context: context),),
          ),
          Padding(
            padding: const EdgeInsets.only(top:15),
            child: Text("اضغط على زر اضافة في اسفل الشاشة",style: blackBoldTextStyle(fontSize: 11, context: context,color: hintTextColor,)),
          ),
        ],),
      ),
    );
  }

  Widget _buildSessionItem(BuildContext context, int index) {

    Decoration? decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Theme.of(context).cardColor,
      border: Border.all(width: 0.5, color: Colors.grey),
    );
    final session = consultationSessionList[index];

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(top: 9, bottom: 9),
        child: Container(
          decoration: decoration,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 12, right: 12, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSessionDateTime(context, session),

                if (!session.isActive) _buildPendingApprovalText(context),

                if (!session.isDone && session.url != "") _buildContinueButton(context),

                if (session.isDone) _buildSessionEndedButton(context),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSessionDateTime(BuildContext context,ConsultationSessionEntity session) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SvgPicture.asset(
              ImgAssets.vuesaxLinearCalendar,
              color: iconsColor,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      Jiffy(session.date).yMMMd,
                      style: blackBoldTextStyle(context: context, fontSize: 11),
                    ),
                    Text(
                      Jiffy(session.hour).jm,
                      style: blackBoldTextStyle(context: context, fontSize: 11),
                    ),
                  ],
                ),

                Text(
                  "موعد الجلسة",
                  style: blackBoldTextStyle(fontSize: 10, context: context, color: hintTextColor),
                ),
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment:
          CrossAxisAlignment.end,
          children: [
            Text(
                "#${session.id}"),
            Text(
              "رقم الطلب",
              style: blackBoldTextStyle(fontSize: 10, context: context, color: hintTextColor),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPendingApprovalText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:10,right: 27),
      child: Text("بانتظار الموافقة" ,style: blackBoldTextStyle(fontSize: 10,context: context,color: Colors.red)),
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.only(
          top: 20),
      child: CustomButton(
        title: 'متابعة',
        width: double.infinity,
        height: 37,
        borderRadius: 8,
        onTap: () async {
          await Permission.camera.request();
          await Permission.microphone.request();
          await Permission.storage.request();
          goTo(context, (context) => const Browser(url:"https://conference.emasteryacademy.com/bigbluebutton/api/join?fullName=%D9%86%D9%88%D8%B1%20%D8%A7%D9%84%D8%AF%D9%8A%D9%86%20%D9%8A%D8%A7%D8%B3%D9%8A%D9%86&meetingID=WHO9FH00C1&password=5VA4BM5ZLR&checksum=f8c4068e4cf495bad33c891617e31fe296c36ecf",),);
        },
      ),
    );
  }

  Widget _buildSessionEndedButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: CustomButton(
        title: 'انتهت الجلسة',
        width: double.infinity,
        textColor: Theme.of(context).primaryColor,
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        height: 37,
        borderRadius: 8,
        onTap: () async {},
      ),
    );
  }
}

