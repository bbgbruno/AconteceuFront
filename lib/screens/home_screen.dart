import 'package:flutter/material.dart';
import '../models/event.dart';
import '../widgets/event_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Event> _events = [];

  void _addEvent(Event event) {
    setState(() {
      _events.add(event);
    });
  }

  void _deleteEvent(int index) {
    setState(() {
      _events.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aconteceu'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final newEvent = await Navigator.pushNamed(context, '/add');
              if (newEvent != null && newEvent is Event) {
                _addEvent(newEvent);
              }
            },
          ),
        ],
      ),
      body: _events.isEmpty
          ? const Center(child: Text('Nenhum evento cadastrado.'))
          : ListView.builder(
              itemCount: _events.length,
              itemBuilder: (context, index) {
                return EventCard(
                  event: _events[index],
                  onDelete: () => _deleteEvent(index),
                );
              },
            ),
    );
  }
}
