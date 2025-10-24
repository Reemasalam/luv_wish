import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luve_wish/CartScreen/Services/CheckoutController.dart';

class AddressFormScreen extends StatefulWidget {
  final Map<String, dynamic>? initialData;
  const AddressFormScreen({super.key, this.initialData});

  @override
  State<AddressFormScreen> createState() => _AddressFormScreenState();
}

class _AddressFormScreenState extends State<AddressFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late CheckoutController controller;
  bool _hasFetched = false;

  late TextEditingController nameController;
  late TextEditingController addressController;
  late TextEditingController cityController;
  late TextEditingController stateController;
  late TextEditingController postalCodeController;
  late TextEditingController countryController;

  late TextEditingController phoneController;
  bool isDefault = true;

  @override
  void initState() {
    super.initState();

    // ✅ Use existing controller safely
    controller = Get.find<CheckoutController>();

    // ✅ Fetch addresses only once after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_hasFetched && controller.addresses.isEmpty) {
        _hasFetched = true;
        controller.fetchAddresses();
      }
    });

    nameController = TextEditingController(text: widget.initialData?['name'] ?? '');
    addressController = TextEditingController(text: widget.initialData?['address'] ?? '');
    cityController = TextEditingController(text: widget.initialData?['city'] ?? '');
    stateController = TextEditingController(text: widget.initialData?['state'] ?? '');
    postalCodeController = TextEditingController(text: widget.initialData?['postalCode'] ?? '');
    countryController = TextEditingController(text: widget.initialData?['country'] ?? '');
    
    phoneController = TextEditingController(text: widget.initialData?['phone'] ?? '');
    isDefault = widget.initialData?['isDefault'] ?? true;
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    cityController.dispose();
    stateController.dispose();
    postalCodeController.dispose();
    countryController.dispose();
    
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.initialData != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? 'Edit Address' : 'Add Address',
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Obx(() {
        return Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    buildTextField('Full Name', nameController),
                    buildTextField('Address', addressController, maxLines: 2),
                    buildTextField('City', cityController),
                    buildTextField('State', stateController),
                    buildTextField('Postal Code', postalCodeController),
                    buildTextField('Country', countryController),
                  
                    buildTextField('Phone', phoneController, keyboardType: TextInputType.phone),
                    const SizedBox(height: 10),
                    SwitchListTile(
                      title: const Text('Set as default address'),
                      value: isDefault,
                      onChanged: (val) => setState(() => isDefault = val),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffF83758),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: controller.isLoading.value
                          ? null
                          : () async {
                              if (_formKey.currentState!.validate()) {
                                final data = {
                                  "customerProfileId": "c12345", // can make dynamic later
                                  "name": nameController.text.trim(),
                                  "address": addressController.text.trim(),
                                  "city": cityController.text.trim(),
                                  "state": stateController.text.trim(),
                                  "postalCode": postalCodeController.text.trim(),
                                  "country": countryController.text.trim(),
                                 
                                  "phone": phoneController.text.trim(),
                                  "isDefault": isDefault,
                                };

                                final success = await controller.addAddress(data);

                                if (success && mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Address saved successfully!"),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                  Navigator.pop(context, true);
                                } else if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        controller.error.value ?? "Failed to save address",
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              }
                            },
                      child: controller.isLoading.value
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                              isEditing ? 'Update Address' : 'Save Address',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),

            if (controller.isLoading.value)
              Container(
                color: Colors.black.withOpacity(0.2),
                child: const Center(child: CircularProgressIndicator(color: Colors.pink)),
              ),
          ],
        );
      }),
    );
  }

  Widget buildTextField(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: (val) => val == null || val.isEmpty ? '$label required' : null,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
