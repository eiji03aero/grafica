# attributes
# - client
# - sequence
# - reply_messages
# - scenario_id
# flow
# - initialize
#   - receive params
#     - message_data
#     - client_id
#     - scenario_id
#   - fetch corresponding scenario
#   - find or create client
#   - create sequence record
# - execute
#   - execute FindConversationService
#   - create sequence
#     - client, conversation
#   - execute ExecuteScenarioService
#   - convert replay_messages into json
#   - return: replay_messages

class ReplyService
end
