import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '请假',
      home: const LeavePage(),
    );
  }
}

class LeavePage extends StatefulWidget {
  const LeavePage({super.key});

  @override
  State<LeavePage> createState() => _LeavePageState();
}

class _LeavePageState extends State<LeavePage> {
  final ScrollController _controller = ScrollController();

  final Map<String, String> _values = <String, String>{
    'leaveStatus': '正在休假',
    'name': '陈鑫',
    'studentId': '202311278',
    'className': '软工2301',
    'department': '信息工程学院',
    'leaveType': '事假',
    'leaveLocation': '湖北省-荆州市-荆州区',
    'leaveReason': '董事长来实验室检查',
    'destinationLocation': '湖北省-荆州市-荆州区',
    'destinationDetail': '智能终端实验室',
    'travelMode': '步行',
    'exitCampus': '荆州学院',
    'exitGate': '东大门',
    'entryCampus': '荆州学院',
    'entryGate': '东大门',
    'leaveStart': '2026-3-15 08:00',
    'leaveEnd': '2026-3-15 17:35',
    'approver': '牛家鑫',
    'flowApplicant': '陈鑫',
    'flowSubmitAction': '提交申请',
    'flowSubmitTime': '2026-3-15 12:29:15',
    'flowReviewer': '牛家鑫',
    'flowResult': '同意并终止',
    'flowComment': '无',
    'flowReviewTime': '2026-3-15 19:29:15',
  };

  String _v(String key) => _values[key] ?? '';

  Future<void> _editField(String key, String label) async {
    String editedText = _v(key);
    final String? result = await showDialog<String>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('修改$label'),
          content: TextFormField(
            initialValue: editedText,
            autofocus: true,
            onChanged: (String value) => editedText = value,
            decoration: InputDecoration(
              hintText: '请输入$label',
              border: const OutlineInputBorder(),
              isDense: true,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(editedText),
              child: const Text('保存'),
            ),
          ],
        );
      },
    );

    if (result == null || result == _v(key)) {
      return;
    }

    setState(() {
      _values[key] = result;
      if (key == 'name') {
        _values['flowApplicant'] = result;
      }
      if (key == 'approver') {
        _values['flowReviewer'] = result;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            const _Header(),
            const SizedBox(height: 14),
            const _Tabs(),
            Expanded(
              child: Scrollbar(
                controller: _controller,
                thumbVisibility: true,
                thickness: 3,
                radius: const Radius.circular(2),
                child: SingleChildScrollView(
                  controller: _controller,
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(18, 14, 18, 18),
                  child: Column(
                    children: [
                      _StatusCard(
                        statusText: _v('leaveStatus'),
                        onEdit: () => _editField('leaveStatus', '休假状态'),
                      ),
                      const SizedBox(height: 14),
                      _StudentCard(
                        name: _v('name'),
                        studentId: _v('studentId'),
                        className: _v('className'),
                        department: _v('department'),
                        onEdit: _editField,
                      ),
                      const SizedBox(height: 14),
                      _LeaveDetailCard(
                        leaveType: _v('leaveType'),
                        leaveLocation: _v('leaveLocation'),
                        leaveReason: _v('leaveReason'),
                        destinationLocation: _v('destinationLocation'),
                        destinationDetail: _v('destinationDetail'),
                        travelMode: _v('travelMode'),
                        exitCampus: _v('exitCampus'),
                        exitGate: _v('exitGate'),
                        entryCampus: _v('entryCampus'),
                        entryGate: _v('entryGate'),
                        leaveStart: _v('leaveStart'),
                        leaveEnd: _v('leaveEnd'),
                        approver: _v('approver'),
                        onEdit: _editField,
                      ),
                      const SizedBox(height: 14),
                      _ApproveCard(
                        applicantName: _v('flowApplicant'),
                        submitAction: _v('flowSubmitAction'),
                        submitTime: _v('flowSubmitTime'),
                        reviewerName: _v('flowReviewer'),
                        resultText: _v('flowResult'),
                        comment: _v('flowComment'),
                        reviewTime: _v('flowReviewTime'),
                        onEdit: _editField,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: Stack(
        alignment: Alignment.center,
        children: const [
          Stack(
            children: [
              Positioned(
                left: 8,
                child: Icon(
                  Icons.chevron_left_rounded,
                  size: 34,
                  color: Color(0xFF333333),
                ),
              ),
              Center(
                child: Text(
                  '请假',
                  style: TextStyle(
                    fontSize: 39 / 2,
                    color: Color(0xFF121212),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Tabs extends StatelessWidget {
  const _Tabs();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 95),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [_TabText('请假单', true), _TabText('审批流程', false)],
          ),
        ),
        const SizedBox(height: 8),
        Container(height: 1, color: const Color(0xFFEDEDED)),
      ],
    );
  }
}

class _TabText extends StatelessWidget {
  const _TabText(this.text, this.active);

  final String text;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 18 / 2 * 1.8,
            color: active ? const Color(0xFFF08D20) : const Color(0xFF545454),
            fontWeight: active ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 4,
          width: 54,
          decoration: BoxDecoration(
            color: active ? const Color(0xFFF08D20) : Colors.transparent,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({required this.statusText, required this.onEdit});

  final String statusText;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 110,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF7E82FA), Color(0xFF7279E8)],
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: _StripePainter())),
          Center(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: onEdit,
              child: Text(
                statusText,
                style: const TextStyle(
                  fontSize: 25,
                  color: Color(0xFFF2F2F2),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StripePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.09)
      ..strokeWidth = 1;
    for (double x = -size.height; x < size.width; x += 16) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x + size.height, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _StudentCard extends StatelessWidget {
  const _StudentCard({
    required this.name,
    required this.studentId,
    required this.className,
    required this.department,
    required this.onEdit,
  });

  final String name;
  final String studentId;
  final String className;
  final String department;
  final Future<void> Function(String key, String label) onEdit;

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: const Color(0xFFF2F3F6),
              borderRadius: BorderRadius.circular(2),
            ),
            child: const Icon(
              Icons.image_outlined,
              size: 52,
              color: Color(0xFFD6D7DA),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _InfoRow('姓名', name, onTap: () => onEdit('name', '姓名')),
                  const SizedBox(height: 7),
                  _InfoRow(
                    '学号',
                    studentId,
                    onTap: () => onEdit('studentId', '学号'),
                  ),
                  const SizedBox(height: 7),
                  _InfoRow(
                    '班级',
                    className,
                    onTap: () => onEdit('className', '班级'),
                  ),
                  const SizedBox(height: 7),
                  _InfoRow(
                    '院系',
                    department,
                    onTap: () => onEdit('department', '院系'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow(this.k, this.v, {this.onTap});

  final String k;
  final String v;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Text(
        '$k：$v',
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xFF1D1D1D),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _LeaveDetailCard extends StatelessWidget {
  const _LeaveDetailCard({
    required this.leaveType,
    required this.leaveLocation,
    required this.leaveReason,
    required this.destinationLocation,
    required this.destinationDetail,
    required this.travelMode,
    required this.exitCampus,
    required this.exitGate,
    required this.entryCampus,
    required this.entryGate,
    required this.leaveStart,
    required this.leaveEnd,
    required this.approver,
    required this.onEdit,
  });

  final String leaveType;
  final String leaveLocation;
  final String leaveReason;
  final String destinationLocation;
  final String destinationDetail;
  final String travelMode;
  final String exitCampus;
  final String exitGate;
  final String entryCampus;
  final String entryGate;
  final String leaveStart;
  final String leaveEnd;
  final String approver;
  final Future<void> Function(String key, String label) onEdit;

  @override
  Widget build(BuildContext context) {
    return _Card(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _RowKV(
            label: '请假类型',
            trailing: _TypeItem(
              value: leaveType,
              onTap: () => onEdit('leaveType', '请假类型'),
            ),
          ),
          const _Line(),
          _RowKV(
            label: '请假位置',
            value: leaveLocation,
            onTap: () => onEdit('leaveLocation', '请假位置'),
          ),
          const SizedBox(height: 10),
          const Icon(
            Icons.location_on_rounded,
            size: 20,
            color: Color(0xFF303030),
          ),
          const SizedBox(height: 12),
          const _Title('具体事项'),
          const SizedBox(height: 8),
          _GreyInput(
            leaveReason,
            h: 88,
            onTap: () => onEdit('leaveReason', '具体事项'),
          ),
          const _Line(),
          _RowKV(
            label: '目的地',
            value: destinationLocation,
            onTap: () => onEdit('destinationLocation', '目的地位置'),
          ),
          const SizedBox(height: 8),
          _GreyInput(
            destinationDetail,
            h: 112,
            onTap: () => onEdit('destinationDetail', '目的地详情'),
          ),
          const _Line(),
          const _Title('出行方式'),
          const SizedBox(height: 8),
          _GreyInput(
            travelMode,
            h: 106,
            onTap: () => onEdit('travelMode', '出行方式'),
          ),
          const _Line(),
          const _Title('出口'),
          const SizedBox(height: 10),
          _DoubleInput(
            exitCampus,
            exitGate,
            onEditLeft: () => onEdit('exitCampus', '出口学校'),
            onEditRight: () => onEdit('exitGate', '出口校门'),
          ),
          const SizedBox(height: 14),
          const _Title('入口'),
          const SizedBox(height: 10),
          _DoubleInput(
            entryCampus,
            entryGate,
            onEditLeft: () => onEdit('entryCampus', '入口学校'),
            onEditRight: () => onEdit('entryGate', '入口校门'),
          ),
          const _Line(),
          const _Title('请假时间'),
          const SizedBox(height: 6),
          const Text(
            '(请在请假时间内按时返校,超时返校将影响后续请假)',
            style: TextStyle(
              fontSize: 12,
              color: Color.fromARGB(255, 245, 8, 8),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          _DoubleInput(
            leaveStart,
            leaveEnd,
            onEditLeft: () => onEdit('leaveStart', '请假开始时间'),
            onEditRight: () => onEdit('leaveEnd', '请假结束时间'),
          ),
          const _Line(),
          _RowKV(
            label: '审批人',
            value: approver,
            onTap: () => onEdit('approver', '审批人'),
          ),
        ],
      ),
    );
  }
}

class _RowKV extends StatelessWidget {
  const _RowKV({required this.label, this.value, this.trailing, this.onTap});

  final String label;
  final String? value;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF202020),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 24),
        if (trailing != null)
          trailing!
        else if (value != null)
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: onTap,
              child: Text(
                value!,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF3C3C3C),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _TypeItem extends StatelessWidget {
  const _TypeItem({required this.value, this.onTap});

  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Row(
        children: [
          const Icon(
            Icons.radio_button_checked,
            size: 24,
            color: Color(0xFFF08D20),
          ),
          const SizedBox(width: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF2F2F2F),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        color: Color(0xFF222222),
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class _GreyInput extends StatelessWidget {
  const _GreyInput(this.text, {required this.h, this.onTap});

  final String text;
  final double h;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: h,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F7),
          borderRadius: BorderRadius.circular(2),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFFC7C7CB),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _DoubleInput extends StatelessWidget {
  const _DoubleInput(
    this.left,
    this.right, {
    this.onEditLeft,
    this.onEditRight,
  });

  final String left;
  final String right;
  final VoidCallback? onEditLeft;
  final VoidCallback? onEditRight;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _Input(left, onTap: onEditLeft)),
        const SizedBox(width: 8),
        Expanded(child: _Input(right, onTap: onEditRight)),
      ],
    );
  }
}

class _Input extends StatelessWidget {
  const _Input(this.text, {this.onTap});

  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        height: 43,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F7),
          borderRadius: BorderRadius.circular(2),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF8E8E92),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _Line extends StatelessWidget {
  const _Line();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Container(height: 1, color: const Color(0xFFEFEFF0)),
    );
  }
}

class _ApproveCard extends StatelessWidget {
  const _ApproveCard({
    required this.applicantName,
    required this.submitAction,
    required this.submitTime,
    required this.reviewerName,
    required this.resultText,
    required this.comment,
    required this.reviewTime,
    required this.onEdit,
  });

  final String applicantName;
  final String submitAction;
  final String submitTime;
  final String reviewerName;
  final String resultText;
  final String comment;
  final String reviewTime;
  final Future<void> Function(String key, String label) onEdit;

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '审批流程',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF202020),
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 24,
                child: Column(
                  children: const [
                    _StepDot(),
                    SizedBox(height: 4),
                    _DashLine(),
                    SizedBox(height: 4),
                    _StepDot(),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () => onEdit('flowApplicant', '申请人'),
                            child: Text(
                              '$applicantName (申请人)',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF1F1F1F),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () => onEdit('flowSubmitAction', '流程动作'),
                          child: Text(
                            submitAction,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xFF1F1F1F),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () => onEdit('flowSubmitTime', '提交时间'),
                      child: Text(
                        submitTime,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF9A9A9E),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(height: 1, color: const Color(0xFFEFEFF0)),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () => onEdit('flowReviewer', '一级审批人'),
                            child: Text(
                              '$reviewerName (一级审批)',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF1F1F1F),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () => onEdit('flowResult', '审批结果'),
                          child: Text(
                            resultText,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xFFF08D20),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () => onEdit('flowComment', '审批备注'),
                      child: Container(
                        height: 98,
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F7),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Text(
                          comment,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF474747),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () => onEdit('flowReviewTime', '审批时间'),
                      child: Text(
                        reviewTime,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF9A9A9E),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StepDot extends StatelessWidget {
  const _StepDot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFF08D20), width: 2.2),
      ),
    );
  }
}

class _DashLine extends StatelessWidget {
  const _DashLine();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        8,
        (_) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 1.8),
          child: Container(width: 2, height: 6, color: const Color(0xFFF0B669)),
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.child, this.padding = const EdgeInsets.all(16)});

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: child,
    );
  }
}
