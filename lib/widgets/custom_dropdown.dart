import 'package:flutter/material.dart';

class CustomDropDown<T> extends StatefulWidget {
  final List<DropDownItem> items;
  final T value;
  final Function(dynamic) onChange;

  const CustomDropDown(
      {Key? key,
      required this.items,
      required this.value,
      required this.onChange})
      : super(key: key);

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown>
    with SingleTickerProviderStateMixin {
  //Key to find the position
  GlobalKey positionKey = LabeledGlobalKey("position_key");

  late AnimationController controller;
  late Animation<Offset> offset;
  // late Animation<double> scale;
  final animationDuration = const Duration(milliseconds: 300);

  //state to check if dropdown is open
  bool isOpen = false;

  //bool for animation to avoid memory leaks when animating(scneario comes in monkey testing)
  bool isAnimating = false;

  //position variables for the dropdown.
  late double xPosition, yPosition, dHeight, dWidth;

  //dropdown overlay
  OverlayEntry? dropdownOverlay;

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: animationDuration);
    offset = Tween<Offset>(
            begin: const Offset(0.0, -3.0), end: const Offset(0.0, 0.0))
        .animate(
            CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn));
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: positionKey,
      onTap: () {
        if (isAnimating) {
          return;
        }

        if (isOpen) {
          setState(() {
            isAnimating = true;
          });
          controller.reverse();

          Future.delayed(animationDuration, () {
            setState(() {
              isAnimating = false;
            });
            dropdownOverlay?.remove();
          });
        } else {
          getDropDownPosition();
          dropdownOverlay = _dropdownBox();
          Overlay.of(context)?.insert(dropdownOverlay!);
          controller.forward();
        }
        setState(() {
          isOpen = !isOpen;
        });
      },
      child: Container(
        width: 190,
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0XFFCDCDCD)),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.items.first.value),
            const Icon(Icons.keyboard_arrow_down_rounded),
          ],
        ),
      ),
    );
  }

  getDropDownPosition() {
    RenderBox renderBox =
        positionKey.currentContext?.findRenderObject() as RenderBox;

    dHeight = renderBox.size.height;
    dWidth = renderBox.size.width;

    //offset from the screens (0,0) position.
    Offset offset = renderBox.localToGlobal(Offset.zero);
    xPosition = offset.dx;
    yPosition = offset.dy;

    // log("Constraints:\n height: $dHeight\n yPos: $dWidth");
    // log("Position:\n xPos: $xPosition\n yPos: $yPosition");
  }

  OverlayEntry _dropdownBox() {
    return OverlayEntry(builder: (context) {
      return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget? child) {
          return Positioned(
            left: xPosition,
            width: dWidth,
            top: yPosition + dHeight + (isOpen ? 4 : 0),
            child: ClipRRect(
              child: SlideTransition(
                position: offset,
                child: Material(
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: const Color(0XFFCDCDCD)),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        children: [
                          ...widget.items
                              .map((item) => GestureDetector(
                                    onTap: () {
                                      widget.onChange(item.value);
                                      setState(() {
                                        isAnimating = true;
                                      });
                                      controller.reverse();
                                      Future.delayed(animationDuration, () {
                                        setState(() {
                                          isAnimating = false;
                                        });
                                        dropdownOverlay?.remove();
                                      });
                                      setState(() {
                                        isOpen = !isOpen;
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      color: Colors.transparent,
                                      padding: const EdgeInsets.only(
                                          top: 14, bottom: 14, left: 16),
                                      child: Text(
                                        item.value.toString().toUpperCase(),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ))
                              .toList()
                        ],
                      )),
                ),
              ),
            ),
          );
        },
      );
    });
  }
}

class DropDownItem<T> {
  T? value;
  DropDownItem({this.value});
}
