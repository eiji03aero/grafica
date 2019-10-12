# Models

- DialogObject
  - has_one parent_node: DialogObject
  - has_one next_node: DialogObject

- Node < DialogObject

- Component < DialogObject
  - has_many children: Node

- StartNode < Node

- EndNode < Node

- TextNode < Node
  - text: string

- SuspendNode < Node

- ConditionNode < Node

- Scenario
  - name: string
  - has_one root_component: Component
