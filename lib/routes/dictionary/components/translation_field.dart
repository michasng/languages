import 'package:flutter/material.dart';
import 'package:languages/models/category.dart';
import 'package:languages/models/language.dart';
import 'package:languages/models/term.dart';
import 'package:micha_core/micha_core.dart';

class TranslationField extends StatefulWidget {
  final LanguagePair languages;

  final void Function(Term term) addTerm;

  const TranslationField({
    super.key,
    required this.languages,
    required this.addTerm,
  });

  @override
  State<TranslationField> createState() => _TranslationFieldState();
}

class _TranslationFieldState extends State<TranslationField> {
  final _formKey = GlobalKey<FormState>();
  final _originTextController = TextEditingController();
  final _targetTextController = TextEditingController();

  String _origin = '';
  String _target = '';

  void _submit() {
    final formState = _formKey.currentState;

    if (formState == null || !formState.validate()) return;
    formState.save();

    widget.addTerm(
      Term(
        origin: _origin,
        target: _target,
        category: const Category(
          origin: 'Meine Wörter',
          target: 'Мои слова',
        ),
      ),
    );
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
                    labelText: widget.languages.origin.displayName,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Bitte Wort eingeben.';
                    }
                    return null;
                  },
                  onSaved: (value) => _origin = value ?? '',
                ),
                TextFormField(
                  controller: _targetTextController,
                  decoration: InputDecoration(
                    labelText: widget.languages.target.displayName,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Bitte Wort eingeben.';
                    }
                    return null;
                  },
                  onSaved: (value) => _target = value ?? '',
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
