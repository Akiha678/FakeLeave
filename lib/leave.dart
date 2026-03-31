import 'package:flutter/material.dart';

import 'leave_detail.dart';

class LeaveListPage extends StatelessWidget {
  const LeaveListPage({super.key});

  static const List<_LeaveItem> _items = <_LeaveItem>[
    _LeaveItem(
      type: '事假',
      reason: '拿快递',
      start: '2026-03-12 08:11',
      end: '2026-03-12 13:12',
      status: '审批通过',
    ),
    _LeaveItem(
      type: '事假',
      reason: '拿快递',
      start: '2026-03-09 16:40',
      end: '2026-03-09 18:40',
      status: '审批通过',
    ),
    _LeaveItem(
      type: '事假',
      reason: '拿快递',
      start: '2025-12-04 11:11',
      end: '2025-12-04 13:20',
      status: '审批通过',
    ),
    _LeaveItem(
      type: '事假',
      reason: '拿快递',
      start: '2025-11-28 08:00',
      end: '2025-11-28 17:35',
      status: '审批通过',
    ),
    _LeaveItem(
      type: '事假',
      reason: '拿快递',
      start: '2025-11-27 09:37',
      end: '2025-11-27 11:37',
      status: '审批通过',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F4),
      body: SafeArea(
        child: Column(
          children: [
            const _TopBar(),
            Expanded(
              child: ListView.builder(
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 84),
                itemCount: _items.length,
                itemBuilder: (BuildContext context, int index) {
                  final _LeaveItem item = _items[index];
                  return _LeaveCard(
                    item: item,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              const LeaveDetailPage(),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: 124,
        height: 40,
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const LeaveDetailPage(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: const Color(0xFFF39A49),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
            ),
            padding: EdgeInsets.zero,
          ),
          child: const Text(
            '立即申请',
            style: TextStyle(
              fontSize: 17,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: const [
          Text(
            '请假',
            style: TextStyle(
              fontSize: 36 / 2,
              color: Color(0xFF1D1D1D),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _LeaveCard extends StatelessWidget {
  const _LeaveCard({required this.item, required this.onTap});

  final _LeaveItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
            child: Column(
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 68,
                      child: Text(
                        '请假类型',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFFA6A6A9),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        item.type,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Color(0xFF4A4A4A),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    _StatusTag(text: item.status),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const SizedBox(
                      width: 68,
                      child: Text(
                        '申请事项',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFFA6A6A9),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        item.reason,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Color(0xFF4A4A4A),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 68,
                      child: Text(
                        '请假时间',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFFA6A6A9),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${item.start} 至',
                            style: const TextStyle(
                              fontSize: 34 / 2,
                              color: Color(0xFF5897EB),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.end,
                            style: const TextStyle(
                              fontSize: 34 / 2,
                              color: Color(0xFF5897EB),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatusTag extends StatelessWidget {
  const _StatusTag({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF7BCF96), width: 1.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          color: Color(0xFF56BD7C),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _LeaveItem {
  const _LeaveItem({
    required this.type,
    required this.reason,
    required this.start,
    required this.end,
    required this.status,
  });

  final String type;
  final String reason;
  final String start;
  final String end;
  final String status;
}
