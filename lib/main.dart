import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const AlunosTechDeskApp());
}

class AlunosTechDeskApp extends StatelessWidget {
  const AlunosTechDeskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AlunosTechDesk',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF004085),
        scaffoldBackgroundColor: const Color(0xFFE9ECEF),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF004085),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
        ),
      ),
      home: const TelaLogin(),
    );
  }
}

// ==========================================
// TELA DE LOGIN
// ==========================================
class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  
  String _mensagem = '';
  Color _corMensagem = Colors.red;

  Future<void> fazerLogin() async {
    final email = _emailController.text;
    final senha = _senhaController.text;

    if (email.isEmpty || senha.isEmpty) {
      setState(() {
        _mensagem = 'Preencha todos os campos!';
        _corMensagem = Colors.red;
      });
      return;
    }

    try {
      final pacoteJson = json.encode({
        "id": 0,
        "nome": "Login",
        "email": email,
        "senha": senha,
        "perfil": "Aluno"
      });

      final url = Uri.parse('http://localhost:5285/api/Usuarios/Login');
      
      final resposta = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: pacoteJson,
      );

      if (resposta.statusCode == 200) {
        setState(() {
          _mensagem = 'Login efetuado! A entrar...';
          _corMensagem = Colors.green;
        });
        
        // O XEQUE-MATE: Espera 1 segundo e muda de ecrã!
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const TelaPainel()),
          );
        });
        
      } else {
        setState(() {
          _mensagem = 'E-mail ou palavra-passe incorretos.';
          _corMensagem = Colors.red;
        });
      }
    } catch (e) {
      setState(() {
        _mensagem = 'Erro ao ligar ao servidor. A API está a correr?';
        _corMensagem = Colors.red;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 350,
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15)
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'AlunosTechDesk',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF004085),
                  ),
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: _senhaController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Palavra-passe',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: fazerLogin,
                    child: const Text('Entrar', style: TextStyle(fontSize: 16)),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  _mensagem,
                  style: TextStyle(color: _corMensagem, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// TELA DO PAINEL (LISTA DE CHAMADOS)
// ==========================================
class TelaPainel extends StatefulWidget {
  const TelaPainel({super.key});

  @override
  State<TelaPainel> createState() => _TelaPainelState();
}

class _TelaPainelState extends State<TelaPainel> {
  List<dynamic> _chamados = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    carregarChamados();
  }

  // Função que puxa os dados do C#
  Future<void> carregarChamados() async {
    try {
      final url = Uri.parse('http://localhost:5285/api/Chamados');
      final resposta = await http.get(url);

      if (resposta.statusCode == 200) {
        setState(() {
          _chamados = json.decode(resposta.body);
          _carregando = false;
        });
      }
    } catch (e) {
      setState(() {
        _carregando = false;
      });
    }
  }

  void sair() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const TelaLogin()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Painel de Chamados', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF004085),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: sair,
            tooltip: 'Sair',
          )
        ],
      ),
      body: _carregando
          ? const Center(child: CircularProgressIndicator()) // Mostra o ícone a girar enquanto carrega
          : ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: _chamados.length,
              itemBuilder: (context, index) {
                final chamado = _chamados[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 15),
                  elevation: 2,
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Color(0xFFFFF3CD),
                      child: Icon(Icons.computer, color: Color(0xFF856404)),
                    ),
                    title: Text(
                      chamado['titulo'] ?? 'Sem Título',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Solicitante: ${chamado['solicitante']}'),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF3CD),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        chamado['status'] ?? 'Aberto',
                        style: const TextStyle(color: Color(0xFF856404), fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}