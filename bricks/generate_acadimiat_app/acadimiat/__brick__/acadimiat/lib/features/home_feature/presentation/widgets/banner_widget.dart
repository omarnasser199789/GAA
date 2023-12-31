import 'package:acadmiat/core/functions.dart';
import 'package:acadmiat/features/home_feature/presentation/bloc/home_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/cached_net_work_image.dart';
import '../../../../injection_container.dart';
import '../bloc/home_event.dart';
import 'package:url_launcher/url_launcher.dart';
import '../bloc/home_state.dart';
import 'package:shimmer/shimmer.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({Key? key}) : super(key: key);

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return BlocProvider(
        create: (BuildContext context) => sl<HomeBloc>(),
        child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          if (kDebugMode) {
            print("Banners State:$state");
          }
          if (state is Empty) {
            BlocProvider.of<HomeBloc>(context).add(GetBannersEvent());
          }

          if (state is SuccessGetBanners) {
            return SizedBox(
              height: size.height*0.3,//230,
              width: double.infinity,
              child: CarouselSlider(
                items: state.banners
                    .map((e) => GestureDetector(
                  onTap: () async {
                    if (await canLaunch(e.linkUrl)) {
                      await launch(e.linkUrl);
                    } else {
                      showMessage(message: "حدث خطا اثناء تنفيذ العملية", context: context);
                    }
                    setState(() {});
                    },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CachedNetWorkImage(
                      borderRadius: BorderRadius.circular(0),
                      url: e.imageUrl,
                      boxFit: BoxFit.contain,
                    ),
                  ),
                ),
                ).toList(),
                options: CarouselOptions(
                  autoPlay: true,
                  enableInfiniteScroll: false,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {},
                ),
              ),
            );
          }

          return Shimmer.fromColors(
            baseColor: Theme.of(context).cardColor,
            highlightColor:
                const Color.fromRGBO(119, 118, 118, 0.5490196078431373),
            child: Container(
              height: size.height*0.3,
              width: double.infinity,
              color: Theme.of(context).cardColor,
            ),
          );
        }));
  }
}
