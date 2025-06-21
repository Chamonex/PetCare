import 'package:flutter/material.dart';
import 'package:pet_care/widgets/app_button.dart';
import '../models/pet.dart';
import '../models/tarefa.dart';

class EditPetPage extends StatefulWidget {
  final Pet pet;
  const EditPetPage({super.key, required this.pet});

  @override
  State<EditPetPage> createState() => _EditPetPageState();
}

class _EditPetPageState extends State<EditPetPage> {
  late TextEditingController _nameController;
  late TextEditingController _idadeController;
  late String _type;
  late List<Tarefa> _tarefas;
  bool _showTarefaForm = false;
  final TextEditingController _tarefaNomeController = TextEditingController();
  TimeOfDay? _tarefaHorario;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.pet.name);
    _idadeController = TextEditingController(text: widget.pet.idade);
    _type = widget.pet.type;
    _tarefas = widget.pet.tarefas ?? [];
  }

  @override
  void dispose() {
    _nameController.dispose();
    _idadeController.dispose();
    _tarefaNomeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Pet')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _idadeController,
              decoration: const InputDecoration(labelText: 'Idade'),
            ),
            const SizedBox(height: 16),
            AppButton(
              label: 'Adicionar Tarefa',
              icon: Icons.task,
              filled: true,
              isCircle: false,
              onPressed: () {
                setState(() {
                  _showTarefaForm = true;
                });
              },
            ),
            if (_showTarefaForm)
              Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextField(
                        controller: _tarefaNomeController,
                        decoration: const InputDecoration(labelText: 'Nome da Tarefa'),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Text(_tarefaHorario == null
                                ? 'Horário: não definido'
                                : 'Horário: ${_tarefaHorario!.format(context)}'),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              final picked = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (picked != null) {
                                setState(() {
                                  _tarefaHorario = picked;
                                });
                              }
                            },
                            child: const Text('Selecionar Horário'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          // Aqui você pode adicionar lógica para salvar a tarefa
                          setState(() {
                            _showTarefaForm = false;
                            _tarefaNomeController.clear();
                            _tarefaHorario = null;
                          });
                        },
                        child: const Text('Salvar Tarefa'),
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Aqui você pode adicionar a lógica de salvar/atualizar
                Navigator.pop(context);
              },
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
