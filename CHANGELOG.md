# Changelog

All notable changes to this module will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## 2026-08-04

### Added
- Terraform test coverage for naming, cartesian scope/principal expansion, custom scope names, role definition ID handling, optional role assignment arguments, and upgrade compatibility.
- GitHub Actions workflows for documentation generation, CI validation, and release creation.
- `.tflint.hcl` and `.gitattributes` for repo consistency.

### Changed
- Pin `azurerm` to `~> 5.0` and refresh the provider lockfile to `5.0.1`.
- Tighten `principal_id` to `list(string)` and fix default scope wiring so Azure receives full scope IDs.
- Update README, ESLZ example files, and release version pinning to the new module ref.

### Breaking Changes
- `principal_id` is now strictly `list(string)` (was `any`). Callers passing a bare string instead of a list must wrap it (e.g. `principal_id = ["00000000-..."]` instead of `principal_id = "00000000-..."`).

### Fixed
- Correct the `scope` description typo in module inputs.
