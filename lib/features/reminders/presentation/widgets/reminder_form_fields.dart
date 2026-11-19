import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monex/core/screen_size.dart';
import 'package:monex/core/enums/contribution_period.dart';
import 'package:monex/features/reminders/presentation/widgets/date_time_picker_row.dart';
import 'package:monex/features/reminders/presentation/widgets/frequency_selector_sheet.dartfrequency_selector_sheet.dart';

class ReminderFormFields extends StatefulWidget {
  final ReminderFormController controller;
  final String? initialTitle;
  final double? initialAmount;
  final ContributionPeriod? initialFrequency;
  final DateTime? initialScheduleDate;
  final DateTime? initialDeadline;

  /// Controls whether the first notification date can be changed.
  /// Defaults to true so the Add Reminder flow remains unchanged.
  final bool enableScheduleDate;

  const ReminderFormFields({
    super.key,
    required this.controller,
    this.initialTitle,
    this.initialAmount,
    this.initialFrequency,
    this.initialScheduleDate,
    this.initialDeadline,
    this.enableScheduleDate = true,
  });

  @override
  State<ReminderFormFields> createState() => _ReminderFormFieldsState();
}

class _ReminderFormFieldsState extends State<ReminderFormFields> {
  late final TextEditingController _titleCtrl;
  late final TextEditingController _amountCtrl;
  late final GlobalKey<FormState> _formKey;

  ContributionPeriod? _frequency;
  DateTime? _scheduleDate;
  DateTime? _deadline;

  @override
  void initState() {
    super.initState();
    _titleCtrl = TextEditingController(text: widget.initialTitle ?? '');
    _amountCtrl = TextEditingController(
      text: widget.initialAmount != null
          ? widget.initialAmount!.toStringAsFixed(
              widget.initialAmount!.truncateToDouble() == widget.initialAmount
                  ? 0
                  : 2,
            )
          : '',
    );
    _frequency = widget.initialFrequency;
    _scheduleDate = widget.initialScheduleDate;
    _deadline = widget.initialDeadline;
    _formKey = GlobalKey<FormState>();
    widget.controller._attach(this);
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _amountCtrl.dispose();
    super.dispose();
  }

  Widget _pickerTheme(BuildContext ctx, Widget? child) {
    const blue = Color(0xFF3D5AFE);

    return Theme(
      data: Theme.of(ctx).copyWith(
        colorScheme: Theme.of(ctx).colorScheme.copyWith(
              primary: blue,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: const Color(0xFF1A1A2E),
            ),
        datePickerTheme: DatePickerThemeData(
          backgroundColor: Colors.white,
          headerBackgroundColor: Colors.white,
          headerForegroundColor: const Color(0xFF1A1A2E),
          todayBorder: const BorderSide(color: blue, width: 1),
          todayForegroundColor: WidgetStateColor.resolveWith(
            (states) =>
                states.contains(WidgetState.selected) ? Colors.white : blue,
          ),
          dayForegroundColor: WidgetStateColor.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? Colors.white
                : const Color(0xFF1A1A2E),
          ),
          dayBackgroundColor: WidgetStateColor.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? blue
                : Colors.transparent,
          ),
          dayOverlayColor: WidgetStateColor.resolveWith(
            (_) => blue.withOpacity(0.08),
          ),
          yearForegroundColor: WidgetStateColor.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? Colors.white
                : const Color(0xFF1A1A2E),
          ),
          yearBackgroundColor: WidgetStateColor.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? blue
                : Colors.transparent,
          ),
          rangePickerBackgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ScreenSize.height * 0.022),
          ),
        ),
        timePickerTheme: TimePickerThemeData(
          backgroundColor: Colors.white,
          hourMinuteColor: WidgetStateColor.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? blue
                : const Color(0xFFF2F3F7),
          ),
          hourMinuteTextColor: WidgetStateColor.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? Colors.white
                : const Color(0xFF1A1A2E),
          ),
          dialBackgroundColor: const Color(0xFFF2F3F7),
          dialHandColor: blue,
          dialTextColor: WidgetStateColor.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? Colors.white
                : const Color(0xFF1A1A2E),
          ),
          dayPeriodColor: WidgetStateColor.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? blue.withOpacity(0.12)
                : Colors.transparent,
          ),
          dayPeriodTextColor: WidgetStateColor.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? blue
                : Colors.grey.shade600,
          ),
          dayPeriodBorderSide: BorderSide(color: Colors.grey.shade300),
          entryModeIconColor: blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ScreenSize.height * 0.022),
          ),
          hourMinuteShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ScreenSize.height * 0.016),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: const Color(0xFFF2F3F7),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(ScreenSize.height * 0.014),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: blue, width: 2),
              borderRadius: BorderRadius.circular(ScreenSize.height * 0.014),
            ),
          ),
        ),
      ),
      child: child!,
    );
  }

  void _pickScheduleDate() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _scheduleDate ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 10),
      builder: _pickerTheme,
    );

    if (pickedDate == null || !mounted) return;

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: _scheduleDate != null
          ? TimeOfDay.fromDateTime(_scheduleDate!)
          : TimeOfDay.now(),
      builder: _pickerTheme,
    );
    if (!mounted) return;

    setState(() {
      _scheduleDate = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime?.hour ?? 9,
        pickedTime?.minute ?? 0,
      );
    });
    widget.controller._notify();
  }

  void _pickDeadline() async {
    final now = DateTime.now();
    final minDate = _scheduleDate ?? now;

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _deadline != null && _deadline!.isAfter(minDate)
          ? _deadline!
          : minDate,
      firstDate: minDate,
      lastDate: DateTime(now.year + 20),
      builder: _pickerTheme,
    );
    if (pickedDate == null || !mounted) return;

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: _deadline != null
          ? TimeOfDay.fromDateTime(_deadline!)
          : const TimeOfDay(hour: 23, minute: 59),
      builder: _pickerTheme,
    );
    if (!mounted) return;

    setState(() {
      _deadline = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime?.hour ?? 23,
        pickedTime?.minute ?? 59,
      );
    });
    widget.controller._notify();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionLabel(text: 'Title'),
          SizedBox(height: ScreenSize.height * 0.008),
          TextFormField(
            controller: _titleCtrl,
            textCapitalization: TextCapitalization.sentences,
            onChanged: (_) => widget.controller._notify(),
            decoration: _inputDecoration(
              hint: 'e.g. Rent payment',
              prefixIcon: Icons.label_outline,
            ),
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Title is required' : null,
          ),
          SizedBox(height: ScreenSize.height * 0.022),
          _SectionLabel(text: 'Amount'),
          SizedBox(height: ScreenSize.height * 0.008),
          TextFormField(
            controller: _amountCtrl,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            onChanged: (_) => widget.controller._notify(),
            decoration: _inputDecoration(
              hint: '0.00',
              prefixIcon: Icons.attach_money_outlined,
              suffix: Text(
                '\$',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            validator: (v) {
              if (v == null || v.isEmpty) return 'Amount is required';
              final parsed = double.tryParse(v);
              if (parsed == null || parsed <= 0) {
                return 'Enter a valid amount';
              }
              return null;
            },
          ),
          SizedBox(height: ScreenSize.height * 0.022),
          _SectionLabel(text: 'Frequency'),
          SizedBox(height: ScreenSize.height * 0.008),
          GestureDetector(
            onTap: () => FrequencySelectorSheet.show(
              context,
              selected: _frequency,
              onSelected: (p) {
                setState(() => _frequency = p);
                widget.controller._notify();
              },
            ),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: ScreenSize.width * 0.04,
                vertical: ScreenSize.height * 0.018,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: _frequency != null
                      ? const Color(0xFF3D5AFE)
                      : Colors.grey.shade400,
                ),
                borderRadius: BorderRadius.circular(ScreenSize.height * 0.015),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.repeat_outlined,
                    size: ScreenSize.height * 0.022,
                    color: _frequency != null
                        ? const Color(0xFF3D5AFE)
                        : Colors.grey.shade400,
                  ),
                  SizedBox(width: ScreenSize.width * 0.03),
                  Expanded(
                    child: Text(
                      _frequency != null
                          ? FrequencySelectorSheet.labelFor(_frequency!)
                          : 'Select frequency',
                      style: TextStyle(
                        fontSize: ScreenSize.height * 0.016,
                        color: _frequency != null
                            ? const Color(0xFF1A1A2E)
                            : Colors.grey.shade400,
                        fontWeight: _frequency != null
                            ? FontWeight.w500
                            : FontWeight.w400,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Colors.grey.shade400,
                    size: ScreenSize.height * 0.025,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: ScreenSize.height * 0.022),
          _SectionLabel(text: 'First Notification'),
          SizedBox(height: ScreenSize.height * 0.006),
          Text(
            widget.enableScheduleDate
                ? 'When should we send the first reminder?'
                : 'The first notification date cannot be changed.',
            style: TextStyle(
              fontSize: ScreenSize.height * 0.013,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: ScreenSize.height * 0.008),
          Opacity(
            opacity: widget.enableScheduleDate ? 1 : 0.55,
            child: IgnorePointer(
              ignoring: !widget.enableScheduleDate,
              child: DateTimePickerRow(
                label: 'Schedule date & time',
                hint: 'Pick a date and time',
                value: _scheduleDate,
                showTime: true,
                onTap: widget.enableScheduleDate ? _pickScheduleDate : () {},
              ),
            ),
          ),
          SizedBox(height: ScreenSize.height * 0.022),
          _SectionLabel(text: 'Deadline'),
          SizedBox(height: ScreenSize.height * 0.006),
          Text(
            'The last date and time for this reminder.',
            style: TextStyle(
              fontSize: ScreenSize.height * 0.013,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: ScreenSize.height * 0.008),
          DateTimePickerRow(
            label: 'Deadline date & time',
            hint: 'Pick a deadline',
            value: _deadline,
            showTime: true,
            onTap: _pickDeadline,
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData prefixIcon,
    Widget? suffix,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey.shade400),
      prefixIcon: Icon(
        prefixIcon,
        size: ScreenSize.height * 0.022,
        color: Colors.grey.shade400,
      ),
      suffix: suffix,
      filled: true,
      fillColor: Colors.grey.shade50,
      contentPadding: EdgeInsets.symmetric(
        horizontal: ScreenSize.width * 0.04,
        vertical: ScreenSize.height * 0.018,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ScreenSize.height * 0.015),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ScreenSize.height * 0.015),
        borderSide: const BorderSide(color: Color(0xFF3D5AFE)),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ScreenSize.height * 0.015),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ScreenSize.height * 0.015),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;

  const _SectionLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: ScreenSize.height * 0.016,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF1A1A2E),
      ),
    );
  }
}

class ReminderFormController extends ChangeNotifier {
  _ReminderFormFieldsState? _state;

  void _attach(_ReminderFormFieldsState state) => _state = state;
  void _notify() => notifyListeners();

  String get title => _state?._titleCtrl.text.trim() ?? '';
  double? get amount => double.tryParse(_state?._amountCtrl.text ?? '');
  ContributionPeriod? get frequency => _state?._frequency;
  DateTime? get scheduleDate => _state?._scheduleDate;
  DateTime? get deadline => _state?._deadline;

  bool get isValid =>
      title.isNotEmpty &&
      amount != null &&
      amount! > 0 &&
      frequency != null &&
      scheduleDate != null &&
      deadline != null;

  bool validate() => _state?._formKey.currentState?.validate() ?? false;
}
