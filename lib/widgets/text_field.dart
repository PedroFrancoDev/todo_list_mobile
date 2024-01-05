import 'package:flutter/material.dart';
import 'package:todo_list/validation/task_validate.dart';

class TextFieldCostumized extends StatelessWidget {
  TextFieldCostumized({
    super.key,
    required this.function,
    required this.buttonIcon,
    required this.background,
    required this.taskController,
    required this.labelText,
    required this.errorTask,
  });

  final Function function;
  final IconData buttonIcon;
  final Color background;
  final TextEditingController taskController;
  final String labelText;

  final TaskValidate taskValidate = TaskValidate();

  final bool? errorTask;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                height: 55,
                child: TextField(
                  controller: taskController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: errorColor(color: Colors.blueAccent),
                      ),
                    ),
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(
                      color: errorColor(color: Colors.black),
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                    hintText: "Ex.: Estudar back-end",

                    labelText: labelText,
                  ),
                ),
              ),
            ),
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
        ),
        SizedBox(
          height: 5,
        ),
        if (errorTask != null && errorTask == false)
          Text(
            "Tarefa inválida",
            style: TextStyle(color: Colors.red),
          ),
      ],
    );
  }

  Color errorColor({required Color color}) {
    if(errorTask != null && errorTask == false) {
      return Colors.red;
    }

    return color;
  }
}
