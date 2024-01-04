import 'package:acadmiat/core/widgets/waiting_widget.dart';
import 'package:acadmiat/features/consultancies_feature/presentation/pages/consultation/widgets/consultancies_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';

import '../../../../../../core/widgets/app_bar_widget.dart';
import '../../../../../../core/widgets/empty_state_widget.dart';
import '../../../../../Locale/locale.dart';
import '../../../../../core/functions.dart';
import '../../../../../core/util/assets_manager.dart';
import '../../../../../injection_container.dart';
import '../../../../home_feature/presentation/pages/consulting/consulting_page.dart';
import '../../../domain/entities/my_consultancies_entity.dart';
import '../../bloc/bloc.dart';

class ConsultationPage extends StatefulWidget {
  const ConsultationPage({super.key});

  @override
  State<ConsultationPage> createState() => _ConsultationPageState();
}

class _ConsultationPageState extends State<ConsultationPage> {
  late  List<MyConsultanciesEntity> consultanciesEntityList = [];
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var locale = AppLocalizations.of(context)!;
    Jiffy.locale("ar");

    return BlocProvider(
      create: (BuildContext context) => sl<ConsultanciesBloc>(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: appBarWidget(locale.myConsultation!, context, false, null, null),
        body: BlocBuilder<ConsultanciesBloc, ConsultanciesState>(
          builder: (context, state) {
            if (kDebugMode) {
              print("State:$state");
            }

            if (state is Empty && isLoggedIn()) {
              BlocProvider.of<ConsultanciesBloc>(context).add(GetMyConsultanciesEvent(id: userId()));
            }
            if (state is Loading) {
              loading = true;
            } else {
              loading = false;
            }
            if (state is SuccessGetMyConsultancies) {
              consultanciesEntityList = state.consultanciesEntityList;
            }

            return Scaffold(
              body: _buildBody(size, context),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBody(Size size, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (consultanciesEntityList.isNotEmpty && !loading)
            ConsultanciesList(consultanciesEntityList: consultanciesEntityList)
          else if (consultanciesEntityList.isEmpty && !loading)
            EmptyStateWidget(
              svg: ImgAssets.consultations,
              text1: "هل انت بحاجة لاستشارة خبير؟",
              text3: "احجز استشارتك",
              onTap: () async {
                await goTo(context, (context) => ConsultingPage(consultanciesEntity: []));
                if (isLoggedIn()) {
                  BlocProvider.of<ConsultanciesBloc>(context).add(GetMyConsultanciesEvent(id: userId()));
                }
              },
            )
          else
            const WaitingWidget(),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}


