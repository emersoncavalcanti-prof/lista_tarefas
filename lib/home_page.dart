import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final VoidCallback onToggleChanged;
  final bool isDarkMode;

  const HomePage({
    super.key,
    required this.onToggleChanged,
    required this.isDarkMode,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerTarefa = TextEditingController();
  final List<String> _tarefas = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carregarTarefas();
  }

  void carregarTarefas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tarefaJson = prefs.getString('tarefas');

    if (tarefaJson != null) {
      setState(() {
        _tarefas.addAll(List<String>.from(json.decode(tarefaJson)));
      });
    }
  }

  void salvarTarefa() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tarefaJson = json.encode(_tarefas);
    await prefs.setString('tarefas', tarefaJson);
  }

  void addTarefa() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _tarefas.add(_controllerTarefa.text);
        _controllerTarefa.clear();
        salvarTarefa();
      });
    }
  }

  void removerTarefa(int index) {
    setState(() {
      _tarefas.removeAt(index);
      salvarTarefa();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.network(
          'https://img.icons8.com/ios-filled/50/000000/task.png',
          color: Colors.white,
          scale: 1.5,
        ),
        title: Column(
          children: [
            Text('Lista de tarefas', style: TextStyle(color: Colors.white)),
            Text(
              'Gerencie suas tarefas diárias',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ),
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            onPressed: widget.onToggleChanged,
            icon: widget.isDarkMode
                ? Icon(Icons.wb_sunny)
                : Icon(Icons.nightlight_round, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsetsGeometry.all(8),
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              key: _formKey,
              child: TextFormField(
                controller: _controllerTarefa,
                decoration: InputDecoration(
                  labelText: 'Digite uma tarefa',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira uma tarefa';
                  }
                  if (value.length <= 4) {
                    return 'A tarefa deve ter mais de 4 caracteres';
                  }

                  if (!value.contains('@')) {
                    return 'A tarefa deve conter o caractere @';
                  }

                  return null;
                },
              ),
            ),
          ),
          InkWell(
            onTap: addTarefa,
            child: Container(
              width: double.infinity,
              height: 40,
              color: Colors.indigo,
              margin: EdgeInsets.only(left: 8, right: 8),
              child: Center(
                child: Text(
                  'Adicionar',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tarefas.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.network(
                    'https://img.icons8.com/ios-filled/50/000000/task.png',
                    color: Colors.indigo,
                  ),
                  title: Text(
                    _tarefas[index],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Clique na lixeira para remover'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.indigo),
                    onPressed: () {
                      removerTarefa(index);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
