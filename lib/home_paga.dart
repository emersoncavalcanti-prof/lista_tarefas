import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerTarefa = TextEditingController();
  final List<String> _tarefas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de tarefas', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsetsGeometry.all(8),
            child: Form(
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
                  return null;
                },
              ),
            ),
          ),
          InkWell(
            onTap: () {
              if (_formKey.currentState!.validate()) {
                setState(() {
                  _tarefas.add(_controllerTarefa.text);
                  _controllerTarefa.clear();
                });
              }
            },
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
                return ListTile(title: Text(_tarefas[index]));
              },
            ),
          ),
        ],
      ),
    );
  }
}
