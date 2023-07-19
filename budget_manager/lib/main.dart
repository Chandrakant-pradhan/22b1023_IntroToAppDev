import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: BudgetTracker()));

class Category {
  String name;
  int expense;

  Category({required this.name, required this.expense});
}

class BudgetTracker extends StatefulWidget {
  @override
  State<BudgetTracker> createState() => _BudgetTrackerState();
}

class _BudgetTrackerState extends State<BudgetTracker> {
  int budget = 0;
  String selectedCategory = '';
  List<Category> categories = [];

  bool showCategories = false;

  TextEditingController categoryNameController = TextEditingController();
  TextEditingController expenseController = TextEditingController();

  void addCategory() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Category'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: categoryNameController,
                decoration: InputDecoration(
                  labelText: 'Category Name',
                ),
              ),
              TextField(
                controller: expenseController,
                decoration: InputDecoration(
                  labelText: 'Expense',
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                String categoryName = categoryNameController.text;
                int expense = int.parse(expenseController.text);

                Category newCategory =
                Category(name: categoryName, expense: expense);
                categories.add(newCategory);

                setState(() {
                  budget += expense;
                });

                categoryNameController.clear();
                expenseController.clear();

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void removeCategory(int index) {
    setState(() {
      budget -= categories[index].expense;
      categories.removeAt(index);
    });
  }

  void toggleCategoriesVisibility() {
    setState(() {
      showCategories = !showCategories;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent[100],
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              addCategory();
            },
            child: Icon(
              Icons.add,
              color: Colors.purple[700],
              size: 30,
            ),
            backgroundColor: Colors.white,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Text(
                'Budget Tracker',
                style: TextStyle(
                  color: Colors.purple[700],
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 15),
            Center(
              child: Icon(
                Icons.person,
                size: 130,
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: Text(
                'Welcome',
                style: TextStyle(
                  letterSpacing: 5,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                'Back!',
                style: TextStyle(
                  letterSpacing: 5,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 40),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Total:',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '$budget',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          toggleCategoriesVisibility();
                        },
                        child: Icon(
                          showCategories ? Icons.arrow_upward : Icons.arrow_downward,
                          color: Colors.purple[700],
                          size: 30,
                        ),
                        backgroundColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            if (showCategories)
              Expanded(
                child: ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.purpleAccent[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              categories[index].name,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Expense : ${categories[index].expense}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                removeCategory(index);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
