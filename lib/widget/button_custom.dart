import 'package:flutter/material.dart';
import 'package:hotelio/config/app_colors.dart';

class ButtonCustom extends StatelessWidget {
  const ButtonCustom({
    Key? key,
    required this.label,
    required this.onTap,
    this.isShadow = true,
    this.isExpand,
  }) : super(key: key);
  final String label;
  final Function onTap;
  final bool isShadow;
  final bool? isExpand;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          Align(
            alignment: const Alignment(0, 0.7),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: isShadow
                    ? [
                        const BoxShadow(
                          color: AppColor.primary,
                          offset: Offset(0, 5),
                          blurRadius: 20,
                        ),
                      ]
                    : null,
              ),
              width: isExpand == null
                  ? null
                  : isExpand!
                      ? double.infinity
                      : null,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(label),
            ),
          ),
          Align(
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () => onTap(),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColor.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                width: isExpand == null
                    ? null
                    : isExpand!
                        ? double.infinity
                        : null,
                padding: const EdgeInsets.symmetric(
                  horizontal: 36,
                  vertical: 12,
                ),
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
