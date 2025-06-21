import 'package:flutter/material.dart';
import '../models/pet.dart';
import '../pages/edit_pet_page.dart'; // Certifique-se de que o caminho esteja correto

class PetInfoBox extends StatelessWidget {
  final Pet pet;
  const PetInfoBox({super.key, required this.pet});

  // PET ATRIBUTES
  // String name;
  // String idade;
  // String type;
  // List<Tarefa>? tarefas;
  
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pet.name,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                Image.asset(
                  pet.type.toLowerCase() == 'dog'
                      ? 'assets/icons/dog.png'
                      : 'assets/icons/cat.png',
                  width: 64,
                  height: 64,
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditPetPage(pet: pet),
                    ),
                  );
                },
                child: const Text('Editar Pet'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
