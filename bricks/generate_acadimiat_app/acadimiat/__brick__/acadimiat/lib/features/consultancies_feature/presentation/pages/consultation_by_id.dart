import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../Locale/locale.dart';
import '../../../../Theme/style.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/functions.dart';
import '../../../../core/globals.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../../../core/widgets/cached_net_work_image.dart';
import '../../../../core/widgets/custom_botton.dart';
import '../../../../core/widgets/details_box.dart';
import '../../../../injection_container.dart';
import '../../../home_feature/data/models/card_by_id_model.dart';
import '../../../home_feature/presentation/pages/course_content/pages/trainer_info_page.dart';
import '../../domain/entities/consultancy_entity.dart';
import '../bloc/consultancies_bloc.dart';
import '../bloc/consultancies_event.dart';
import '../bloc/consultancies_state.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../test_page/browser.dart';

class ConsultationById extends StatefulWidget {
   ConsultationById(
      { Key? key,
        required this.id,
        required this.consultancyName,
        required this.consultantImage,
        required this.consultantName
      })
      : super(key: key);

  final int id;
  final String consultantImage;
  final String consultantName;
  final String consultancyName;



  @override
  State<ConsultationById> createState() => _ConsultationByIdState();
}

class _ConsultationByIdState extends State<ConsultationById> {
  List<Widget> widgetList = [];
  ConsultancyEntity consultancyEntity = ConsultancyEntity(
      consultancyId: -1,
      name: '',
      image: '',
      body: null,
      consultantName: '',
      numberOfSessions: 0,
      subscriptionLimit: '',
      typeOfSession: '',
      consultantImage: '',
      consultantInfo: '',
      squareImage: null,
      consultantId: -1,
      consultancyPrice: 0,
      timeLimit: 0,
      info: []);

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
        create: (BuildContext context) => sl<ConsultanciesBloc>(),
        child: Scaffold(body:
            BlocBuilder<ConsultanciesBloc, ConsultanciesState>(
                //ConsultanciesEvent
                builder: (context, state) {
          if (kDebugMode) {
            print("State:$state");
          }

          if (state is Empty) {
            BlocProvider.of<ConsultanciesBloc>(context)
                .add(GetConsultancyEvent(id: widget.id));
          }

          if (state is SuccessGetConsultancy) {
            consultancyEntity = state.consultancyEntity;
            widgetList = [];

            widgetList.add(
              Padding(
                padding: const EdgeInsets.only(
                  top: 17,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DetailsBox(
                        svg: 'assets/svgs/live-line.svg',
                        onTap: () {},
                        title: state.consultancyEntity.typeOfSession,
                        desc: 'طبيعة الاستشاره',
                      ),
                      const SizedBox(
                        width: 17,
                      ),
                      DetailsBox(
                        svg: 'assets/svgs/subscribe.svg',
                        onTap: () {},
                        title:
                            state.consultancyEntity.numberOfSessions.toString(),
                        desc: 'عدد الجلسات',
                      ),
                    ]),
              ),
            );
            widgetList.add(
              Padding(
                padding: const EdgeInsets.only(
                  top: 17,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DetailsBox(
                      svg: 'assets/svgs/clock.svg',
                      onTap: () {},
                      title:
                          'دقيقة ${state.consultancyEntity.timeLimit.toInt()}',
                      desc: 'مدة الجلسة',
                    ),
                    const SizedBox(
                      width: 17,
                    ),
                    DetailsBox(
                      svg: 'assets/svgs/message-question.svg',
                      onTap: () {},
                      title: state.consultancyEntity.subscriptionLimit,
                      desc: 'مدة الاشتراك',
                    ),

                    // DetailsBox(
                    //   svg: 'assets/svgs/sesion.svg',
                    //   onTap: () {},
                    //   title: 'شهادة مطبوعة',
                    //   desc: 'شهادة تدريب',
                    // ),
                  ],
                ),
              ),
            );

            widgetList.add(
              Padding(
                padding: const EdgeInsets.only(top: 17),
                child: GestureDetector(
                  onTap: () {
                    goTo(
                        context,
                        (context) => TrainerInfoPage(
                              trainer: Trainer(
                                  id: state.consultancyEntity.consultantId,
                                  trainerName:
                                      state.consultancyEntity.consultantName,
                                  trainerInfo:
                                      state.consultancyEntity.consultantInfo,
                                  trainerMoreInfo: "",
                                  trainerAvatar:
                                      state.consultancyEntity.consultantImage,
                                  trainerCourses: null),
                              image: state.consultancyEntity.consultantImage,
                            ));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Hero(
                            tag: "TrainerHeroTag",
                            child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2000),
                                  border: Border.all(
                                      width: 2,
                                      color: Theme.of(context)
                                          .canvasColor
                                          .withOpacity(0.5)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: CachedNetWorkImage(
                                      borderRadius: BorderRadius.circular(200),
                                      boxFit: BoxFit.fill,
                                      // padding: EdgeInsets.all(10),

                                      url: state
                                          .consultancyEntity.consultantImage),
                                )),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            state.consultancyEntity.consultantName,
                            style: blackBoldTextStyle(
                                context: context, fontSize: 13),
                          )
                        ],
                      ),
                      Text(
                        parseHtmlString(state.consultancyEntity.consultantInfo),
                        style: blackBoldTextStyle(
                            fontSize: 11.5,
                            context: context,
                            height: lineSpace),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      Row(
                        children: [
                          Text(
                            "اقرأ المزيد",
                            style: blackBoldTextStyle(
                                fontSize: 11.5,
                                context: context,
                                height: lineSpace,
                                color: Theme.of(context).primaryColor),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );

            for (var item in state.consultancyEntity.info) {
              widgetList.add(Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      item.header,
                      style: blackBoldTextStyle(
                          fontSize: 15,
                          context: context,
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: HtmlWidget(
                      "<div style='background-color:${Theme.of(context).scaffoldBackgroundColor} !important; line-height:${lineSpace} ;font-family:${"taleeq-bold"} !important; font-size:${0.8}em !important' color:${Theme.of(context).canvasColor} !important'>${item.body.replaceAll("background-color", "").replaceAll("color", "").replaceAll("font-family", "")..replaceAll("font-size", "")}</div >",
                      customWidgetBuilder: (element) {
                        if (element.attributes['background-color'] == 'bar') {
                          return Container(
                            width: 20,
                            height: 30,
                            color: Colors.red,
                          );
                        }

                        return null;
                      },
                      webView: true,
                    ),
                  ),
                ],
              ));
            }
            widgetList.add(const SizedBox(
              height: 130,
            ));
          }

          return Scaffold(
            appBar:
                appBarWidget(widget.consultancyName, context, true, null, null),
            body: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 17, right: 17),
                  child: SizedBox(
                    height: size.height,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: (widgetList.isNotEmpty)
                            ? widgetList
                            : [
                                LoadingConsultationPage(
                                  id: widget.id,
                                  consultantImage: widget.consultantImage,
                                  consultantName: widget.consultantName,
                                )
                              ],
                      ),
                    ),
                  ),
                ),

                Container(
                  color: Theme.of(context).cardColor,
                  // height: 83,
                  width: double.infinity,
                  child: SafeArea(
                    top:false,
                    child: Padding(
                      padding: const EdgeInsets.all(17),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomButton(
                            width: size.width - 34 ,
                               title: locale.buyNow!+ " ${consultancyEntity.consultancyPrice}\$",
                            onTap: (){
                              goTo(context, (context) =>  Browser(url:"https://www.emasteryacademy.com/advice/${consultancyEntity.consultancyId}",),);

                            },),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        })));
  }
}

class LoadingConsultationPage extends StatelessWidget {
  const LoadingConsultationPage(
      {Key? key,
      required this.id,
      required this.consultantImage,
      required this.consultantName})
      : super(key: key);

  final int id;
  final String consultantImage;
  final String consultantName;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Hero(
                    tag: "consultantTag$id",
                    child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2000),
                          border: Border.all(
                              width: 2,
                              color: Theme.of(context)
                                  .canvasColor
                                  .withOpacity(0.5)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: CachedNetWorkImage(
                              borderRadius: BorderRadius.circular(200),
                              boxFit: BoxFit.fill,
                              // padding: EdgeInsets.all(10),

                              url: consultantImage),
                        )),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    consultantName,
                    style: blackBoldTextStyle(context: context, fontSize: 13),
                  )
                ],
              ),
              // Text("150\$",style: blackBoldTextStyle(context: context,fontSize: 20),),
            ],
          ),
        ),
        Shimmer.fromColors(
          baseColor: Theme.of(context).cardColor,
          highlightColor: Color.fromRGBO(119, 118, 118, 0.5490196078431373),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 14,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 100,
                  width: 110,
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(9),
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      )),
                ),
                Container(
                  height: 100,
                  width: 110,
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(9),
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      )),
                ),
                Container(
                  height: 100,
                  width: 110,
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(9),
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      )),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Shimmer.fromColors(
            baseColor: Theme.of(context).cardColor,
            highlightColor: Color.fromRGBO(119, 118, 118, 0.5490196078431373),
            child: Container(
              height: 20,
              width: 110,
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(
                    width: 1,
                    color: Colors.grey,
                  )),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Shimmer.fromColors(
            baseColor: Theme.of(context).cardColor,
            highlightColor: Color.fromRGBO(119, 118, 118, 0.5490196078431373),
            child: Container(
              height: size.height * 0.4,
              width: size.width - 34,
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(
                    width: 1,
                    color: Colors.grey,
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
