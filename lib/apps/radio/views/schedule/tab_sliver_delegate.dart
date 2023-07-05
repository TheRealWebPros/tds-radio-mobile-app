import 'package:flutter/material.dart';

class TabSliverDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;
  TabSliverDelegate(
    this.tabBar,
  );

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
        decoration: BoxDecoration(
          color: isDark ? Colors.grey.shade900 : Colors.blue.shade50,
        ),
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: tabBar);
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
