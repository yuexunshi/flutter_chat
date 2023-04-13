import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpandingCards extends StatefulWidget {
  final double height;
  final List<String> items;

  const ExpandingCards({
    super.key,
    required this.height,
    required this.items,
  });

  @override
  State<ExpandingCards> createState() => _ExpandingCardsState();
}

class _ExpandingCardsState extends State<ExpandingCards>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;

  late final AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    final CurvedAnimation curve =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _animation = Tween(begin: 0.0, end: 1.0).animate(curve);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: ListView.builder(
        itemCount: widget.items.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 56),
        addRepaintBoundaries: true,
        itemBuilder: (context, index) {
          final item = widget.items[index % widget.items.length];
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: AnimatedCardItem(
              key: ValueKey(index),
              image: item,
              isExpanded: _selectedIndex == index,
              animation: _animation,
              onTap: () => onExpand(_selectedIndex == index ? -1 : index),
            ),
          );
        },
      ),
    );
  }

  void onExpand(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class AnimatedCardItem extends StatefulWidget {
  final String image;
  final Animation<double> animation;
  final bool isExpanded;
  final VoidCallback onTap;

  const AnimatedCardItem({
    Key? key, // 使用Key?类型
    required this.image,
    required this.animation,
    required this.isExpanded,
    required this.onTap,
  }) : super(key: key); // 使用super关键字

  @override
  State<AnimatedCardItem> createState() => _AnimatedCardItemState();
}

class _AnimatedCardItemState extends State<AnimatedCardItem> {
  static const double collapsedWidth = 70; // 将常量提取到类成员变量中
  late double screenWidth; // 将Get.size.width提取到类成员变量中

  @override
  void initState() {
    super.initState();
    screenWidth = Get.size.width * 0.5; // 初始化屏幕宽度
  }

  @override
  void didUpdateWidget(covariant AnimatedCardItem oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: widget.animation,
        builder: (context, child) {
          double value =
          widget.isExpanded ? widget.animation.value : 1 - widget.animation.value;
          return Container(
            width: collapsedWidth + value * screenWidth,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(collapsedWidth / 2),
            ),
            child: Image(
              image: NetworkImage(widget.image),
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
