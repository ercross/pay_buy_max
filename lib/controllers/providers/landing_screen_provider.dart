import 'package:flutter/material.dart';
import 'package:pay_buy_max/views/screens/home_page.dart';
import '../../views/screens/landing_screen_scaffold/bottom_nav_bar.dart';
import '../../views/screens/landing_screen_scaffold/tabs/account_tab.dart';
import '../../views/screens/landing_screen_scaffold/tabs/transactions_tab/transactions_tab.dart';
import '../../views/screens/landing_screen_scaffold/tabs/home_tab/home_tab.dart';
import '../../views/screens/landing_screen_scaffold/tabs/wallet_tab/wallet_tab.dart';

class LandingPageProvider extends ChangeNotifier {
  Widget _content;
  NavBarTab _tabOnDisplay;

  LandingPageProvider()
      : _tabOnDisplay = NavBarTab.home,
        _content = HomePage();

  NavBarTab get tabOnDisplay => _tabOnDisplay;
  Widget get content => _content;

  void changeTabOnDisplay({required NavBarTab to}) {
    _tabOnDisplay = to;
    _setContent();
    notifyListeners();
  }

  void _setContent() {
    switch (_tabOnDisplay) {
      case NavBarTab.home:
        _content = HomePage();
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
