# Self-service system

Using GitHub events to look at committed service request files that double as config doc for the service.

Backed by messaging systems and a database to track the state of the service request and ability to route
to the right team for action.

Use GitHub as the interface for the self-service system, allowing users to create and manage service requests
through commits and pull requests. Each service request is represented as a file in a designated repository,
containing all necessary information and configuration for the requested service.
