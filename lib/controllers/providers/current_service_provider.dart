import 'package:flutter/material.dart';
import '../../views/screens/landing_screen_scaffold/tabs/home_tab/home_tab.dart';

class CurrentServiceProvider extends ChangeNotifier {
  Service _activeService;

  CurrentServiceProvider() : _activeService = Service.buy;

  Service get activeService => _activeService;

  void changeActive(Service service) {
    _activeService = service;
    notifyListeners();
  }
}
