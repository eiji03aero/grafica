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
#     - sequence_id
#   - create sequences with reply_data
#   - return: sequences

class ReplyService
end
