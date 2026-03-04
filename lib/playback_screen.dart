import 'package:flutter/material.dart';

class PlaybackScreen extends StatelessWidget {
  // 画面に表示するデータ
  // Map<String, dynamic>は「キーが文字列で値は何でもOK」という意味
  final Map<String, dynamic> item;

  // コンストラクタ（このクラスを使うときに必要な情報を受け取る）
  // requiredにしているので、必ずitemを渡す必要がある
  const PlaybackScreen({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('再生画面'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          // 縦方向に部品を並べる
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(item['artworkUrl100']),
              const SizedBox(height: 16),
              Text(
                item['trackName'] ?? '',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(item['artistName'] ?? ''),
            ],
          ),
        ),
      ),
    );
  }
}
