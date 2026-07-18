# Module Dashboard Extension Spec

## Objective

Provide an automated way to publish and refresh module portfolio visibility for PSModule repositories.

## Minimum data points

- module name
- latest released version
- repository star count
- last release date
- repository status metadata

## Update model

- source data from GitHub APIs and module metadata
- scheduled refresh via workflow or service process
- deterministic rendering to docs pages or dashboard output

## Non-goals

- replacing module documentation pages
- acting as release orchestration

## Open decisions

- static docs generation versus live service-backed dashboard
- update cadence and API rate limit strategy
- source of truth for module ownership metadata
