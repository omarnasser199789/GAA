import 'package:flutter/material.dart';
import '../../../../../Theme/style.dart';

class OptionWidget extends StatelessWidget {
  const OptionWidget(
      {super.key, required this.onTap, required this.title, this.text2});
  final String title;

  final Function() onTap;
  final String? text2;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.topCenter,
        color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.1),
        child: Padding(
          padding:
          const EdgeInsets.only(bottom: 16, top: 16, left: 17, right: 17),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: blackBoldTextStyle(context: context, fontSize: 13),
              ),
              Row(
                children: [
                  if (text2 != null)
                    Row(
                      children: [
                        Text(text2!, style: blackBoldTextStyle(fontSize: 13, context: context),),
                        const SizedBox(width: 8),
                      ],
                    ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}