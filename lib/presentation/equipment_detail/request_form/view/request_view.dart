import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../domain/models/request.dart';
import '../../../../services/firebase/firestore_services.dart';
import '../../../../shared/widgets/center_app_bar.dart';

class RequestForm extends StatefulWidget {
  final String name;
  final String docId;

  const RequestForm({Key? key, required this.name, required this.docId})
      : super(key: key);

  @override
  RequestFormState createState() => RequestFormState();
}

class RequestFormState extends State<RequestForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController scheduleController = TextEditingController();
  final TextEditingController purposeController = TextEditingController();
  DateTime? selectedDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CenterAppBar('List of Requested Equipment', context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Input your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: positionController,
                decoration: const InputDecoration(labelText: 'Position'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Input your position';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: scheduleController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Schedule',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () async {
                      final currentDate = DateTime.now();
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: this.selectedDate ?? currentDate,
                        firstDate: currentDate,
                        lastDate: DateTime(currentDate.year + 1),
                      );

                      if (selectedDate != null) {
                        setState(() {
                          this.selectedDate = selectedDate;
                          scheduleController.text =
                              DateFormat('yyyy-MM-dd').format(selectedDate);
                        });
                      }
                    },
                  ),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Select a schedule';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: purposeController,
                decoration: const InputDecoration(labelText: 'Purpose'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Input the purpose';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            final user = FirebaseAuth.instance.currentUser;

            if (user != null) {
              final request = Request(
                name: nameController.text,
                position: positionController.text,
                schedule: DateFormat('yyyy-MM-dd').format(selectedDate!),
                purpose: purposeController.text,
              );

              await addRequest(
                name: request.name,
                position: request.position,
                schedule: request.schedule,
                purpose: request.purpose,
                code: widget.docId,
              );

              final Map<String, dynamic> data = {
                'isAssigned': true,
                'assignedTo': request.name,
              };

              final DocumentReference documentReferencer = FirebaseFirestore
                  .instance
                  .collection('equipment')
                  .doc(widget.docId);

              await documentReferencer.update(data).whenComplete(() {
                if (kDebugMode) {
                  print('Equipment updated');
                }

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Success'),
                      content: const Text('Request submitted successfully.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              }).catchError((e) {
                if (kDebugMode) {
                  print('Error: $e');
                }
              });
            }
          }
        },
        child: const Text('Request'),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    positionController.dispose();
    scheduleController.dispose();
    purposeController.dispose();
    super.dispose();
  }
}
