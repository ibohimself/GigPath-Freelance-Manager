import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(const GigPathApp());
}

class GigPathApp extends StatelessWidget {
  const GigPathApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GigPath',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Database? _database;
  List<Map<String, dynamic>> _projects = [];

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'gigpath_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE projects(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, income REAL)',
        );
      },
      version: 1,
    );
    _loadProjects();
  }

  Future<void> _loadProjects() async {
    if (_database != null) {
      final List<Map<String, dynamic>> maps = await _database!.query('projects');
      setState(() {
        _projects = maps;
      });
    }
  }

  Future<void> _addProject(String title, double income) async {
    if (_database != null) {
      await _database!.insert(
        'projects',
        {'title': title, 'income': income},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      _loadProjects();
    }
  }

  void _showAddProjectDialog() {
    final titleController = TextEditingController();
    final incomeController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Yeni Proje Ekle'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Proje Adı (Örn: Minimal Logo)'),
            ),
            TextField(
              controller: incomeController,
              decoration: const InputDecoration(labelText: 'Gelir (\$)'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty && incomeController.text.isNotEmpty) {
                _addProject(titleController.text, double.parse(incomeController.text));
                Navigator.pop(context);
              }
            },
            child: const Text('Ekle'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double totalIncome = _projects.fold(0, (sum, item) => sum + item['income']);

    return Scaffold(
      appBar: AppBar(title: const Text('GigPath - Freelance Asistanı')),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.blueGrey.shade100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Toplam Gelir:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text('\$${totalIncome.toStringAsFixed(2)}', style: const TextStyle(fontSize: 20, color: Colors.green)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _projects.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.work),
                  title: Text(_projects[index]['title']),
                  trailing: Text('\$${_projects[index]['income']}'),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddProjectDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
