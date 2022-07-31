import 'package:flutter/cupertino.dart';
import 'package:flutter_mvvm_test/src/views/home/tab_item.dart';

class CupertinoHomeScaffold extends StatelessWidget {
  const CupertinoHomeScaffold({
    Key? key,
    required this.currentTab,
    required this.onSelectedTab,
    required this.widgetBuilders,
    required this.navigatorKeys,
  }) : super(key: key);
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectedTab;
  final Map<TabItem, WidgetBuilder> widgetBuilders;
  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          _buildItem(TabItem.home),
          // _buildItem(TabItem.entries),
          _buildItem(TabItem.account)
        ],
        onTap: (int index) {
          // print(index);
        },
      ),
      tabBuilder: (BuildContext context, int index) {
        final item = TabItem.values[index];
        return CupertinoTabView(
          builder: (context) => widgetBuilders[item]!(context),
        );
      },
    );
  }

//this depending on map and
  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    final TabItemData? itemData = TabItemData.allTabs[tabItem];
    return BottomNavigationBarItem(
      icon: Icon(
        itemData!.icon,
      ),
      label: itemData.title,
    );
  }
}
