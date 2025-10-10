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
                      setState(() {});
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
