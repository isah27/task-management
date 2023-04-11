import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppDropdownInput<T> extends StatelessWidget {
  final String hintText;
  final List<T> options;
  final T value;
  final Size size;
  final void Function(T?) onChanged;

  const AppDropdownInput({
    Key? key,
    this.hintText = 'Please select an Option',
    this.options = const [],
    required this.size,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(size.width * 0.02),
      ),
      child: FormField<T>(
        builder: (FormFieldState<T> state) {
          var underlineInputBorder = const OutlineInputBorder(
            borderSide: BorderSide.none,
          );
          return InputDecorator(
            baseStyle: TextStyle(fontSize: 15.sp, color: Colors.black87),
            textAlign: TextAlign.start,
            textAlignVertical: TextAlignVertical.top,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: size.width * 0.01,
              ),
              labelText: hintText,
              enabledBorder: underlineInputBorder,
              border: underlineInputBorder,
            ),
            isEmpty: value == null || value == '',
            child: DropdownButtonHideUnderline(
              child: DropdownButton<T>(
                dropdownColor: Colors.grey.shade200,
                focusColor: Colors.grey.shade200,
                itemHeight: null,
                icon: Icon(
                  Icons.arrow_drop_down,
                  size: size.width * 0.08,
                ),
                value: value,
                // isDense: true,
                onChanged: (value) => onChanged(value),
                items: options.map((T value) {
                  return DropdownMenuItem<T>(
                    value: value,
                    child: Text(
                      "$value",
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
