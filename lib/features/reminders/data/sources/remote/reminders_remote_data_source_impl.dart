import 'package:monex/features/reminders/data/models/reminder_model.dart';
import 'package:monex/features/reminders/data/sources/remote/reminders_remote_data_source.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RemindersRemoteDataSourceImpl implements RemindersRemoteDataSource {
  final SupabaseClient supabaseClient;

  RemindersRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<void> deleteReminder(String id) async {
    return await supabaseClient.from('reminders').delete().eq('id', id);
  }

  @override
  Future<ReminderModel> getReminderById(String id) async {
    final response = await supabaseClient
        .from('reminders')
        .select()
        .eq('id', id);
    return ReminderModel.fromJson(response.first);
  }

  @override
  Future<List<ReminderModel>> getReminders() async {
    final response = await supabaseClient.from('reminders').select();
    return response.map((data) => ReminderModel.fromJson(data)).toList();
  }

  @override
  Future<void> insertReminder(ReminderModel data, String operationId) async {
    await supabaseClient.rpc(
      'process_reminder_insert',
      params: {
        'p_operation_id': operationId,
        'p_entity_id': data.id,
        'p_title': data.title,
        'p_amount': data.amount,
        'p_frequency': data.frequency.index,
        'p_schedule_date': data.scheduleDate.toUtc().toIso8601String(),
        'p_deadline': data.deadline.toUtc().toIso8601String(),
      },
    );
  }

  @override
  Future<void> updateReminder(ReminderModel data) async {
    return await supabaseClient
        .from('reminders')
        .update(data.toJson())
        .eq('id', data.id);
  }
}
