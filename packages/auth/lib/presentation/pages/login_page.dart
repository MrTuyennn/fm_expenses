import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:service/service.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _loading = false;

  Future<void> _testApi() async {
    setState(() => _loading = true);
    try {
      final client = sl<IRestClient>();
      var params = {"username": "ROT", "password": "rot123"};
      String str = jsonEncode(params);
      final res = await client.post('/auth/login', str);
      final status = res?.statusCode;
      final data = res?.data;

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('GET /get -> status=$status, data=$data')),
      );
    } catch (e, st) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('API error: $e')));
      // Optional: debug log
      // ignore: avoid_print
      print(st);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 300,
          height: 48,
          child: FilledButton(
            onPressed: _loading ? null : _testApi,
            child: Text(_loading ? 'Loading...' : 'Login (test API)'),
          ),
        ),
      ),
    );
  }
}
