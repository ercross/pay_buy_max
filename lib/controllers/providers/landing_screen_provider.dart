import 'package:flutter/material.dart';

import '../../style_sheet.dart';
import '../../views/screens/landing_screen_scaffold/bottom_nav_bar.dart';
import '../../views/screens/landing_screen_scaffold/tabs/account_tab.dart';
import '../../views/screens/landing_screen_scaffold/tabs/transactions_tab/transactions_tab.dart';
import '../../views/screens/landing_screen_scaffold/tabs/home_tab/home_tab.dart';
import '../../views/screens/landing_screen_scaffold/tabs/wallet_tab/wallet_tab.dart';

class LandingPageProvider extends ChangeNotifier {
  Widget _content;
  NavBarTab _tabOnDisplay;
  Color _background;

  LandingPageProvider()
      : _background = StyleSheet.background,
        _tabOnDisplay = NavBarTab.home,
        _content = HomeTab();

  NavBarTab get tabOnDisplay => _tabOnDisplay;
  Widget get content => _content;
  Color get background => _background;

  void changeTabOnDisplay({required NavBarTab to}) {
    _tabOnDisplay = to;
    _setContent();
    notifyListeners();
  }

  void _setContent() {
    switch (_tabOnDisplay) {
      case NavBarTab.home:
        _content = HomeTab();
        break;
      case NavBarTab.wallet:
        _content = WalletTab();
        break;
      case NavBarTab.transactions:
        _content = TransactionsTab();
        break;
      case NavBarTab.account:
        _content = AccountTab();
        break;
    }
  }
}
