import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/providers/landing_screen_provider.dart';
import '../../../main.dart';
import 'bottom_nav_bar.dart';

class LandingPageScaffold extends StatelessWidget {
  const LandingPageScaffold();

  static const String route = "/landing";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LandingPageProvider>(
        create: (_) => LandingPageProvider(), child: _LandingPageScaffold());
  }
}

class _LandingPageScaffold extends StatelessWidget {
  const _LandingPageScaffold();

  @override
  Widget build(BuildContext context) {
    final LandingPageProvider state = Provider.of<LandingPageProvider>(context);
    final Size size = MediaQuery.of(context).size;
    final double pageHeight = size.height;
    final double pageWidth = size.width;
    return BlankPage.withoutSafeArea(
      child: Container(
        height: pageHeight,
        width: pageWidth,
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        color: state.background,
        child: Column(
          children: [
            Expanded(
              child: state.content,
            ),
            BottomNavBar(renderHeight: pageHeight * 0.08)
          ],
        ),
      ),
    );
  }
}
