import 'package:flutter/material.dart';

void main() => runApp(BytebankApp());

class BytebankApp extends StatelessWidget {
  const BytebankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: TransferList(),
      ),
    );
  }
}

class TransferForm extends StatefulWidget {
  @override
  _TransferFormState createState() => _TransferFormState();
}

class _TransferFormState extends State<TransferForm> {
  final TextEditingController _accountNumController = TextEditingController();

  final TextEditingController _valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criando Transferência'),
        backgroundColor: Colors.green[900],
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Editor(
            newController: _accountNumController,
            newLabel: 'Número da Conta',
            newHint: '0000',
          ),
          Editor(
            newController: _valueController,
            newLabel: 'Valor',
            newHint: '0.00',
            newIcon: Icons.monetization_on,
          ),
          ElevatedButton(
            child: Text('Confirmar'),
            onPressed: () => _createTransfer(context),
          ),
        ]),
      ),
    );
  }

  void _createTransfer(BuildContext context) {
    final int? accountNum = int.tryParse(_accountNumController.text);
    final double? value = double.tryParse(_valueController.text);
    if (accountNum != null && value != null) {
      final newTransfer = Transfer(value, accountNum);
      Navigator.pop(context, newTransfer);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Transferencia{valor: $value, numeroConta: $accountNum}',
          ),
        ),
      );
    }
  }
}

class Editor extends StatelessWidget {
  final TextEditingController? newController;
  final String? newLabel;
  final String? newHint;
  final IconData? newIcon;

  Editor({this.newController, this.newLabel, this.newHint, this.newIcon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: newController,
        style: TextStyle(fontSize: 24.0),
        decoration: InputDecoration(
          icon: newIcon != null ? Icon(newIcon) : null,
          labelText: newLabel,
          hintText: newHint,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

class TransferList extends StatefulWidget {
  final List<Transfer> _transfer = [];

  @override
  State<StatefulWidget> createState() => TransferListState();
}

class TransferListState extends State<TransferList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferências'),
        backgroundColor: Colors.green.shade900,
      ),
      body: ListView.builder(
        itemCount: widget._transfer.length,
        itemBuilder: (context, index) {
          final transfer = widget._transfer[index];
          return TransferItem(transfer);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          final Future future = Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return TransferForm();
            }),
          );
          future.then((receivedTransfer) {
            Future.delayed(Duration(seconds: 1), () {
              debugPrint('Chegou no then do future');
              debugPrint('$receivedTransfer');
              if (receivedTransfer != null) {
                setState(() => widget._transfer.add(receivedTransfer));
              }
            });
          });
        },
        backgroundColor: Colors.green.shade900,
      ),
    );
  }
}

class TransferItem extends StatelessWidget {
  final Transfer _transfer;

  TransferItem(this._transfer);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on, color: Colors.grey),
        title: Text(this._transfer.value.toStringAsFixed(2)),
        subtitle: Text(this._transfer.accountNum.toString()),
      ),
    );
  }
}

class Transfer {
  final double value;
  final int accountNum;

  Transfer(this.value, this.accountNum);

  @override
  String toString() {
    return 'Transferencia{valor: $value, numeroConta: $accountNum}';
  }
}
