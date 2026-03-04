import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. モックデータ定義 
    final List<Map<String, String>> mockData = [
      {'title': '商品A', 'price': '1000円'},
      {'title': '商品B', 'price': '2000円'},
      {'title': '商品C', 'price': '3000円'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('履歴'),
        backgroundColor: const Color.fromARGB(255, 255, 105, 105),
      ),
      // 2. ListView.builderでモックデータを表示
      body: ListView.builder(
        itemCount: mockData.length,
        itemBuilder: (context, index) {
          final item = mockData[index];
          return ListTile(
            title: Text(item['title']!),
              subtitle: Text(item['price']!),
          );
        },
      ),
    );
  }
}
