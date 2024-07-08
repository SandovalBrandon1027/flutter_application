import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/api_provider.dart';
import 'models/cat.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CatProvider(),
      child: MaterialApp(
        title: 'HTTP Cat Viewer',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: CatImageScreen(),
      ),
    );
  }
}

class CatImageScreen extends StatefulWidget {
  @override
  _CatImageScreenState createState() => _CatImageScreenState();
}

class _CatImageScreenState extends State<CatImageScreen> {
  final TextEditingController _statusCodeController = TextEditingController();

  @override
  void dispose() {
    _statusCodeController.dispose();
    super.dispose();
  }

  void _fetchCatImage(int statusCode) {
    Provider.of<CatProvider>(context, listen: false).fetchCat(statusCode);
  }

  @override
  Widget build(BuildContext context) {
    final catProvider = Provider.of<CatProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('HTTP Cat Viewer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Enter HTTP Status Code:'),
            SizedBox(height: 10),
            TextField(
              controller: _statusCodeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter status code',
              ),
              textAlign: TextAlign.center,
              onChanged: (value) {
                // Optional: Handle input validation or formatting
              },
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                int statusCode = int.tryParse(_statusCodeController.text) ?? 200;
                _fetchCatImage(statusCode);
              },
              child: Text('Show Cat Image'),
            ),
            SizedBox(height: 20),
            if (catProvider.isLoading)
              CircularProgressIndicator()
            else if (catProvider.cat != null)
              Image.network(
                catProvider.cat!.imageUrl,
                height: 300,
              ),
          ],
        ),
      ),
    );
  }
}
