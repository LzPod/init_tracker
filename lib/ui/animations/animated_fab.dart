import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
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
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      child: _isExpanded
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: SizedBox(
                    width: 32,
                    child: SvgPicture.asset(
                      'assets/icon/adventurer_icon.svg',
                      width: 32,
                      height: 32,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.secondary,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  onPressed: () {
                    _toggleExpansion();
                    widget.onAddCharacter?.call();
                  },
                ),
                IconButton(
                  icon: SizedBox(
                    width: 32,
                    child: SvgPicture.asset(
                      'assets/icon/monster_icon.svg',
                      width: 32,
                      height: 32,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.secondary,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  onPressed: () {
                    _toggleExpansion();
                    widget.onAddMonster?.call();
                  },
                ),
                Transform.rotate(
                  angle: 3.14159 / 4,
                  child: IconButton(
                    icon: SizedBox(
                      width: 32,
                      child: Icon(
                        Icons.add,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 32,
                      ),
                    ),
                    onPressed: _toggleExpansion,
                  ),
                ),
              ],
            )
          : Center(
              child: IconButton(
                icon: SizedBox(
                  width: 32,
                  child: Icon(
                    Icons.add,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 32,
                  ),
                ),
                onPressed: _toggleExpansion,
              ),
            ),
    );
  }
}
