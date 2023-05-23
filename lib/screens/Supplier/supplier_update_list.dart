import "package:flutter/material.dart";

class SupplierUpdateList extends StatefulWidget {
  const SupplierUpdateList({super.key});

  @override
  State<SupplierUpdateList> createState() => _SupplierUpdateListState();
}

class _SupplierUpdateListState extends State<SupplierUpdateList> {
  String dropdownvalue = 'One';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(188, 219, 255, 1),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Text(
          'Welcome to UM - VM 2!',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
    );
  }
}
