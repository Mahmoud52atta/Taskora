import 'package:flutter/material.dart';

class AdaptiveLayout extends StatelessWidget {
  const AdaptiveLayout(
      {super.key,
      required this.mobileLayOut,
      required this.tabletLayOut,
      required this.desctobLayOut});
  final WidgetBuilder mobileLayOut, tabletLayOut, desctobLayOut;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      if (constrains.maxWidth < 800) {
        return mobileLayOut(context);
      } else if (constrains.maxWidth < 1200) {
        return tabletLayOut(context);
      } else {
        return desctobLayOut(context);
      }
    });
  }
}
