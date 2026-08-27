# config/role_assignment.tfvars
# Tracked, ready-to-run fixture for the test/live harness - one representative
# real-usage instance, not a two-code-path engineered fixture and not a
# dormant "_" template.
#
# Assigns the caller's own principal a Reader role against the harness's own
# throwaway resource group (see test_dependencies.tf and main.tf) - no
# freshly-created principal, no shared/production scope.

env = "livetest"

role_definition = "Reader"
