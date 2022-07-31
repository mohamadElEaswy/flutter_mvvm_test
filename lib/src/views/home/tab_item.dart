import 'package:flutter/material.dart';

enum TabItem { home, account }

//this class can save bottom tab item data (jobs, intries, account) icons, and lables
// inside this map to represent it easier
class TabItemData {
  const TabItemData({required this.title, required this.icon});
  final String title;
  final IconData icon;

  static const Map<TabItem, TabItemData> allTabs = {
    TabItem.home: TabItemData(title: 'Home', icon: Icons.home_filled),
    // TabItem.entries: TabItemData(title: 'Entries', icon: Icons.view_headline),
    TabItem.account: TabItemData(title: 'Account', icon: Icons.person),
  };
}
