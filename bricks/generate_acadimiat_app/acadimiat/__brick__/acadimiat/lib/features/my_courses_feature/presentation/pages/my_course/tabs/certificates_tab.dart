import 'package:acadmiat/core/widgets/cached_net_work_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../../Locale/locale.dart';
import '../../../../../../../Theme/style.dart';
import '../../../../../../core/util/assets_manager.dart';

class CertificatesTab extends StatefulWidget {
  const CertificatesTab({super.key});

  @override
  State<CertificatesTab> createState() => _CertificatesTabState();
}

class _CertificatesTabState extends State<CertificatesTab> {
  @override
  Widget build(BuildContext context) {
    
    var locale = AppLocalizations.of(context)!;
    return  Padding(
      padding: const EdgeInsets.only(left: 17,right: 17,top: 13),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12)
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  SizedBox(
                    height: 296,
                    child: CachedNetWorkImage(borderRadius: BorderRadius.circular(12),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12,left: 5,right: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          ImgAssets.eayIcon,
                          color: iconsColor,
                        ),
                      const SizedBox(width: 8,),
                      Text(locale.show!,style: blackBoldTextStyle(context: context,fontSize: 12),),
                        const SizedBox(width: 33,),
                        SvgPicture.asset(
                          ImgAssets.download,
                          color: iconsColor,
                        ),
                        const SizedBox(width: 8,),
                      Text(locale.download!,style: blackBoldTextStyle(context: context,fontSize: 12),),
                        const SizedBox(width: 33,),
                        SvgPicture.asset(
                          ImgAssets.share,
                          color: iconsColor,
                        ),
                        const SizedBox(width: 8,),
                      Text(locale.share!,style: blackBoldTextStyle(context: context,fontSize: 12),),
                    ],),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
