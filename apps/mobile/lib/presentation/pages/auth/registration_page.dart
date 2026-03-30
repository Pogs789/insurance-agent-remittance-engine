import 'package:flutter/material.dart';
import 'package:life_insurance_monitoring_mobile/core/constants/app_constants.dart';
    import 'package:life_insurance_monitoring_mobile/domain/entities/user.dart';

    class RegistrationPage extends StatefulWidget {
      const RegistrationPage({super.key});

      @override
      State<RegistrationPage> createState() => _RegistrationPageState();
    }

    class _RegistrationPageState extends State<RegistrationPage> {
      final _formKey = GlobalKey<FormState>();

      final _firstNameController = TextEditingController();
      final _middleNameController = TextEditingController();
      final _lastNameController = TextEditingController();
      final _insuranceCompanyController = TextEditingController();
      final _branchAddressController = TextEditingController();
      final _commissionRateController = TextEditingController();
      final _emailController = TextEditingController();
      final _passwordController = TextEditingController();

      DateTime? _birthDate;

      @override
      void dispose() {
        _firstNameController.dispose();
        _middleNameController.dispose();
        _lastNameController.dispose();
        _insuranceCompanyController.dispose();
        _branchAddressController.dispose();
        _commissionRateController.dispose();
        _emailController.dispose();
        _passwordController.dispose();
        super.dispose();
      }

      Future<void> _pickBirthDate() async {
        final now = DateTime.now();
        final initialDate = DateTime(now.year - 20, now.month, now.day);

        final picked = await showDatePicker(
          context: context,
          initialDate: _birthDate ?? initialDate,
          firstDate: DateTime(1900),
          lastDate: now,
        );

        if (picked != null) {
          setState(() {
            _birthDate = picked;
          });
        }
      }

      String? _requiredValidator(String? value, String fieldName) {
        if (value == null || value.trim().isEmpty) {
          return '$fieldName is required';
        }
        return null;
      }

      void _submit() {
        final isValid = _formKey.currentState?.validate() ?? false;

        if (_birthDate == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Birth date is required')),
          );
          return;
        }

        if (!isValid) return;

        final commissionRate = double.tryParse(_commissionRateController.text.trim());
        if (commissionRate == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Commission rate must be a valid number')),
          );
          return;
        }

        final user = UserEntity(
          firstName: _firstNameController.text.trim(),
          middleName: _middleNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
          birthDate: _birthDate!,
          insuranceCompany: _insuranceCompanyController.text.trim(),
          branchAddress: _branchAddressController.text.trim(),
          commissionRate: commissionRate,
          email: _emailController.text.trim(),
          rawPassword: _passwordController.text,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration data captured successfully')),
        );
        debugPrint('Registered user: ${user.email} - ${user.firstName} ${user.lastName}');
      }

      @override
      Widget build(BuildContext context) {
        final birthDateText = _birthDate == null
            ? 'Select birth date'
            : '${_birthDate!.year}-${_birthDate!.month.toString().padLeft(2, '0')}-${_birthDate!.day.toString().padLeft(2, '0')}';

        return Scaffold(
          appBar: AppBar(
            title: const Text('Registration Form'),
          ),
          body: SafeArea(
            child: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Text('Part 1: Basic Personal Information'),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: _buildTextFormField(
                          textEditingController: _firstNameController,
                          labelText: 'First Name',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildTextFormField(
                          textEditingController: _middleNameController,
                          labelText: 'Middle Name',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildTextFormField(
                          textEditingController: _lastNameController,
                          labelText: 'Last Name',
                        )
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Birth Date'),
                    subtitle: Text(birthDateText),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: _pickBirthDate,
                  ),
                  const SizedBox(height: 12),
                  _buildTextFormField(
                    textEditingController: _emailController,
                    labelText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    customValidator: (value) {
                      final requiredError = _requiredValidator(value, 'Email');
                      if (requiredError != null) return requiredError;

                      final email = value!.trim();
                      if (!email.contains('@') || !email.contains('.')) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildTextFormField(
                    textEditingController: _passwordController,
                    labelText: 'Password',
                    obscureText: true,
                    minLength: 6,
                    validationErrorMessage: 'Password must be at least 6 characters',
                  ),
                  const Divider(),
                  const SizedBox(height: 12),
                  _buildTextFormField(
                    textEditingController: _insuranceCompanyController,
                    labelText: 'Insurance Company',
                  ),
                  const SizedBox(height: 12),
                  _buildTextFormField(
                    textEditingController: _branchAddressController,
                    labelText: 'Branch Address',
                  ),
                  const SizedBox(height: 12),
                  _buildTextFormField(
                    textEditingController: _commissionRateController,
                    labelText: 'Commission Rate',
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    customValidator: (value) {
                      final requiredError = _requiredValidator(value, 'Commission rate');
                      if (requiredError != null) return requiredError;

                      final parsed = double.tryParse(value!.trim());
                      if (parsed == null) return 'Enter a valid number';
                      if (parsed < 0) return 'Commission rate cannot be negative';
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if(AppConstants.isUnderDevelopment) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Tool upgrades are underway to boost your productivity, agent. Please stay tuned.'
                            ),
                            backgroundColor: AppConstants.colorWarning,
                          )
                        );

                        return;
                      }

                      _submit();
                    },
                    child: const Text('Register'),
                  ),
                ],
              ),
            ),
          ),
        );
      }

      Widget _buildTextFormField({
        required TextEditingController textEditingController,
        required String labelText,
        bool obscureText = false,
        int minLength = 1,
        String? validationErrorMessage,
        TextInputType? keyboardType,
        String? Function(String?)? customValidator,
      }) {
        return TextFormField(
          controller: textEditingController,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            labelText: labelText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          obscureText: obscureText,
          validator: customValidator ??
              (value) {
                final requiredError = _requiredValidator(value, labelText);
                if (requiredError != null) return requiredError;

                if (value!.length < minLength) {
                  return validationErrorMessage ??
                      '$labelText must be at least $minLength characters';
                }
                return null;
              },
        );
      }
    }