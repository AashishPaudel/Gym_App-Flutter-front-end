import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/app/config/theme_colors.dart';

class PasswordTextField extends StatefulWidget {
  final FocusNode _focusNode;
  final String _errorText;
  final Function _onChanged;
  final bool _enabled;
  final bool _obscureText;
  final Widget _suffix;
  final Function _onSubmit;
  final TextInputType _textInputType;
  final TextEditingController _controller;

  const PasswordTextField({Key key,
    @required FocusNode focusNode,
    @required String hintText,
    @required String labelText,
    @required String errorText,
    @required TextInputType textInputType,
    @required TextEditingController controller,
    @required Widget suffix,
    @required Function onChanged,
    bool enabled,
    Function onSubmit,
    bool obscureText,
    IconData icon,
  })  : _focusNode = focusNode,
        _suffix = suffix,
        _onChanged = onChanged,
        _onSubmit = onSubmit,
        _enabled = enabled,
        _controller = controller,
        _errorText = errorText,
        _textInputType = textInputType,
        _obscureText = obscureText, super(key: key);

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordTextField> {
  @override
  Widget build(BuildContext context) {
    widget._focusNode.addListener(() {
      setState(() {});
    });
    return TextField(
        keyboardType: widget._textInputType,
        focusNode: widget._focusNode,
        autofocus: false,
        enabled: widget._enabled,
        onChanged: widget._onChanged,
        obscureText: widget._obscureText,
        onSubmitted: widget._onSubmit,
        style: TextStyle(
            color: Colors.grey[700], fontFamily: 'Poppins', fontSize: 16),
        controller: widget._controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xffC4C4C4),
          // labelText: widget._labelText,
          contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
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
          floatingLabelBehavior: FloatingLabelBehavior.never,
          // hintText: widget._hintText,
          hintStyle: Get.textTheme.headline5.copyWith(
              color: Colors.grey[500], fontFamily: 'Roboto', fontSize: 18),
          suffixIcon: widget._suffix,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: const BorderSide(color: primaryColor, width: 1.2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 1.2,
            ),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(0),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(0),
          ),
        ));
  }
}
