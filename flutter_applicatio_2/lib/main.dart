import 'package:flutter/material.dart';

import 'data/fake_reading_repo.dart';
import 'data/model/reading.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ReadingPage(),
    );
  }
}

class ReadingPage extends StatefulWidget {
  const ReadingPage({super.key});

  @override
  State<ReadingPage> createState() => _ReadingPageState();
}

class _ReadingPageState extends State<ReadingPage> {
  final FakeReadingRepo _repo = FakeReadingRepo();

  @override
  void dispose() {
    _repo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Readings'),
        backgroundColor: Colors.deepPurple,
      ),
      body: StreamBuilder<List<Reading>>(
        stream: _repo.readings,
        initialData: const <Reading>[],
        builder: (context, snapshot) {
          final readings = snapshot.data ?? const <Reading>[];

          if (readings.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: readings.length,
            itemBuilder: (context, index) {
              final reading = readings[index];

              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: reading.isLowFuel ? Colors.orange : Colors.green,
                  child: Text(
                    reading.assetId.substring(0, 1),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(reading.note),
                subtitle: Text(
                  '${reading.assetId} • ${reading.kwh} kWh • ${reading.fuelPercent}% fuel',
                ),
                trailing: Text(
                  reading.syncState.name,
                  style: TextStyle(
                    color: reading.syncState == SyncState.pending
                        ? Colors.orange
                        : reading.syncState == SyncState.conflict
                            ? Colors.red
                            : Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
