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
  late Animation<double> _widthAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );

    _widthAnimation = Tween<double>(
      begin: 56.0,
      end: 172.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutCubic,
    ));

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.785398, // 45 degrees in radians (π/4)
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutBack,
    ));

    _slideAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.1, 0.8, curve: Curves.easeOutBack),
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.3, 1.0, curve: Curves.easeInOut),
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 0.9, curve: Curves.elasticOut),
    ));
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

  Widget _buildIconButton({
    required Widget icon,
    required VoidCallback? onPressed,
    required bool isVisible,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: isVisible ? onPressed : null,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(child: icon),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Container(
          width: _widthAnimation.value,
          height: 56,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Character button - slides from center to left
              Positioned(
                left: 28 - (20 * _slideAnimation.value),
                top: 8,
                child: Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Opacity(
                    opacity: _fadeAnimation.value,
                    child: IgnorePointer(
                      ignoring: _fadeAnimation.value < 0.7,
                      child: _buildIconButton(
                        icon: SizedBox(
                          width: 32,
                          height: 32,
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
                          widget.onAddCharacter?.call();
                          _toggleExpansion();
                        },
                        isVisible: _fadeAnimation.value > 0.7,
                      ),
                    ),
                  ),
                ),
              ),

              // Monster button - slides from center to middle
              Positioned(
                left: 28 + (38 * _slideAnimation.value),
                top: 8,
                child: Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Opacity(
                    opacity: _fadeAnimation.value,
                    child: IgnorePointer(
                      ignoring: _fadeAnimation.value < 0.7,
                      child: _buildIconButton(
                        icon: SizedBox(
                          width: 32,
                          height: 32,
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
                          widget.onAddMonster?.call();
                          _toggleExpansion();
                        },
                        isVisible: _fadeAnimation.value > 0.7,
                      ),
                    ),
                  ),
                ),
              ),

              // Main add button - always at the right and always on top
              Positioned(
                right: 8,
                top: 8,
                child: _buildIconButton(
                  icon: Transform.rotate(
                    angle: _rotationAnimation.value,
                    child: Icon(
                      Icons.add,
                      color: Theme.of(context).colorScheme.secondary,
                      size: 32,
                    ),
                  ),
                  onPressed: _toggleExpansion,
                  isVisible: true,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
