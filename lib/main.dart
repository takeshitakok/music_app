import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // このウィジェットはアプリケーションのルートです。
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // これはアプリケーションのテーマです。
        //
        // 試してみよう: "flutter run"でアプリケーションを実行してみてください。
        // アプリケーションに紫色のツールバーが表示されます。次に、アプリを終了せずに、
        // 以下のcolorSchemeのseedColorをColors.greenに変更して
        // 「ホットリロード」を実行してください（変更を保存するか、Flutter対応IDEの
        // 「ホットリロード」ボタンを押すか、コマンドラインでアプリを起動した場合は
        // "r"を押してください）。
        //
        // カウンターがゼロにリセットされないことに注目してください。アプリケーションの
        // 状態はリロード中に失われません。状態をリセットするには、代わりに
        // ホットリスタートを使用してください。
        //
        // これは値だけでなくコードにも機能します：ほとんどのコード変更は
        // ホットリロードだけでテストできます。
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Music App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // このウィジェットはアプリケーションのホームページです。ステートフルであり、
  // 見た目に影響を与えるフィールドを含むStateオブジェクト（以下で定義）を持ちます。

  // このクラスは状態の設定です。親（この場合はAppウィジェット）から提供された
  // 値（この場合はtitle）を保持し、Stateのbuildメソッドで使用されます。
  // Widgetサブクラスのフィールドは常に"final"とマークされます。

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // setStateの呼び出しは、このStateで何かが変更されたことをFlutterフレームワーク
      // に伝えます。これにより、以下のbuildメソッドが再実行され、表示が更新された値を
      // 反映できるようになります。setState()を呼び出さずに_counterを変更した場合、
      // buildメソッドは再度呼び出されず、何も起こらないように見えます。
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // このメソッドは、setStateが呼び出されるたびに再実行されます。
    // 例えば、上記の_incrementCounterメソッドによって実行されます。
    //
    // Flutterフレームワークは、buildメソッドの再実行を高速化するように最適化されているため、
    // ウィジェットのインスタンスを個別に変更する必要はなく、更新が必要なものを
    // すべて再構築できます。
    return Scaffold(
      appBar: AppBar(
        // 試してみよう: ここの色を特定の色（例えばColors.amber）に変更して
        // ホットリロードを実行すると、他の色はそのままでAppBarの色だけが
        // 変わることを確認できます。
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // ここでは、App.buildメソッドによって作成されたMyHomePageオブジェクトから
        // 値を取得し、それを使ってアプリバーのタイトルを設定します。
        title: Text(widget.title),
      ),
      body: Center(
        // Centerはレイアウトウィジェットです。単一の子を受け取り、
        // 親の中央に配置します。
        child: Column(
          // Columnもレイアウトウィジェットです。子のリストを受け取り、
          // それらを縦に配置します。デフォルトでは、水平方向は子に合わせてサイズを調整し、
          // 垂直方向は親と同じ高さになろうとします。
          //
          // Columnには、自身のサイズや子の配置を制御するためのさまざまなプロパティが
          // あります。ここではmainAxisAlignmentを使用して子を垂直方向の中央に配置します。
          // ここでの主軸は垂直軸です。これはColumnが垂直だからです
          // （交差軸は水平になります）。
          //
          // 試してみよう: 「デバッグペイント」を実行すると（IDEで"Toggle Debug Paint"
          // アクションを選択するか、コンソールで"p"を押す）、各ウィジェットの
          // ワイヤーフレームが表示されます。
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // この末尾のカンマにより、buildメソッドの自動フォーマットが綺麗になります。
    );
  }
}
