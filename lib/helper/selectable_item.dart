import 'package:flutter/material.dart';

class GridViewItem extends StatelessWidget {
  final IconData _iconData;
  final bool _isSelected;

  GridViewItem(this._iconData, this._isSelected);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(
        _iconData,
        color: Colors.white,
      ),
      shape: CircleBorder(),
      fillColor: _isSelected ? Colors.blue : Colors.black,
      onPressed: null,
    );
  }
}