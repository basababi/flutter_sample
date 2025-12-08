// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '/common/colo_extention.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class TimerPage extends StatefulWidget {
//   final String title;
//   final Duration initialDuration;

//   const TimerPage({
//     super.key,
//     required this.title,
//     required this.initialDuration,
//   });

//   @override
//   State<TimerPage> createState() => _TimerPageState();
// }

// class _TimerPageState extends State<TimerPage> {
//   late Duration remaining;
//   Timer? _timer;
//   bool isRunning = false;
//   late DateTime _startedAt;

//   @override
//   void initState() {
//     super.initState();
//     remaining = widget.initialDuration;
//   }

//   void _start() {
//     if (isRunning) return;
//     setState(() {
//       isRunning = true;
//       _startedAt = DateTime.now();
//     });

//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (remaining.inSeconds <= 1) {
//         timer.cancel();
//         setState(() {
//           remaining = Duration.zero;
//           isRunning = false;
//         });
//         _onComplete();
//       } else {
//         setState(() {
//           remaining = remaining - const Duration(seconds: 1);
//         });
//       }
//     });
//   }

//   void _pause() {
//     _timer?.cancel();
//     setState(() => isRunning = false);
//   }

//   void _reset() {
//     _timer?.cancel();
//     setState(() {
//       remaining = widget.initialDuration;
//       isRunning = false;
//     });
//   }

//   String _formatDuration(Duration d) {
//     final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
//     final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
//     return '$minutes:$seconds';
//   }

//   Future<void> _onComplete() async {
//     final finishedAt = DateTime.now();
//     final elapsed = finishedAt.difference(_startedAt);
//     final payload = {
//       'title': widget.title,
//       'planned_minutes': widget.initialDuration.inMinutes,
//       'elapsed_seconds': elapsed.inSeconds,
//       'started_at': _startedAt.toIso8601String(),
//       'finished_at': finishedAt.toIso8601String(),
//     };

//     await _saveLocally(payload);

//     if (!mounted) return;
//     _showSnack('Дасгал дууслаа — локалд хадгалав');
//   }

//   Future<void> _saveLocally(Map<String, dynamic> payload) async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       const key = 'completed_workouts';
//       final list = prefs.getStringList(key) ?? [];
//       list.add(jsonEncode(payload));
//       await prefs.setStringList(key, list);
//     } catch (e) {
//       // Хэрэв хадгалах үед алдаа гарвал хэрэглэгчид үзүүлэх
//       if (mounted) _showSnack('Локал хадгалалтад алдаа гарлаа');
//     }
//   }

//   void _showSnack(String text) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }

//   // Тус helper нь локалд хадгалагдсан бүх дууссан дасгалуудыг харуулахад ашиглана
//   static Future<List<Map<String, dynamic>>> readAllSavedSessions() async {
//     final prefs = await SharedPreferences.getInstance();
//     const key = 'completed_workouts';
//     final list = prefs.getStringList(key) ?? [];
//     return list.map((s) {
//       try {
//         return jsonDecode(s) as Map<String, dynamic>;
//       } catch (_) {
//         return <String, dynamic>{};
//       }
//     }).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final accent = TColor.primaryColor2 ?? const Color(0xFF7B4BFF);

//     return Scaffold(
//       backgroundColor: const Color(0xFF111111),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF111111),
//         elevation: 0,
//         title: Text(widget.title, style: GoogleFonts.poppins()),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               _formatDuration(remaining),
//               style: TextStyle(
//                 fontSize: 56,
//                 color: accent,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 24),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ElevatedButton(
//                   onPressed: isRunning ? _pause : _start,
//                   style: ElevatedButton.styleFrom(backgroundColor: accent),
//                   child: Text(isRunning ? 'Pause' : 'Start'),
//                 ),
//                 const SizedBox(width: 12),
//                 OutlinedButton(onPressed: _reset, child: const Text('Reset')),
//                 const SizedBox(width: 12),
//                 ElevatedButton(
//                   onPressed: () async {
//                     // Хэрэглэгч хүсвэл нөхцөлгүйгээр дууссана гэж тэмдэглэж локалд хадгалах
//                     if (isRunning) {
//                       _pause();
//                     }
//                     final finishedAt = DateTime.now();
//                     final elapsed = widget.initialDuration - remaining;
//                     final payload = {
//                       'title': widget.title,
//                       'planned_minutes': widget.initialDuration.inMinutes,
//                       'elapsed_seconds': elapsed.inSeconds,
//                       'started_at': (_startedAt != null)
//                           ? _startedAt.toIso8601String()
//                           : null,
//                       'finished_at': finishedAt.toIso8601String(),
//                       'manually_stopped': true,
//                     };
//                     await _saveLocally(payload);
//                     if (mounted) _showSnack('Сесс локалд хадгалагдлаа');
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.grey[700],
//                   ),
//                   child: const Text('Stop & Save'),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             FutureBuilder<List<Map<String, dynamic>>>(
//               future: readAllSavedSessions(),
//               builder: (context, snap) {
//                 if (!snap.hasData) return const SizedBox.shrink();
//                 final sessions = snap.data!;
//                 if (sessions.isEmpty) {
//                   return const Text(
//                     'Локалд хадгалагдсан сесс байхгүй',
//                     style: TextStyle(color: Colors.white70),
//                   );
//                 }
//                 return Padding(
//                   padding: const EdgeInsets.only(top: 20.0),
//                   child: SizedBox(
//                     height: 120,
//                     child: ListView.builder(
//                       itemCount: sessions.length,
//                       itemBuilder: (context, i) {
//                         final s = sessions[i];
//                         return ListTile(
//                           title: Text(
//                             s['title'] ?? '—',
//                             style: const TextStyle(color: Colors.white70),
//                           ),
//                           subtitle: Text(
//                             'Elapsed: ${s['elapsed_seconds'] ?? 0}s',
//                             style: const TextStyle(color: Colors.white38),
//                           ),
//                           dense: true,
//                         );
//                       },
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
