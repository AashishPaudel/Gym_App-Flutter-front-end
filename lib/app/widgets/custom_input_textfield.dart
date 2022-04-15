import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/app/config/theme_colors.dart';

class CustomInputField extends StatefulWidget {
  final FocusNode _focusNode;
  final Function _onTap;
  final Function _onSubmit;
  final bool _enabled;
  final TextInputType _textInputType;
  final Function _onChanged;
  final String _errorText;
  final TextEditingController _controller;
  final Color _inputColor;
  final double _radius;
  final double _focusedRadius;

  const CustomInputField({Key key,
    @required FocusNode focusNode,
    bool enabled,
    Function onTap,
    @required TextInputType textInputType,
    Color inputColor,
    double focusedRadius,
    Function onSubmit,
    String errorText,
    @required TextEditingController controller,
    @required Function onChanged,
    double radius,
  })
      : _focusNode = focusNode,
        _focusedRadius = focusedRadius,
        _onSubmit = onSubmit,
        _inputColor = inputColor,
        _onChanged = onChanged,
        _controller = controller,
        _radius = radius,
        _onTap = onTap,
        _enabled = enabled,
        _errorText = errorText,
        _textInputType = textInputType, super(key: key);

  @override
  _CustomInputFieldState createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  @override
  Widget build(BuildContext context) {
    widget._focusNode.addListener(() {
      setState(() {});
    });
    return TextField(
        keyboardType: widget._textInputType,
        focusNode: widget._focusNode,
        autofocus: false,
        controller: widget._controller,
        onChanged: widget._onChanged,
        onSubmitted: widget._onSubmit,
        cursorColor: primaryColor,
        onTap: widget._onTap ?? (){},
        style: TextStyle(
            color: Colors.grey[700],
            fontFamily: 'Poppins',
            fontSize: 16),
        decoration: InputDecoration(
          //
          contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
          filled: true,
          fillColor: widget._inputColor,
          // errorText: widget._errorText,
          labelStyle: Get.textTheme.headline5.copyWith(
            color: widget._focusNode.hasFocus && widget._errorText != null
                ? Colors.red
                : widget._focusNode.hasFocus //widget._errorText == null
                ? primaryColor
                : widget._errorText == null
                ? Colors.grey
                : Colors.red,
          ),
          enabled: widget._enabled ?? true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          hintStyle: Get.textTheme.headline5.copyWith(
              color: Colors.grey[500],
              fontFamily: 'Poppins',
              fontSize: 18),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget._focusedRadius),
            borderSide: const BorderSide(color: primaryColor, width: 1.2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget._radius),
            borderSide: BorderSide(
              color: widget._inputColor,
              width: 1.2,
            ),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: widget._inputColor),
            borderRadius: BorderRadius.circular(widget._radius),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: widget._inputColor),
            borderRadius: BorderRadius.circular(widget._radius),
          ),
        ));
  }
}
