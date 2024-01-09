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
  const TrainerInfoPage({
    Key? key,
    required this.trainer,
    required this.image,
    this.index,
  }) : super(key: key);

  final Trainer trainer;
  final String image;
  final int? index;

  @override
  State<TrainerInfoPage> createState() => _TrainerInfoPageState();
}

class _TrainerInfoPageState extends State<TrainerInfoPage> {
  /// Define variables
  Uint8List bytes = Uint8List(0);
  bool firstOne = true;

  @override
  void initState() {
    super.initState();
    /// Call method to remove background only once when the widget is first created
    if (firstOne) {
      firstOne = false;
      removeBG(widget.trainer.trainerAvatar);
    }
  }

  @override
  Widget build(BuildContext context) {
    /// Build the widget tree
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Stack for background and back button
            Stack(
              alignment: Alignment.topRight,
              children: [
                /// Background container
                _buildBackgroundContainer(),
                /// Back button
                SafeArea(child: BackButtonWidget()),
              ],
            ),
            /// Trainer information
            _buildTrainerInfo(),
          ],
        ),
      ),
    );
  }

  /// Method to build the background container
  Widget _buildBackgroundContainer() {
    return Stack(
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
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 35),
          child: Hero(
            tag: (widget.index != null)
                ? "TrainerHeroTag${widget.index}"
                : "TrainerHeroTag",
            child: SizedBox(
              width: 140,
              height: 140,
              child: CachedNetWorkImage(
                borderRadius: BorderRadius.circular(0),
                boxFit: BoxFit.fill,
                url: widget.image,
              ),
            ),
          ),
        ),
        _buildTrainerNameContainer(),
      ],
    );
  }

  /// Method to build the trainer name container
  Widget _buildTrainerNameContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          constraints: const BoxConstraints(minWidth: 140),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 9),
            child: Text(
              widget.trainer.trainerName,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Method to build the trainer information
  Widget _buildTrainerInfo() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(17, 20, 17, 20),
      child: HtmlWidget(
        "<div style='background-color:${Theme.of(context).scaffoldBackgroundColor} !important; font-size: 12px; line-height:$lineSpace;font-family:${"taleeq-bold"} !important; ' color:${Theme.of(context).primaryColor} !important'>${widget.trainer.trainerInfo.replaceAll("background-color", "").replaceAll("color", "").replaceAll("font-family", "")..replaceAll("font-size", "")}</div >",
        customWidgetBuilder: (element) {
          return null;
        },
        // webView: true,
      ),
    );
  }

  /// Method to remove background
  Future<void> removeBG(String imageUrl) async {
    if (kDebugMode) {
      print(imageUrl);
    }
    final by = (await NetworkAssetBundle(Uri.parse(imageUrl)).load(imageUrl))
        .buffer
        .asUint8List();
    bytes = (await removeWhiteBackground(by))!;
    if (!mounted) {
      return;
    }
    setState(() {});
  }

  /// Method to remove white background
  Future<Uint8List?> removeWhiteBackground(Uint8List bytes) async {
    final image = img.decodeImage(bytes);
    final transparentImage = await colorTransparent(image!, 255, 255, 255);
    final newPng = img.encodePng(transparentImage);
    return newPng;
  }

  /// Method to make specific color transparent in the image
  Future<img.Image> colorTransparent(
      img.Image src, int red, int green, int blue) async {
    final pixels = src.getBytes();
    for (int i = 0, len = pixels.length; i < len; i += 4) {
      if (pixels[i] == 255 &&
          pixels[i + 1] == 255 &&
          pixels[i + 2] == 255) {
        i++;
      }
    }
    return src;
  }
}


