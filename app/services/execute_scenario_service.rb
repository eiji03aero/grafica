# attributes
# - client
# - sequence
# - reply_messages
# - scenario
# - conversation
# - current_node
# - previous_node
# flow
# - initialize
#   - receive params
#     - message_data
#     - sequence_id
#   - fetch corresponding sequence, scenario, client, conversation
# - execute
#   - find node to start
#     - set current_node to node to start
#     - set previous_node if possible
#   - while !Node.shouldStop(@current_node)
#     - message, next_node_id = @current_node.execute
#   - update conversation
#     - suspended_node_id
#   - normalize reply_messages
#     - compact
#   - return: reply_messages

class ExecuteScenarioService
end
