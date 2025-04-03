import 'package:flutter/material.dart';
import 'package:flutter_provider_example/providers/cart.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CartProvider>(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
        routes: {
          '/details': (BuildContext context) => DetailsPage(),
        },
        home: HomePage(),
      ),
    );
  }
}
class HomePage extends StatelessWidget {
  final String? title;
  const HomePage({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<CartProvider>();

    final notSelectedUsers = model.getNotSelectedUsers;

    return Scaffold(
      appBar: AppBar(
        title: Text(title ?? 'CartApp'),
        actions: [
          Text(model.selectedUsers.length.toString(), style: TextStyle(fontSize: 20)),
          SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/details');
            },
            child: Icon(Icons.people),
          ),
          SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              model.fetchData();
            },
            child: Icon(Icons.add_box),
          ),
          SizedBox(width: 36),
        ],
      ),
      body: ListView.builder(
        itemCount: notSelectedUsers.length,
        itemBuilder: (context, index) => UserCard(user: notSelectedUsers[index]),
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<CartProvider>();
    final users = model.selectedUsers;

    return Scaffold(
      appBar: AppBar(title: Text('Details')),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) => UserCard(user: users[index]),
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  final User user;

  const UserCard({
    required this.user,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.watch<CartProvider>();

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration:
          BoxDecoration(color: const Color.fromARGB(255, 227, 227, 227), borderRadius: BorderRadius.circular(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Id: ${user.id.toString()}', style: TextStyle(fontSize: 16)),
              if (user.username != null) Text(user.username!, style: TextStyle(fontSize: 18)),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              model.selectUser(user);
            },
            child: Text('Добавить'),
          ),
        ],
      ),
    );
  }
}
