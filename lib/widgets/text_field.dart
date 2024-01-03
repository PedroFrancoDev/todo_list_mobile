import 'package:flutter/material.dart';

class TextFieldCostumized extends StatelessWidget {
  TextFieldCostumized({
    super.key,
    required this.function,
    required this.buttonIcon,
    required this.background,
    required this.taskController,
    required this.labelText,
  });

  final Function function;
  final IconData buttonIcon;
  final Color background;
  final TextEditingController taskController;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
          height: 55,
          child: TextField(
            controller: taskController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),
              hintText: "Ex.: Estudar back-end",
              labelText: labelText,
            ),
          ),
        )),
        SizedBox(
          width: 8,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: Size(55, 55),
            primary: background,
          ),
          onPressed: () => function(),
          child: Icon(
            buttonIcon,
            size: 25,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
