import 'playbackscreen.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SearchPage(),
    );
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // 入力欄の文字を扱うためのコントローラー
  final controller = TextEditingController();
  // 検索結果の一覧
  List results = [];
  // デバウンス用のタイマー
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    controller.dispose();
    super.dispose();
  }

  // iTunes APIで検索して結果を取得する
  Future<void> search(String keyword) async {
    final url = Uri.parse(
      'https://itunes.apple.com/search?term=$keyword&media=music&entity=song&country=JP',
    );

    // APIにリクエストしてJSONを取得
    final res = await http.get(url);
    final json = jsonDecode(res.body);

    // 画面を更新して結果を表示
    setState(() {
      results = json['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Music App'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // 検索キーワードの入力欄
              TextField(
                controller: controller,
                // 入力が変わるたびにAPIを呼び出す。ただし、入力の途中でAPIを呼び出さないようにデバウンスする。
                onChanged: (value) {
                  if (_debounce?.isActive ?? false) {
                    _debounce!.cancel();
                  }

                  _debounce = Timer(const Duration(milliseconds: 100), () {
                    if (value.isEmpty) {
                      setState(() {
                        results = [];
                      });
                    } else {
                      search(value);
                    }
                  });
                },
                onSubmitted: search,
                decoration: const InputDecoration(
                  hintText: '曲を検索',
                  hintStyle: TextStyle(color: Color.fromARGB(137, 108, 108, 108)),
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 16),

              Expanded(
                // 検索結果がないときは「ヒットする曲はありません」と表示し、あるときは一覧を表示
                child: results.isEmpty
                    ? const Center(
                        child: Text(
                          'ヒットする曲はありません',
                          style: TextStyle(
                            color: Colors.black38,
                            fontSize: 14,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: results.length,
                        itemBuilder: (context, index) {
                          final item = results[index];

                          // 1件分の表示
                          return ListTile(
                            leading: Image.network(
                              item['artworkUrl100'],
                            ),
                            title: Text(item['trackName'] ?? ''),
                            subtitle: Text(item['artistName'] ?? ''),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (_) {},
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '検索',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: '履歴',
          ),
        ],
      ),
    );
  }
}
