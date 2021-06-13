import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef MacwindowctlHoverEvent = void Function(MacwindowctlAction);
typedef MacwindowctlExitEvent = void Function(MacwindowctlAction);
typedef MacwindowctlClickEvent = void Function(MacwindowctlAction);

enum MacwindowctlAction {
  close,
  minimize,
  maximize,
}

class Macwindowctl extends StatefulWidget {
  final bool? focused;

  final double? buttonSize;

  final double? blurSize;

  final MacwindowctlHoverEvent? onHover;

  final MacwindowctlExitEvent? onExit;

  final MacwindowctlClickEvent? onClick;

  Macwindowctl({
    this.onClick,
    this.onExit,
    this.onHover,
    this.focused,
    this.buttonSize,
    this.blurSize,
  });

  @override
  _MacwindowctlState createState() => _MacwindowctlState();
}

class _MacwindowctlState extends State<Macwindowctl> {
  bool onHoverFlag = false;

  List<Map<String, dynamic>> _actions = [
    {
      "icon": CupertinoIcons.xmark,
      "action": MacwindowctlAction.close,
      "color": Colors.red[400],
    },
    {
      "icon": CupertinoIcons.minus,
      "action": MacwindowctlAction.minimize,
      "color": Colors.yellow[400],
    },
    {
      "icon": CupertinoIcons.arrow_down_right_arrow_up_left,
      "action": MacwindowctlAction.maximize,
      "color": Colors.green[400],
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          ..._actions
              .map((item) => GestureDetector(
                    onTap: () {
                      if (widget.onClick != null && mounted) {
                        widget.onClick!(item["action"] as MacwindowctlAction);
                      }
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      onHover: (event) {
                        if (widget.onHover != null && mounted) {
                          widget.onHover!(item["action"] as MacwindowctlAction);
                        }
                        setState(() {
                          onHoverFlag = true;
                        });
                      },
                      onExit: (event) {
                        if (widget.onExit != null && mounted) {
                          widget.onExit!(item["action"] as MacwindowctlAction);
                        }
                        setState(() {
                          onHoverFlag = false;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          right: 6.0,
                        ),
                        width: widget.buttonSize,
                        height: widget.buttonSize,
                        decoration: BoxDecoration(
                          color: (widget.focused ?? false)
                              ? item["color"]
                              : Colors.black26,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black12),
                          boxShadow: [
                            BoxShadow(
                              color: (widget.blurSize != null &&
                                      widget.blurSize! > 0 &&
                                      (widget.focused ?? false))
                                  ? item["color"]
                                  : Colors.transparent,
                              offset: Offset(1, 1),
                              blurRadius: widget.blurSize == null
                                  ? 0
                                  : (widget.blurSize ?? 0),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Icon(
                            item["icon"],
                            color:
                                onHoverFlag ? Colors.black : Colors.transparent,
                            size: (widget.buttonSize ?? 10) * .75,
                          ),
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ],
      ),
    );
  }
}
