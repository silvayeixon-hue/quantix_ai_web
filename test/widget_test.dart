import 'package:flutter_test/flutter_test.dart';
import 'package:quantix_ia/main.dart';

void main() {
  testWidgets('Quantix AI Smoke Test', (WidgetTester tester) async {
    // Esto construye la app QuantixAI y verifica que arranque sin cerrarse
    await tester.pumpWidget(const QuantixAI());
    
    // Verificamos que al menos cargue la interfaz básica
    expect(find.byType(QuantixAI), findsOneWidget);
  });
}