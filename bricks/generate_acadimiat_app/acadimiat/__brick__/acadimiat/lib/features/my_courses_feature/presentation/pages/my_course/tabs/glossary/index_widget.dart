import 'package:flutter/material.dart';
import '../../../../../../../../Theme/style.dart';

class IndexWidget extends StatelessWidget {
  const IndexWidget({super.key, required this.litter});
  final String litter;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        width: 32,
        height: 32,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
              bottomRight: Radius.circular(50),
            )),
        child: Text(
          litter,
          style: blackBoldTextStyle(
            fontSize: 17,
            context: context,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}