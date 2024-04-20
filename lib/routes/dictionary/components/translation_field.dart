import 'package:flutter/material.dart';
import 'package:languages/models/language.dart';
import 'package:micha_core/micha_core.dart';

class TranslationField extends StatefulWidget {
  final Language originLanguage;
  final Language targetLanguage;

  final void Function(String originPhrase, String targetPhrase) addTranslation;

  const TranslationField({
    super.key,
    required this.originLanguage,
    required this.targetLanguage,
    required this.addTranslation,
  });

  @override
  State<TranslationField> createState() => _TranslationFieldState();
}

class _TranslationFieldState extends State<TranslationField> {
  final _formKey = GlobalKey<FormState>();
  final _originTextController = TextEditingController();
  final _targetTextController = TextEditingController();

  String _originPhrase = '';
  String _targetPhrase = '';

  void _submit() {
    final formState = _formKey.currentState;

    if (formState == null || !formState.validate()) return;
    formState.save();

    widget.addTranslation(_originPhrase, _targetPhrase);
    _clear();
  }

  void _clear() {
    _originTextController.clear();
    _targetTextController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _originTextController,
                  decoration: InputDecoration(
                    labelText: widget.originLanguage.displayName,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Bitte Wort eingeben.';
                    }
                    return null;
                  },
                  onSaved: (value) => _originPhrase = value ?? '',
                ),
                TextFormField(
                  controller: _targetTextController,
                  decoration: InputDecoration(
                    labelText: widget.targetLanguage.displayName,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Bitte Wort eingeben.';
                    }
                    return null;
                  },
                  onSaved: (value) => _targetPhrase = value ?? '',
                ),
              ].separated(const Gap()),
            ),
          ),
          IconButton(
            onPressed: _submit,
            icon: const Icon(Icons.add),
          ),
        ].separated(const Gap()),
      ),
    );
  }
}
