import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/routes/app_router.dart';

class AddCategoryButton extends StatelessWidget {
  const AddCategoryButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        context.router.push(const AddNewCategoryRoute());
      },
      label: const Text('Add'),
      icon: const Icon(Icons.add),
    );
  }
}
