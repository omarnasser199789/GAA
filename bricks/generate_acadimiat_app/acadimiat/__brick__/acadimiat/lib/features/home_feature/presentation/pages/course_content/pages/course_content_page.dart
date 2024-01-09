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
  const CourseContentPage({
    Key? key,
    required this.cardId,
    required this.productType,
    required this.courseCover,
  }) : super(key: key);

  final int cardId;
  final int productType;
  final String courseCover;

  @override
  State<CourseContentPage> createState() => _CourseContentPageState();
}

class _CourseContentPageState extends State<CourseContentPage> {
  final controller = PageController(initialPage: 0);
  bool allowGetCard = true;
  bool allowGo = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (BuildContext context) => sl<HomeBloc>(),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          /// Debug log to print the state for debugging purposes
          if (kDebugMode) {
            print("State: $state");
          }

          /// Fetch card details if the state is empty and fetching is allowed
          if (state is Empty && allowGetCard) {
            allowGetCard = false; // Prevent further fetch requests
            BlocProvider.of<HomeBloc>(context).add(GetCardByIdEvent(id: widget.cardId));
          }
          /// Show error state if the state is an error
          else if (state is Error) {
            return _buildErrorState(context);
          }
          /// Handle success check purchase event
          else if (state is SuccessCheckPurchase && allowGo) {
            _handleSuccessCheckPurchase(context, state);
          }
          /// Show loaded state with card details if available
          else if (state is CardByIdLoaded) {
            return LoadedStateWidget(state: state, size: size, courseCover: widget.courseCover);
          }

          /// Show waiting widget if none of the above conditions are met
          return const WaitingWidget();
        },
      ),
    );
  }

  /// Build the error state widget
  Widget _buildErrorState(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget("", context, true, null, null),
      body: EmptyStateWidget(
        svg: ImgAssets.error,
        text1: "عذرا! حدثت مشكلة غير متوقعة",
        text3: "حدث الان",
        onTap: () async {
          BlocProvider.of<HomeBloc>(context).add(GetCardByIdEvent(id: widget.cardId));
        },
      ),
    );
  }

  /// Handle success check purchase event
  void _handleSuccessCheckPurchase(BuildContext context, SuccessCheckPurchase state) {
    allowGo = false; // Prevent multiple navigations
    if (!mounted) return; // Check if the widget is still mounted
    /// Delay navigation to the success payment page for smooth transition
    Future.delayed(const Duration(milliseconds: 300), () {
      goTo(context, (context) => SuccessPaymentPage());
    });
  }
}





