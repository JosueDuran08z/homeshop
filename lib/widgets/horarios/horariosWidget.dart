import 'package:flutter/material.dart';
import 'package:homeshop/widgets/horarios/agregarHorarioWidget.dart';

class HorariosWidget extends StatefulWidget {
  HorariosWidget({Key? key}) : super(key: key);

  @override
  State<HorariosWidget> createState() => _HorariosWidgetState();
}

class _HorariosWidgetState extends State<HorariosWidget> {
  void _agregarHorario() {
    final route = MaterialPageRoute(
        builder: (BuildContext context) => AgregarHorarioWidget());
    Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mis Horarios"),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Mis Horarios",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red[600],
                ),
              ),
              ElevatedButton(
                onPressed: _agregarHorario,
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue[600],
                  padding: const EdgeInsets.only(
                    left: 10,
                    top: 5,
                    right: 10,
                    bottom: 5,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Icon(
                  Icons.add,
                  size: 18,
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
