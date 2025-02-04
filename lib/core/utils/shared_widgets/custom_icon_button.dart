import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/app_color.dart';

class CustomIconButton extends StatefulWidget {
  final VoidCallback onTap;
  final double? size;
  final Color? color;
  final String icon;
  final Color? iconColor;
  final Color ? borderColor;
  final bool ?isCircle;
  const CustomIconButton({
    required this.onTap,
    required this.icon,
    this.size,
    this.color,
    this.iconColor,
    Key? key, this.borderColor, this.isCircle=true,
  }) : super(key: key);

  @override
  State<CustomIconButton> createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Duration _animationDuration = const Duration(milliseconds: 300);
  final Tween<double> _tween = Tween<double>(begin: 1.0, end: 0.95);
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: _animationDuration,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        _controller.forward().then((_) {
          _controller.reverse();
        });
        widget.onTap();
      },
      child: ScaleTransition(
        scale: _tween.animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOut,
            reverseCurve: Curves.easeIn,
          ),
        ),
        child: Container(
          height: widget.size ?? 40.h,
          alignment: Alignment.center,
          width: widget.size ?? 40.w,
          padding: EdgeInsets.all(5.h),
          decoration: BoxDecoration(
            color: widget.color ?? kLightGrey,
            shape: widget.isCircle == true ?BoxShape.circle:BoxShape.rectangle,
            borderRadius: widget.isCircle == true ? null :BorderRadius.circular(10.r),
            border: Border.all(color: widget.borderColor??Colors.transparent)
          ),
          child: SvgPicture.asset(
            widget.icon,
            colorFilter: ColorFilter.mode(
              widget.iconColor ??kPrimaryColor,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
