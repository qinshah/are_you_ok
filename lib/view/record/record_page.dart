import 'package:flutter/material.dart';
import '../../data/record_storage.dart';
import '../../data/record_model.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({super.key});

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  final _controller = TextEditingController();
  final List<Map<String, dynamic>> _statusChanges = [];

  Widget _buildStatusChangeInput() {
    String currentAttribute = '';
    int currentValue = 0;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  hintText: '属性名称 (例如: 心情)',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  currentAttribute = value;
                },
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 100,
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: '值 (-10到10)',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  currentValue = int.tryParse(value) ?? 0;
                },
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                setState(() {
                  if (currentAttribute.isNotEmpty) {
                    _statusChanges.add({
                      'attribute': currentAttribute,
                      'value': currentValue,
                    });
                  }
                });
              },
            ),
          ],
        ),
        if (_statusChanges.isNotEmpty)
          Column(
            children: _statusChanges
                .map(
                  (change) => ListTile(
                    title: Text(change['attribute']),
                    trailing: Text('${change['value']}'),
                  ),
                )
                .toList(),
          ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('记录一下')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: '记录你的想法...',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 16),
            // 新增的状态变化输入部分
            _buildStatusChangeInput(),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  final record = Record(
                    content: _controller.text,
                    statusChanges: _statusChanges,
                  );
                  RecordStorage().saveRecord(record);
                }
                Navigator.pop(context);
              },
              child: const Text('保存'),
            ),
          ],
        ),
      ),
    );
  }
}