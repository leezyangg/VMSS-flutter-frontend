import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../../widgets/gradient_button.dart';

class UpdateList extends StatefulWidget {
  final List<UpdateData> selectedUpdateData;

  const UpdateList({Key? key, required this.selectedUpdateData})
      : super(key: key);

  @override
  State<UpdateList> createState() => _UpdateListState();
}

class _UpdateListState extends State<UpdateList> {
  bool isEditing = false;
  TextEditingController remarkController = TextEditingController();

  @override
  void dispose() {
    remarkController.dispose();
    super.dispose();
  }

  void startEditing() {
    setState(() {
      isEditing = true;
    });
  }

  void stopEditing() {
    setState(() {
      isEditing = false;
      remarkController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(188, 219, 255, 1),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, // Set the desired color for the leading icon
        ),
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Text(
              // Mock Data
              "Welcome to UM - VM2!",
              style: TextStyle(
                color: Colors.blue[900],
                fontSize: 20.0,
              ),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.home_outlined),
              iconSize: 35.0,
              color: Colors.black,
              onPressed: () {
                Navigator.of(context).pushNamed('/usermain');
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          const Text(
            'Update List',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.selectedUpdateData.length,
              itemBuilder: (context, index) {
                UpdateData updateData = widget.selectedUpdateData[index];
                return Card(
                  color: Colors.white, // Apply the gray color to the Card
                  elevation: 2,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 22, vertical: 4),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Image.asset(
                                updateData.product.photoUrl,
                                width: 90,
                                height: 100,
                              ),
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'RM${updateData.product.price.toStringAsFixed(2)}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20,
                                          color: Colors.green,
                                        ),
                                      ),
                                      Text(
                                        updateData.product.name,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      '${updateData.quantity}',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 40,
                        color: Colors.grey,
                        child: Row(
                          children: [
                            const SizedBox(width: 12),
                            Icon(Icons.edit, color: Colors.white),
                            const SizedBox(width: 4),
                            Expanded(
                              child: isEditing
                                  ? TextField(
                                      controller: remarkController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.all(0),
                                      ),
                                      style:
                                          const TextStyle(color: Colors.white),
                                      autofocus: true,
                                      onSubmitted: (_) => stopEditing(),
                                    )
                                  : InkWell(
                                      onTap: startEditing,
                                      child: Text(
                                        'Remark',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                            ),
                            if (isEditing)
                              IconButton(
                                icon: const Icon(Icons.check),
                                color: Colors.white,
                                onPressed: stopEditing,
                              ),
                            const SizedBox(width: 12),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: PurpleGradientButton(
              buttonText: 'Confirm',
              onPress: () {
                // Logic Here
                Navigator.of(context).pushNamed('/updatesuccess');
              },
            ),
          ),
        ],
      ),
    );
  }
}
