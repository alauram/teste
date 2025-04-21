import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Guarda Roupa', home: PecasPage());
  }
}

class PecasPage extends StatefulWidget {
  const PecasPage({super.key});

  @override
  State<PecasPage> createState() => _PecasPageState();
}

class _PecasPageState extends State<PecasPage> {
  List<Map<String, dynamic>> pecas = [];

  @override
  void initState() {
    super.initState();
    fetchPecas();
  }

  Future<void> fetchPecas() async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/pecas/'),
      );

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<Map<String, dynamic>> pecasConvertidas =
            data.map((item) => Map<String, dynamic>.from(item)).toList();

        setState(() {
          pecas = pecasConvertidas;
        });
      } else {
        throw Exception('Erro ao carregar peças');
      }
    } catch (e) {
      print('Erro na requisiçao: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Peças')),
      body:
          pecas.isEmpty
              ? const Center(child: Text('Nenhuma peça encontrada.'))
              : ListView.builder(
                itemCount: pecas.length,
                itemBuilder: (context, index) {
                  final peca = pecas[index];
                  print('Peca[$index]: $peca');

                  return ListTile(
                    title: Text(peca['tag'] ?? 'Sem tag'),
                    subtitle: Text(peca['tipo'] ?? 'Sem tipo'),
                    leading:
                        peca['imagem'] != null
                            ? Image.network(
                              peca['imagem'],
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                              errorBuilder:
                                  (context, error, stackTrace) =>
                                      const Icon(Icons.broken_image),
                            )
                            : const Icon(Icons.image_not_supported),
                  );
                },
              ),
    );
  }
}
