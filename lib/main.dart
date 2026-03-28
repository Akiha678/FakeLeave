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
                  child: const Column(
                    children: [
                      _StatusCard(),
                      SizedBox(height: 14),
                      _StudentCard(),
                      SizedBox(height: 14),
                      _LeaveDetailCard(),
                      SizedBox(height: 14),
                      _ApproveCard(),
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
              // 左侧图标
              Positioned(
                left: 8,
                child: Icon(
                  Icons.chevron_left_rounded,
                  size: 34,
                  color: Color(0xFF333333),
                ),
              ),
              // 居中的标题
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
          )
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
  const _StatusCard();

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
          const Center(
            child: Text(
              '正在休假',
              style: TextStyle(
                fontSize: 25,
                color: Color(0xFFF2F2F2),
                fontWeight: FontWeight.w700,
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
  const _StudentCard();

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
          const Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _InfoRow('姓名', '陈鑫'),
                  SizedBox(height: 7),
                  _InfoRow('学号', '202311278'),
                  SizedBox(height: 7),
                  _InfoRow('班级', '软工2301'),
                  SizedBox(height: 7),
                  _InfoRow('院系', '信息工程学院'),
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
  const _InfoRow(this.k, this.v);

  final String k;
  final String v;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$k：$v',
      style: const TextStyle(
        fontSize: 14,
        color: Color(0xFF1D1D1D),
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _LeaveDetailCard extends StatelessWidget {
  const _LeaveDetailCard();

  @override
  Widget build(BuildContext context) {
    return _Card(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _RowKV(label: '请假类型', trailing: _TypeItem()),
          _Line(),
          _RowKV(label: '请假位置', value: '湖北省-荆州市-荆州区'),
          SizedBox(height: 10),
          Icon(Icons.location_on_rounded, size: 20, color: Color(0xFF303030)),
          SizedBox(height: 12),
          _Title('具体事项'),
          SizedBox(height: 8),
          _GreyInput('董事长来实验室检查', h: 88),
          _Line(),
          _RowKV(label: '目的地', value: '湖北省-荆州市-荆州区'),
          SizedBox(height: 8),
          _GreyInput('智能终端实验室', h: 112),
          _Line(),
          _Title('出行方式'),
          SizedBox(height: 8),
          _GreyInput('步行', h: 106),
          _Line(),
          _Title('出口'),
          SizedBox(height: 10),
          _DoubleInput('荆州学院', '东大门'),
          SizedBox(height: 14),
          _Title('入口'),
          SizedBox(height: 10),
          _DoubleInput('荆州学院', '东大门'),
          _Line(),
          _Title('请假时间'),
          SizedBox(height: 6),
          Text(
            '(请在请假时间内按时返校,超时返校将影响后续请假)',
            style: TextStyle(
              fontSize: 12,
              color: Color.fromARGB(255, 245, 8, 8),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          _DoubleInput('2026-3-15 08:00', '2026-3-15 17:35'),
          _Line(),
          _RowKV(label: '审批人', value: '牛家鑫'),
        ],
      ),
    );
  }
}

class _RowKV extends StatelessWidget {
  const _RowKV({required this.label, this.value, this.trailing});

  final String label;
  final String? value;
  final Widget? trailing;

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
      ],
    );
  }
}

class _TypeItem extends StatelessWidget {
  const _TypeItem();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(Icons.radio_button_checked, size: 24, color: Color(0xFFF08D20)),
        SizedBox(width: 8),
        Text(
          '事假',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF2F2F2F),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
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
  const _GreyInput(this.text, {required this.h});

  final String text;
  final double h;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

class _DoubleInput extends StatelessWidget {
  const _DoubleInput(this.left, this.right);

  final String left;
  final String right;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _Input(left)),
        const SizedBox(width: 8),
        Expanded(child: _Input(right)),
      ],
    );
  }
}

class _Input extends StatelessWidget {
  const _Input(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
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
  const _ApproveCard();

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
                    const Row(
                      children: [
                        Expanded(
                          child: Text(
                            '陈鑫 (申请人)',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF1F1F1F),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          '提交申请',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF1F1F1F),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      '2026-3-15 12:29:15',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF9A9A9E),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(height: 1, color: const Color(0xFFEFEFF0)),
                    const SizedBox(height: 10),
                    const Row(
                      children: [
                        Expanded(
                          child: Text(
                            '牛家鑫 (一级审批)',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF1F1F1F),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Text(
                          '同意并终止',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFFF08D20),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 98,
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F7),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: const Text(
                        '无',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF474747),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      '2026-3-15 19:29:15',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF9A9A9E),
                        fontWeight: FontWeight.w500,
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
