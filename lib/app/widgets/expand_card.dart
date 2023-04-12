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
    widget.items.forEach((element) {
      debugPrint('==element=$element');
    });
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
    super.key,
    required this.image,
    required this.animation,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  State<AnimatedCardItem> createState() => _AnimatedCardItemState();
}

class _AnimatedCardItemState extends State<AnimatedCardItem> {
  bool shouldRebuild = false;

  @override
  void didUpdateWidget(covariant AnimatedCardItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isExpanded != widget.isExpanded) {
      shouldRebuild = true;
    } else {
      shouldRebuild = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    const double collapsedWidth = 70;
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: widget.animation,
        builder: (context, child) {
          double value = shouldRebuild
              ? widget.isExpanded
                  ? widget.animation.value
                  : 1 - widget.animation.value
              : widget.isExpanded
                  ? 1
                  : 0;

          double w = Get.size.width * 0.5;

          return Container(
            width: collapsedWidth + value * w,
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
