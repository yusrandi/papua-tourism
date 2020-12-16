import 'package:flutter/material.dart';
import 'package:papua_tourism/res/styling.dart';

// ignore: must_be_immutable
class SearchItem extends StatefulWidget {
  Function onClick;
  Function(String) onSubmit;
  TextEditingController controller;
  bool readOnly;
  bool autoFocus;

  SearchItem(
      {this.onClick,
      this.onSubmit,
      @required this.controller,
      this.readOnly = false,
      this.autoFocus = false});

  @override
  _SearchItemState createState() => _SearchItemState();
}

class _SearchItemState extends State<SearchItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
          color: AppTheme.appBackgroundColor,
          border: Border.all(color: Colors.black12.withOpacity(0.05)),
          borderRadius: BorderRadius.circular(6)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Icon(
              Icons.search,
              size: 20,
              color: Colors.black,
            ),
            SizedBox(width: 5),
            Expanded(
                child: TextField(
              controller: widget.controller,
              textInputAction: TextInputAction.done,
              onTap: () => widget.onClick != null ? widget.onClick() : {},
              keyboardType: TextInputType.text,
              readOnly: widget.readOnly,
              autofocus: widget.autoFocus,
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                  fontWeight: FontWeight.w600),
              onSubmitted: (value) =>
                  widget.onSubmit != null ? widget.onSubmit(value) : {},
              decoration: InputDecoration(
                  hintText: "What are u looking for",
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none),
            ))
          ],
        ),
      ),
    );
  }
}
