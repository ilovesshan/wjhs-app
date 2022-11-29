import 'package:flutter/cupertino.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("CategoryPage"));
  }
}
