import 'package:flutter/material.dart';

class AnimatedFab extends StatefulWidget {
  final VoidCallback? onAddCharacter;
  final VoidCallback? onAddMonster;

  const AnimatedFab({
    super.key,
    this.onAddCharacter,
    this.onAddMonster,
  });

  @override
  State<AnimatedFab> createState() => _AnimatedFabState();
}

class _AnimatedFabState extends State<AnimatedFab>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      width: _isExpanded ? 180 : 56,
      height: 56,
      decoration: BoxDecoration(
        color: Theme.of(context).floatingActionButtonTheme.backgroundColor ??
            Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(28),
      ),
      child: _isExpanded
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.person_add, color: Colors.white),
                  onPressed: () {
                    _toggleExpansion();
                    widget.onAddCharacter?.call();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.add_card_sharp, color: Colors.white),
                  onPressed: () {
                    _toggleExpansion();
                    widget.onAddMonster?.call();
                  },
                ),
                Transform.rotate(
                  angle: 3.14159 / 4, // 45 degrees (X)
                  child: IconButton(
                    icon: const Icon(Icons.add, color: Colors.white),
                    onPressed: _toggleExpansion,
                  ),
                ),
              ],
            )
          : Center(
              child: IconButton(
                icon: const Icon(Icons.add, color: Colors.white),
                onPressed: _toggleExpansion,
              ),
            ),
    );
  }
}
