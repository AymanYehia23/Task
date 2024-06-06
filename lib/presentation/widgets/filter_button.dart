import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({
    super.key,
    required this.label,
    required this.isActive,
    required this.onTap,
  });
  final String label;
  final bool isActive;

  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 2.w),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 20.w),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            color: isActive
                ? Theme.of(context).primaryColor
                : Theme.of(context).primaryColor.withOpacity(0.1),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.white : Theme.of(context).primaryColor,
              fontSize: isActive ? 13.sp : 12.sp,
            ),
          ),
        ),
      ),
    );
  }
}
