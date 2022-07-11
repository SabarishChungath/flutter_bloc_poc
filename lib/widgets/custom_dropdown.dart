import 'package:flutter/material.dart';

class CustomDropDown<T> extends StatefulWidget {
  final List<DropDownItem> items;
  final T value;

  const CustomDropDown({Key? key, required this.items, required this.value})
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
        setState(() {
          if (isOpen) {
            controller.reverse();
            Future.delayed(animationDuration, () {
              dropdownOverlay?.remove();
            });
          } else {
            getDropDownPosition();
            dropdownOverlay = _dropdownBox();
            Overlay.of(context)?.insert(dropdownOverlay!);
            controller.forward();
          }

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
                        color: Colors.greenAccent,
                        border: Border.all(color: const Color(0XFFCDCDCD)),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        children: [
                          ...widget.items
                              .map((item) => Padding(
                                    padding: const EdgeInsets.only(
                                        top: 16, bottom: 16, left: 16),
                                    child: SizedBox(
                                        width: double.maxFinite,
                                        child: Text(item.value
                                            .toString()
                                            .toUpperCase())),
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
  // Function(T)? onChange;
  T? value;
  DropDownItem({this.value});
}