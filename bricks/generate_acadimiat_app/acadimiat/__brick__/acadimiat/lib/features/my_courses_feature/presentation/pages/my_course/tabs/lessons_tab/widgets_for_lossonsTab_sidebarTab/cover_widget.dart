import 'package:flutter/material.dart';

import '../../../../../../../../core/widgets/cached_net_work_image.dart';

class CoverWidget extends StatelessWidget {
  const CoverWidget({Key? key,required this.coverUrl}) : super(key: key);

  final String coverUrl;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      bottom: false,
      child: Column(
        mainAxisAlignment:
        MainAxisAlignment.start,
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [

          SizedBox(
            width: double.infinity,
            height: 200,
            child: CachedNetWorkImage(
              borderRadius:
              BorderRadius.circular(0),
              url: coverUrl,
              boxFit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}
