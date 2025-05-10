import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dsa.dart';

class DSAScreen extends StatefulWidget {
  final List<Map<String, dynamic>> Data;

  const DSAScreen({super.key, required this.Data});

  @override
  State<DSAScreen> createState() => _DSAScreenState();
}

class _DSAScreenState extends State<DSAScreen> {
  int? expandedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF252526),
        title: const Text(
          'DSA Questions & Solutions',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              // Toggle theme functionality would go here
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Search functionality would go here
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.Data.length,
              itemBuilder: (context, index) {
                final item = widget.Data[index];
                final isExpanded = expandedIndex == index;

                // Split solution to separate explanation and code
                final parts = item['solution']!.split('```');
                final explanation = parts[0].trim();

                String code = '';
                String language = '';

                if (parts.length > 1) {
                  final codeBlock = parts[1].trim();
                  final codeLines = codeBlock.split('\n');

                  if (codeLines.isNotEmpty) {
                    language = codeLines[0]; // This should be 'python' in our case
                    code = codeLines.sublist(1).join('\n');
                  }
                }

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  color: const Color(0xFF252526),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                      color: isExpanded ? Colors.blueAccent : Colors.transparent,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Question header
                      ListTile(
                        title: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blueGrey.shade700,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                '#${item['id']}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                item['question']!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            isExpanded
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: Colors.blueAccent,
                          ),
                          onPressed: () {
                            setState(() {
                              expandedIndex = isExpanded ? null : index;
                            });
                          },
                        ),
                      ),

                      // Expanded solution
                      if (isExpanded)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Divider(color: Color(0xFF3C3C3C)),
                              // Explanation text
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  explanation,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),

                              // Custom code editor widget
                              if (code.isNotEmpty)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Code editor header
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF2D2D2D),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(6),
                                          topRight: Radius.circular(6),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            language,
                                            style: TextStyle(
                                              color: Colors.grey.shade400,
                                              fontSize: 12,
                                            ),
                                          ),
                                          const Spacer(),
                                          Row(
                                            children: [
                                              IconButton(
                                                icon: const Icon(Icons.copy, size: 16),
                                                padding: EdgeInsets.zero,
                                                constraints: const BoxConstraints(),
                                                color: Colors.grey.shade400,
                                                onPressed: () {
                                                  Clipboard.setData(ClipboardData(text: code));
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    const SnackBar(
                                                      content: Text('Code copied to clipboard'),
                                                      duration: Duration(seconds: 1),
                                                    ),
                                                  );
                                                },
                                              ),
                                              const SizedBox(width: 16),
                                              IconButton(
                                                icon: const Icon(Icons.play_arrow, size: 16),
                                                padding: EdgeInsets.zero,
                                                constraints: const BoxConstraints(),
                                                color: Colors.green,
                                                onPressed: () {
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    const SnackBar(
                                                      content: Text('Code execution would start here'),
                                                      duration: Duration(seconds: 1),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Custom syntax highlighting with RichText
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF1E1E1E),
                                        border: Border.all(color: const Color(0xFF3C3C3C)),
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(6),
                                          bottomRight: Radius.circular(6),
                                        ),
                                      ),
                                      child: CodeSyntaxHighlighter(
                                        code: code,
                                        language: language,
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Bottom status bar (like VS Code)
          Container(
            height: 24,
            color: const Color(0xFF007ACC),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Text(
                  'DSA Editor',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                const Spacer(),
                Text(
                  '${dsaData.length} questions',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add),
        onPressed: () {
          // Add new question functionality
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Add new question feature would go here'),
              duration: Duration(seconds: 1),
            ),
          );
        },
      ),
    );
  }
}

// Custom widget for syntax highlighting using RichText
class CodeSyntaxHighlighter extends StatelessWidget {
  final String code;
  final String language;

  const CodeSyntaxHighlighter({
    super.key,
    required this.code,
    required this.language,
  });

  @override
  Widget build(BuildContext context) {
    final lines = code.split('\n');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < lines.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Line number
                SizedBox(
                  width: 30,
                  child: Text(
                    '${i + 1}',
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                const SizedBox(width: 10),
                // Line content with syntax highlighting
                Expanded(
                  child: _highlightLine(lines[i]),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _highlightLine(String line) {
    final List<TextSpan> spans = [];

    // Process the line - this is a simplified version
    final parts = line.split(RegExp(r'(\s+)'));

    for (final part in parts) {
      if (part.isEmpty) continue;

      if (part.trim().isEmpty) {
        // Spaces
        spans.add(TextSpan(
          text: part,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ));
      } else if (_isPythonKeyword(part)) {
        // Keywords (purple)
        spans.add(TextSpan(
          text: part,
          style: TextStyle(
            color: Colors.purple.shade300,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ));
      } else if (_isPythonBuiltIn(part)) {
        // Built-in functions (blue)
        spans.add(TextSpan(
          text: part,
          style: TextStyle(
            color: Colors.blue.shade300,
            fontSize: 12,
          ),
        ));
      } else if (part.startsWith('#')) {
        // Comments (green)
        spans.add(TextSpan(
          text: part,
          style: TextStyle(
            color: Colors.green.shade300,
            fontSize: 12,
            fontStyle: FontStyle.italic,
          ),
        ));
      } else if (_isNumber(part)) {
        // Numbers (yellow-orange)
        spans.add(TextSpan(
          text: part,
          style: TextStyle(
            color: Colors.amber.shade300,
            fontSize: 12,
          ),
        ));
      } else if (part.startsWith('"') || part.startsWith("'") ||
          part.endsWith('"') || part.endsWith("'")) {
        // Strings (green)
        spans.add(TextSpan(
          text: part,
          style: TextStyle(
            color: Colors.green.shade300,
            fontSize: 12,
          ),
        ));
      } else if (_isOperator(part)) {
        // Operators (yellow)
        spans.add(TextSpan(
          text: part,
          style: TextStyle(
            color: Colors.yellow.shade300,
            fontSize: 12,
          ),
        ));
      } else if (_isFunctionOrMethod(line, part)) {
        // Function definitions or calls (cyan)
        spans.add(TextSpan(
          text: part,
          style: TextStyle(
            color: Colors.cyan.shade300,
            fontSize: 12,
          ),
        ));
      } else {
        // Default text color (white)
        spans.add(TextSpan(
          text: part,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ));
      }
    }

    return RichText(
      text: TextSpan(
        children: spans,
      ),
    );
  }

  // Helper methods for syntax highlighting (unchanged)
  bool _isPythonKeyword(String word) {
    const keywords = [
      'False', 'None', 'True', 'and', 'as', 'assert', 'async', 'await',
      'break', 'class', 'continue', 'def', 'del', 'elif', 'else', 'except',
      'finally', 'for', 'from', 'global', 'if', 'import', 'in', 'is',
      'lambda', 'nonlocal', 'not', 'or', 'pass', 'raise', 'return',
      'try', 'while', 'with', 'yield'
    ];
    return keywords.contains(word);
  }

  bool _isPythonBuiltIn(String word) {
    const builtIns = [
      'abs', 'all', 'any', 'bin', 'bool', 'bytearray', 'bytes', 'callable',
      'chr', 'classmethod', 'compile', 'complex', 'delattr', 'dict', 'dir',
      'divmod', 'enumerate', 'eval', 'exec', 'filter', 'float', 'format',
      'frozenset', 'getattr', 'globals', 'hasattr', 'hash', 'help', 'hex',
      'id', 'input', 'int', 'isinstance', 'issubclass', 'iter', 'len',
      'list', 'locals', 'map', 'max', 'memoryview', 'min', 'next', 'object',
      'oct', 'open', 'ord', 'pow', 'print', 'property', 'range', 'repr',
      'reversed', 'round', 'set', 'setattr', 'slice', 'sorted', 'staticmethod',
      'str', 'sum', 'super', 'tuple', 'type', 'vars', 'zip'
    ];
    return builtIns.contains(word);
  }

  bool _isNumber(String word) {
    return RegExp(r'^-?\d+(\.\d+)?$').hasMatch(word);
  }

  bool _isOperator(String word) {
    const operators = ['+', '-', '*', '/', '%', '=', '==', '!=', '<', '>', '<=', '>=', '(', ')', '[', ']', '{', '}', ',', ':', '.'];
    return operators.contains(word);
  }

  bool _isFunctionOrMethod(String line, String word) {
    return line.contains('$word(') || line.contains('def $word');
  }
}