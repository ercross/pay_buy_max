import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../controllers/providers/current_service_provider.dart';
import 'sell_services.dart';
import 'package:provider/provider.dart';

import '../../../../../style_sheet.dart';
import 'buy_services.dart';

class HomeTab extends StatelessWidget {
  const HomeTab();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CurrentServiceProvider>(
      create: (_) => CurrentServiceProvider(),
      builder: (_, __) => _HomeTab(),
    );
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return Stack(
          children: [
            Positioned(
                top: constraints.maxHeight * 0.25,
                left: 0,
                width: constraints.maxWidth,
                height: constraints.maxHeight * 0.75,
                child: _ActiveService()),
            Positioned(
                top: constraints.maxHeight * 0.04,
                left: 0,
                width: constraints.maxWidth,
                height: constraints.maxHeight * 0.25,
                child: _UpperContent()),
          ],
        );
      },
    );
  }
}

class _UpperContent extends StatelessWidget {
  const _UpperContent();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return Column(
          children: [
            _Username(
                height: constraints.maxHeight * 0.28,
                width: constraints.maxWidth),
            SizedBox(
              height: constraints.maxHeight * 0.1,
            ),
            _ServicesBar(
                height: constraints.maxHeight * 0.62,
                width: constraints.maxWidth * 0.95),
          ],
        );
      },
    );
  }
}

enum Service { buy, sell, invest, training }

class _ServiceTab {
  final Widget icon;
  final String name;
  final Service service;

  _ServiceTab({required this.icon, required this.name, required this.service});
}

class _ActiveService extends StatelessWidget {
  const _ActiveService();

  @override
  Widget build(BuildContext context) {
    final CurrentServiceProvider state =
        Provider.of<CurrentServiceProvider>(context);
    Color background = Colors.white;
    Widget activeTab = BuyTab();
    switch (state.activeService) {
      case Service.buy:
        activeTab = BuyTab();
        break;
      case Service.sell:
        activeTab = HowToSell();
        background = Color(0xFFF7E9D3);
        break;
      case Service.invest:
        activeTab = _InvestTab();
        break;
      case Service.training:
        activeTab = _TrainingTab();
        break;
    }
    return LayoutBuilder(
      builder: (_, constraints) => Container(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              color: background),
          child: activeTab),
    );
  }
}

class _InvestTab extends StatelessWidget {
  const _InvestTab();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: null,
    );
  }
}

class _TrainingTab extends StatelessWidget {
  const _TrainingTab();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: null,
    );
  }
}

class _ServicesBar extends StatelessWidget {
  final double height;
  final double width;
  const _ServicesBar({required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    final CurrentServiceProvider state =
        Provider.of<CurrentServiceProvider>(context);
    final double size = 27;
    final _ServiceTab buy = _ServiceTab(
        icon: FaIcon(
          FontAwesomeIcons.cartPlus,
          color:
              state.activeService == Service.buy ? Colors.white : Colors.black,
          size: size,
        ),
        name: "Buy",
        service: Service.buy);

    final _ServiceTab sell = _ServiceTab(
        icon: FaIcon(
          FontAwesomeIcons.moneyCheckAlt,
          color: state.activeService == Service.sell
              ? Colors.white
              : Colors.black87,
          size: size,
        ),
        name: "Sell",
        service: Service.sell);

    final _ServiceTab invest = _ServiceTab(
        icon: FaIcon(
          FontAwesomeIcons.chartLine,
          color: state.activeService == Service.invest
              ? Colors.white
              : Colors.black87,
          size: size,
        ),
        name: "Invest",
        service: Service.invest);

    final _ServiceTab training = _ServiceTab(
        icon: FaIcon(
          FontAwesomeIcons.ggCircle,
          color: state.activeService == Service.training
              ? Colors.white
              : Colors.black87,
          size: size,
        ),
        name: "Training",
        service: Service.training);

    final double serviceHeight = height * 0.8;
    final double serviceWidth = width * 0.2;
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: StyleSheet.background),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _Service(tab: buy, height: serviceHeight, width: serviceWidth),
          _Service(tab: sell, height: serviceHeight, width: serviceWidth),
          _Service(tab: invest, height: serviceHeight, width: serviceWidth),
          _Service(tab: training, height: serviceHeight, width: serviceWidth),
        ],
      ),
    );
  }
}

class _Service extends StatelessWidget {
  final double height;
  final double width;
  final _ServiceTab tab;
  const _Service(
      {required this.height, required this.width, required this.tab});

  @override
  Widget build(BuildContext context) {
    final CurrentServiceProvider state =
        Provider.of<CurrentServiceProvider>(context);
    return GestureDetector(
      onTap: () => state.changeActive(tab.service),
      child: Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: state.activeService == tab.service
                ? StyleSheet.primaryColor
                : Colors.white,
            boxShadow: kElevationToShadow[2]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            tab.icon,
            Text(tab.name,
                textAlign: TextAlign.center,
                style: StyleSheet.white13w400.copyWith(
                    color: state.activeService == tab.service
                        ? Colors.white
                        : Colors.black87))
          ],
        ),
      ),
    );
  }
}

class _Username extends StatelessWidget {
  final double height;
  final double width;

  const _Username({required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        height: height,
        width: width,
        alignment: Alignment.centerLeft,
        child: RichText(
          text: TextSpan(
              text: "Good Morning\n",
              style: StyleSheet.black13w400,
              children: [
                TextSpan(
                    text: "username@gmail.com",
                    style: StyleSheet.black20w500
                        .copyWith(color: StyleSheet.primaryColor))
              ]),
        ));
  }
}
