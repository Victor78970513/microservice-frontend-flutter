import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reto_tancara/provider/home_provider.dart';
import 'package:reto_tancara/screens/create_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<HomeProvider>().getTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeProvider>();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async => await homeProvider.getTasks(),
                child: const Text("RECARCAR TAREAS"),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: homeProvider.tasks.length,
                  itemBuilder: (context, index) {
                    final task = homeProvider.tasks[index];
                    return Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            width: 3,
                            color: Colors.black,
                          )),
                      child: ListTile(
                        title: Text(task['taskName']),
                        subtitle: Text(task['description']),
                        leading: Text(
                          '$index',
                          style: const TextStyle(fontSize: 16),
                        ),
                        trailing: Text(
                            (task['createdAt']).toString().substring(0, 9)),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateTaskScreen(),
            )),
        child: const Icon(Icons.add),
      ),
    );
  }
}
