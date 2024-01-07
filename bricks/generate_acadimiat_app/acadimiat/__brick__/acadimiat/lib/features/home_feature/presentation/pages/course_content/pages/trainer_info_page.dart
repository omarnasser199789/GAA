import 'package:acadmiat/Theme/style.dart';
import 'package:acadmiat/core/widgets/cached_net_work_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import '../../../../../../core/globals.dart';
import '../../../../../../core/widgets/back_button.dart';
import '../../../../data/models/card_by_id_model.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class TrainerInfoPage extends StatefulWidget {
  const TrainerInfoPage({super.key, required this.trainer,required this.image,this.index});
  final Trainer trainer;
  final String image;
  final int ? index;

  @override
  State<TrainerInfoPage> createState() => _TrainerInfoPageState();
}

class _TrainerInfoPageState extends State<TrainerInfoPage> {
  Uint8List bytes=Uint8List(0);
  bool firstOne=true;

  @override
  Widget build(BuildContext context) {
if(firstOne) {
  firstOne=false;
  removeBG(widget.trainer.trainerAvatar);
}
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      height: 250,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.blue,
                              Theme.of(context).scaffoldBackgroundColor,
                            ],
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 35),
                      child:   Hero(
                        tag:(widget.index!=null)?"TrainerHeroTag${widget.index}":"TrainerHeroTag",
                        child: SizedBox(
                          width: 140,
                          height: 140,
                          child:  CachedNetWorkImage(borderRadius: BorderRadius.circular(0),
                              boxFit: BoxFit.fill,
                              url:widget.image),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          constraints:  const BoxConstraints(minWidth: 140),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 17,right: 17,top: 9,bottom: 9),
                            child: Text(
                              widget.trainer.trainerName,
                              style: blackBoldTextStyle(fontSize: 15, context: context),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                SafeArea(child: BackButtonWidget()),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20, left: 17, right: 17,bottom: 20),
              child: HtmlWidget(
                "<div style='background-color:${Theme.of(context).scaffoldBackgroundColor} !important; font-size: 12px; line-height:$lineSpace;font-family:${"taleeq-bold"} !important; ' color:${Theme.of(context).primaryColor} !important'>${widget.trainer.trainerInfo.replaceAll("background-color", "").replaceAll("color", "").replaceAll("font-family", "")..replaceAll("font-size", "")}</div >",
                customWidgetBuilder: (element) {
                  return null;
                },
                // webView: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> removeBG(String imageUrl) async {
    if (kDebugMode) {
      print(imageUrl);
    }
    Uint8List by = (await NetworkAssetBundle(Uri.parse(imageUrl)).load(imageUrl)).buffer.asUint8List();
    bytes=(await removeWhiteBackground(by))!;
    if (!mounted) {
      return;
    }
    setState(() {

    });

  }

  Future<Uint8List?> removeWhiteBackground(Uint8List bytes) async {
    img.Image? image = img.decodeImage(bytes);
    img.Image? transparentImage = await colorTransparent(image!, 255, 255, 255);
    var newPng = img.encodePng(transparentImage);
    return newPng;
  }

  Future<img.Image> colorTransparent(img.Image src, int red, int green, int blue) async {
    var pixels = src.getBytes();
    for (int i = 0, len = pixels.length; i < len; i += 4) {
      if(pixels[i] ==255 && pixels[i+1] ==255 && pixels[i+2] ==255) {
        i++;
      }
    }
    return src;
  }
}
