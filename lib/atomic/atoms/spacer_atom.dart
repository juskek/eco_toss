import 'package:flutter/material.dart';

class SpacerAtom extends StatelessWidget {
  const SpacerAtom.small({super.key})
      : size = 10,
        flex = null;
  const SpacerAtom.medium({super.key})
      : size = 20,
        flex = null;
  const SpacerAtom.large({super.key})
      : size = 30,
        flex = null;
  const SpacerAtom.flex(this.flex, {super.key}) : size = null;
  const SpacerAtom.expanded({super.key})
      : size = null,
        flex = null;

  final double? size;
  final int? flex;
  @override
  Widget build(BuildContext context) {
    if (flex != null) {
      return Flexible(
        flex: flex!,
        child: const SizedBox(
          height: 1,
          width: 1,
        ),
      );
    }

    if (size != null) {
      return SizedBox(height: size, width: size);
    }
    return const Expanded(child: SizedBox(height: 1, width: 1));
  }
}
