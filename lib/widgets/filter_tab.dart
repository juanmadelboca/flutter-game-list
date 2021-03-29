import 'package:flutter/material.dart';

class FilterTab extends StatefulWidget {
  final String displayName;
  final bool selected;
  final Function onTap;

  const FilterTab({Key key, this.displayName, this.selected, this.onTap}) : super(key: key);

  @override
  _FilterTabState createState() => _FilterTabState();
}

class _FilterTabState extends State<FilterTab> {
  Color selectedColor = Colors.black87;
  Color unselectedColor = Colors.black26;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 0.5, color: unselectedColor))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: GestureDetector(
          onTap: () => widget.onTap(),
          child: Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1.5, color: widget.selected ? selectedColor : Colors.transparent))),
            child: Text(
              widget.displayName,
              style: TextStyle(fontSize: 20, color: widget.selected ? selectedColor : unselectedColor),
            ),
          ),
        ),
      ),
    );
    ;
  }
}
