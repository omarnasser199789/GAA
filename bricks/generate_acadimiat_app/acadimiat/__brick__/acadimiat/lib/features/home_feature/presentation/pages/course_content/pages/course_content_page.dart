import 'package:acadmiat/core/widgets/waiting_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/util/assets_manager.dart';
import '../../../../../../core/widgets/empty_state_widget.dart';
import '../../../../../../core/widgets/app_bar_widget.dart';
import '../../../../../cart_feature/presentation/success_payment_page.dart';
import '../widgets/loaded_state_widget.dart';
import '../../../../../../injection_container.dart';
import '../../../bloc/home_bloc.dart';
import '../../../bloc/home_event.dart';
import '../../../bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseContentPage extends StatefulWidget {
  const CourseContentPage({super.key, required this.cardId, required this.productType, required this.courseCover});

  final int cardId;
  final int productType;
  final String courseCover;

  @override
  State<CourseContentPage> createState() => _CourseContentPageState();
}

class _CourseContentPageState extends State<CourseContentPage> {
  final controller = PageController(initialPage: 0);
  bool allowShowPaymentSheet = false;
  int page = 0;
  bool selected = true;
  bool changeColor = true;
  bool initVideoIsNotInit = false;
  bool loading = false;
  bool allowGo = false;
  int animatedDuration = 2;
  bool allowGetCard = true;
  Size get preferredSize => Size.fromHeight(kToolbarHeight + MediaQuery.of(context).padding.top);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocProvider(
        create: (BuildContext context) => sl<HomeBloc>(),
        child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          if (kDebugMode) {
            print("State:$state");
          }
          if (state is Empty && allowGetCard) {
            allowGetCard=false;
            BlocProvider.of<HomeBloc>(context).add(GetCardByIdEvent(id: widget.cardId));
          }
          else if (state is Error) {
            return Scaffold(appBar:appBarWidget("",context,true,null,null),
              body: EmptyStateWidget(svg:ImgAssets.error,
                text1:"عذرا! حدثت مشكلة غير متوقعة",
                text3: "حدث الان",
                onTap: () async {
                  BlocProvider.of<HomeBloc>(context).add(GetCardByIdEvent(id: widget.cardId));
                },
              ),
            );
          }
          else if(state is SuccessCheckPurchase && allowGo){
            _handleSuccessCheckPurchase(context, state);
          }
          else if (state is CardByIdLoaded) {
            return LoadedStateWidget(state: state, size: size, courseCover:  widget.courseCover,);
          }
          return const WaitingWidget();
        }));
  }

  void _handleSuccessCheckPurchase(BuildContext context, SuccessCheckPurchase state) {
    allowGo=false;
    if (!mounted) return; // Check if the widget is still mounted
    Future.delayed(const Duration(milliseconds: 300), () {
      goTo(context, (context) => SuccessPaymentPage());
    });
  }

}







