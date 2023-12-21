import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../actions/todoAction.dart';
import '../models/todo.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('TODO List', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).padding.top + kToolbarHeight,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(10),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          prefixIcon: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {},
                          ),
                          hintText: 'Search'),
                      onChanged: (text) =>
                          Provider.of<TodoModel>(context, listen: false)
                              .setFilter(text),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + kToolbarHeight + 50,
            bottom: 0,
            left: 0,
            right: 0,
            child: Consumer<TodoModel>(
              builder: (context, todo, child) {
                return todo.list.isEmpty
                    ? const Center(
                        child: Text('No results. Create a new one instead.'),
                      )
                    : ListView.builder(
                        itemCount: todo.list.length,
                        itemBuilder: (context, index) {
                          var item = todo.list[todo.list.length - index - 1];
                          return Container(
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: ListTile(
                              leading: Checkbox(
                                value: item.isComplete,
                                onChanged: (value) => Provider.of<TodoModel>(
                                        context,
                                        listen: false)
                                    .toggleComplete(item.id),
                              ),
                              title: Text(
                                item.name,
                                style: item.isComplete
                                    ? const TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                      )
                                    : null,
                              ),
                              trailing: Wrap(
                                spacing: 6,
                                children: <Widget>[
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () => _showAddEditPanel(context,
                                        editItem: item),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () => Provider.of<TodoModel>(
                                            context,
                                            listen: false)
                                        .removeItem(item.id),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FloatingActionButton(
                backgroundColor: Colors.black,
                onPressed: () => _showAddEditPanel(context),
                child: const Icon(Icons.add),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddEditPanel(BuildContext context, {TodoItem? editItem}) {
    final TextEditingController _controller =
        TextEditingController(text: editItem?.name);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(editItem != null ? 'Edit Item' : 'Add Item'),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(labelText: 'Enter the item name'),
            onSubmitted: (text) {
              if (editItem != null) {
                Provider.of<TodoModel>(context, listen: false)
                    .updateItem(editItem.id, _controller.text);
              } else {
                Provider.of<TodoModel>(context, listen: false)
                    .addItem(_controller.text);
              }
              Navigator.of(context).pop();
            },
          ),
          actions: [
            TextButton(
              child:
                  const Text('Cancel', style: TextStyle(color: Colors.black)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black)),
              onPressed: () {
                if (editItem != null) {
                  Provider.of<TodoModel>(context, listen: false)
                      .updateItem(editItem.id, _controller.text);
                } else {
                  Provider.of<TodoModel>(context, listen: false)
                      .addItem(_controller.text);
                }
                Navigator.of(context).pop();
              },
              child: Text(editItem != null ? 'Edit' : 'Add'),
            ),
          ],
        );
      },
    );
  }
}
