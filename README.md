# Grafica = scenario + neo4j

# Apis

- create scenario
- create nodes
- execute scenario
  - create client
  - create sequence
  - returns json

# Models

```
- DialogObject
  - sequential_id: integer
  - has_one parent_node: DialogObject
  - has_one next_node: DialogObject
  - belongs_to scenario: Scenario
  - .stop_node?
  - #execute
    - #process_node
    - #generate_reply_data
    - #get_next_node
  - #process_node
  - #generate_reply_data
  - #get_next_node

  - Node < DialogObject

    - StartNode < Node

    - EndNode < Node

    - TextNode < Node
      - text: string

    - SuspendNode < Node

    - ConditionNode < Node
      - has_many :out, conditions: Condition
      - #calc_conditions
      - #add_condition
      - #update_condition
      - #destroy_condition

  - Component < DialogObject
    - has_many children: DialogObject
    - #is_root

- Condition::Base
  - has_one :in, node: ConditionNode
  - has_one :out, next_node: DialogObject
  - #calc_confidence

  - TextPerfectMatch < Base

- Scenario
  - name: string
  - has_one root_component: Component

- Client
  - belongs_to scenario Scenario
  - has_many :in, conversations: Conversation
  - has_many :in, sequences: Sequence

- Sequence
  - text: string
  - has_one :out, client: Client
  - has_one :out, conversation: Conversation

- Conversation
  - has_many :out, clients: Client
  - has_many :in, sequences: Sequence

- ScenarioError::Base
  - has_many :out, related_nodes: DialogObject

  - UnknownNodeType < ScenarioError
  - EndNodeNotFound < Base
  - NextNodeNotDefined < Base
```

# Services

```
- CreateNodeService
  - .new
    - parent_id
    - type
    - data
  - #execute

- UpdateNodeService
  - .new
    - parent_id
    - type
    - data
  - #execute

- ReplyService
  - .new
    - message_data
    - client_id
    - scenario_id
  - #execute

- FindConversationService
  - .new
    - scenario_id
    - client_id
  - #execute
    return: Conversation

- ExecuteScenarioService
  - .new
  - #execute
```
