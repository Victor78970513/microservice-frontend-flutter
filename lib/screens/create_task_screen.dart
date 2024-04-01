import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reto_tancara/provider/create_task_provider.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final TextEditingController taskNameCtrl = TextEditingController();
  final TextEditingController descCtrl = TextEditingController();
  final TextEditingController stateCtrl = TextEditingController();
  int? userIdTapped;

  @override
  void initState() {
    context.read<CreateTaskProvider>().fetchUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final createTaskProvider = context.watch<CreateTaskProvider>().users;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 3, color: Colors.black),
                ),
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: createTaskProvider.length,
                  itemBuilder: (context, index) {
                    // return Text("$index");
                    final user = createTaskProvider[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: GestureDetector(
                        onTap: () {
                          userIdTapped = user['id'];
                          setState(() {
                            print(userIdTapped);
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              child: Text((user['name'])
                                  .toString()
                                  .substring(0, 2)
                                  .toUpperCase()),
                            ),
                            Text("USER: ${user["id"]}")
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 15),
              _InputTask(
                controller: taskNameCtrl,
                hintText: "NOMBRE DE LA TAREA",
              ),
              const SizedBox(height: 15),
              _InputTask(
                controller: descCtrl,
                hintText: "DESCRIPCION DE LA TAREA",
              ),
              const SizedBox(height: 15),
              _InputTask(
                controller: stateCtrl,
                hintText: "ESTADO DE LA TAREA",
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final createdTask =
              await context.read<CreateTaskProvider>().createTask(
                    userId: userIdTapped ?? 0,
                    taskName: taskNameCtrl.text,
                    description: descCtrl.text,
                    finishAt: DateTime.now(),
                    taskState: stateCtrl.text,
                  );

          if (!createdTask) {
            log("ERROR CHOCO AL CREAR");
          } else {
            Navigator.pop(context);
          }
        },
        child: const Icon(Icons.save_alt_outlined),
      ),
    );
  }
}

class _InputTask extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const _InputTask({
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }
}
