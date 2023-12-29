import 'package:flutter/material.dart';

class TodoListPage extends StatelessWidget {
  TodoListPage({super.key});

  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Lista de tarefas",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.9,
      ),
      body: Container(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 16,
          top: 30,
        ),
        color: Colors.white,
        child: Column(
          children: [
            AddTaskArea(),
            ListTask(),
            Divider(
              color: Colors.black,
              thickness: 0.2,
            ),
            TaskQuantityAnbButtonClearAll(),
          ],
        ),
      ),
    );
  }

  Widget TaskQuantityAnbButtonClearAll() {
    return Padding(
      padding: const EdgeInsets.only(
            top: 13,
          ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "Você possui 3 tarefas pendentes",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              padding: EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 14,
              ),
            ),
            onPressed: () {},
            child: Text(
              "Limpar tudo",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget AddTaskArea() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 55,
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                ),
                hintText: "Ex.: Estudar back-end",
                labelText: "Adicione uma tarefa",
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
            primary: Color(0xff2da84e),
          ),
          onPressed: () {},
          child: Icon(
            Icons.add,
            size: 25,
          ),
        ),
      ],
    );
  }

  Widget ListTask() {
    return Expanded(
      child: Wrap(
        children: [],
      ),
    );
  }
}
