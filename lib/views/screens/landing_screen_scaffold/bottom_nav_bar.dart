import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/providers/landing_screen_provider.dart';
import '../../../style_sheet.dart';

enum NavBarTab { home, wallet, transactions, account }

class _NavBarItem {
  final NavBarTab tab;
  final IconData icon;
  final String tabName;

  const _NavBarItem({
    required this.tab,
    required this.icon,
    required this.tabName,
  });
}

class BottomNavBar extends StatelessWidget {
  final double renderHeight;
  const BottomNavBar({required this.renderHeight});

  static const _NavBarItem _home = _NavBarItem(
    tab: NavBarTab.home,
    icon: Icons.home,
    tabName: "Home",
  );

  static const _NavBarItem _wallet = _NavBarItem(
    tab: NavBarTab.wallet,
    icon: Icons.account_balance_wallet,
    tabName: "Wallet",
  );

  static const _NavBarItem _transactions = _NavBarItem(
    tab: NavBarTab.transactions,
    icon: Icons.menu_book_rounded,
    tabName: "Transactions",
  );

  static const _NavBarItem _account = _NavBarItem(
    tab: NavBarTab.account,
    icon: Icons.person,
    tabName: "Account",
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 5, left: 5, bottom: 10),
      height: renderHeight,
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _Tab(_home),
          _Tab(_wallet),
          _Tab(_transactions),
          _Tab(_account)
        ],
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  final _NavBarItem navBarItem;
  const _Tab(this.navBarItem);

  @override
  Widget build(BuildContext context) {
    const double sidePadding = 10.00;
    final LandingPageProvider state = Provider.of(context);
    final Color color = _isActive(state.tabOnDisplay)
        ? StyleSheet.primaryColor
        : CupertinoColors.systemGrey3;
    return GestureDetector(
        onTap: () => state.changeTabOnDisplay(to: navBarItem.tab),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                right: sidePadding,
                left: sidePadding,
              ),
              child: Icon(navBarItem.icon, color: color, size: 25),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(right: sidePadding, left: sidePadding),
              child: Text(navBarItem.tabName,
                  textAlign: TextAlign.center,
                  style: StyleSheet.black12w300.copyWith(color: color)),
            )
          ],
        ));
  }

  bool _isActive(NavBarTab active) {
    return navBarItem.tab == active;
  }
}
