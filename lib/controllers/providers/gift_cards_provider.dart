import 'package:flutter/material.dart';

import '../../models/gift_card.dart';
import '../../style_sheet.dart';

class GiftCardsProvider extends ChangeNotifier {
  
  int _selectedIndex;
  List<GiftCard> _giftCards;

  GiftCardsProvider()
      : _selectedIndex = -1,
        _giftCards = [];
  List<DropdownMenuItem<GiftCard>> items = [
          GiftCard(name: "Apple Store", priceInDollar: 500),
          GiftCard(name: "iTunes", priceInDollar: 100),
          GiftCard(name: "Amazon", priceInDollar: 200),
          GiftCard(name: "EBay", priceInDollar: 300),
          GiftCard(name: "Google", priceInDollar: 400),
        ]
      .map<DropdownMenuItem<GiftCard>>((giftcard) => DropdownMenuItem(
              child: Text(
            giftcard.name,
            style: StyleSheet.black13w400,
          )))
      .toList();
  List<GiftCard> get giftCards => _giftCards;
  int get selectedIndex => _selectedIndex;

  void changeIndex(int selected) {
    _selectedIndex = selected;
    notifyListeners();
  }
}
