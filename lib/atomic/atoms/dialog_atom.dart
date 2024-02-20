import 'package:eco_toss/atomic/atoms/color_atom.dart';
import 'package:flutter/material.dart';

class DialogAtom extends StatelessWidget {
  const DialogAtom({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FractionallySizedBox(
        widthFactor: 0.8,
        heightFactor: 0.3,
        child: Container(
          decoration: BoxDecoration(
            color: ColorAtom.timberwolf,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: ColorAtom.payneGrey.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: child,
          ),
        ),
      ),
    );
  }
}
