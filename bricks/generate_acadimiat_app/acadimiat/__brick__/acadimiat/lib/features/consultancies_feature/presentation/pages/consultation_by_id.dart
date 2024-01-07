import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../Locale/locale.dart';
import '../../../../Theme/style.dart';
import '../../../../core/functions.dart';
import '../../../../core/globals.dart';
import '../../../../core/util/assets_manager.dart';
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

import '../browser_pages/browser.dart';
import 'loading_consultation_page.dart';

class ConsultationById extends StatefulWidget {
  const ConsultationById({
    super.key,
    required this.id,
    required this.consultancyName,
    required this.consultantImage,
    required this.consultantName,
  });

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
    info: [],
  );

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    Size size = MediaQuery.of(context).size;
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
                  .add(GetConsultancyEvent(id: widget.id));
            }
            if (state is SuccessGetConsultancy) {
              consultancyEntity = state.consultancyEntity;
              widgetList = _buildWidgetList(state);
            }
            return Scaffold(
              appBar: appBarWidget(widget.consultancyName, context, true, null, null),
              body: _buildBody(context, size),
            );
          },
        ),
      ),
    );
  }

  List<Widget> _buildWidgetList(SuccessGetConsultancy state) {
    var widgetList = <Widget>[
      _buildDetailsBoxes(state),
      _buildTrainerInfo(state),
      _buildInfoItems(state),
      const SizedBox(height: 130),
    ];
    return widgetList;
  }

  Widget _buildDetailsBoxes(SuccessGetConsultancy state) {
    return Padding(
      padding: const EdgeInsets.only(top: 17),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DetailsBox(
            svg: ImgAssets.liveLine,
            onTap: () {},
            title: state.consultancyEntity.typeOfSession,
            desc: 'طبيعة الاستشاره',
          ),
          const SizedBox(width: 17),
          DetailsBox(
            svg: ImgAssets.subscribe,
            onTap: () {},
            title: state.consultancyEntity.numberOfSessions.toString(),
            desc: 'عدد الجلسات',
          ),
        ],
      ),
    );
  }

  Widget _buildTrainerInfo(SuccessGetConsultancy state) {
    return Padding(
      padding: const EdgeInsets.only(top: 17),
      child: GestureDetector(
        onTap: () {
          goTo(context, (context) => TrainerInfoPage(
            trainer: Trainer(
              id: state.consultancyEntity.consultantId,
              trainerName: state.consultancyEntity.consultantName,
              trainerInfo: state.consultancyEntity.consultantInfo,
              trainerMoreInfo: "",
              trainerAvatar: state.consultancyEntity.consultantImage,
              trainerCourses: null,
            ),
            image: state.consultancyEntity.consultantImage,
          ));
        },
        child: Column(
          children: [
            _buildTrainerDetails(state),
            _buildTrainerDescription(state),
            _buildReadMoreLink(),
          ],
        ),
      ),
    );
  }

  Widget _buildTrainerDetails(SuccessGetConsultancy state) {
    return Row(
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
                color: Theme.of(context).canvasColor.withOpacity(0.5),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: CachedNetWorkImage(
                borderRadius: BorderRadius.circular(200),
                boxFit: BoxFit.fill,
                url: state.consultancyEntity.consultantImage,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          state.consultancyEntity.consultantName,
          style: blackBoldTextStyle(context: context, fontSize: 13),
        ),
      ],
    );
  }

  Widget _buildTrainerDescription(SuccessGetConsultancy state) {
    return Text(
      parseHtmlString(state.consultancyEntity.consultantInfo),
      style: blackBoldTextStyle(fontSize: 11.5, context: context, height: lineSpace),
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );
  }

  Widget _buildReadMoreLink() {
    return Row(
      children: [
        Text(
          "اقرأ المزيد",
          style: blackBoldTextStyle(fontSize: 11.5, context: context, height: lineSpace, color: Theme.of(context).primaryColor),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      ],
    );
  }

  Widget _buildInfoItems(SuccessGetConsultancy state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: state.consultancyEntity.info.map((item) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                item.header,
                style: blackBoldTextStyle(fontSize: 15, context: context, color: Theme.of(context).primaryColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: HtmlWidget(
                "<div style='background-color:${Theme.of(context).scaffoldBackgroundColor} !important; line-height:$lineSpace ;font-family:${"taleeq-bold"} !important; font-size:${0.8}em !important' color:${Theme.of(context).canvasColor} !important'>${item.body.replaceAll("background-color", "").replaceAll("color", "").replaceAll("font-family", "")..replaceAll("font-size", "")}</div >",
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
        );
      }).toList(),
    );
  }

  Widget _buildBody(BuildContext context, Size size) {
    var locale = AppLocalizations.of(context)!;
    return Stack(
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
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          color: Theme.of(context).cardColor,
          width: double.infinity,
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(17),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomButton(
                    width: size.width - 34,
                    title: "${locale.buyNow!} ${consultancyEntity.consultancyPrice}\$",
                    onTap: () {
                      goTo(context, (context) => Browser(url: "https://www.emasteryacademy.com/advice/${consultancyEntity.consultancyId}"),);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
