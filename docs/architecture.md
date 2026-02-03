# Architecture

## Overview
This solution captures policy acknowledgements end-to-end across SharePoint, Dataverse, Power Automate, and Microsoft Entra ID. The design prioritizes immutable versioning, audit-ready evidence, and minimal manual administration.

## SharePoint Libraries
- Masters: Source policy documents (authoring).
- Published-Immutable: Released policy versions (read-only).
- Superseded: Retired policy versions (read-only).
- AuditPacks: Evidence exports and audit bundles.

## Dataverse Tables
- Policy: Logical policy record and metadata.
- PolicyVersion: Immutable versioned policy instance.
- Person: Directory-backed user profile.
- AudienceRule: Targeting logic for assignments.
- Assignment: A policy version assigned to a person.
- Acknowledgement: User attestation linked to an assignment.
- Exception: Waivers or deviations with approvals.
- SystemLog: Operational telemetry and failures.

## Power Automate Flows
- Publish pipeline: On release, create PolicyVersion and publish to SharePoint.
- Entra group sync: Nightly sync of group membership to Person.
- Assignment generation: Create Assignment records per AudienceRule.
- Reminders/escalations: Scheduled nudges and escalation routing.
- Audit pack export: On demand or scheduled evidence packaging.

## Core Invariants
- PolicyVersion records are immutable after publish.
- Acknowledgements always reference a specific PolicyVersion.
- Person is keyed by Entra Object ID for stable identity.

## Zero-Admin Operations Model
- Scheduled runs: Entra group sync, assignment generation, reminders/escalations.
- Publish-triggered runs: Publish pipeline on new policy release.
- Failures: Critical failures generate SystemLog entries and alert owners; non-critical failures retry automatically.
- Evidence: Audit pack export runs on schedule or on request and writes to AuditPacks.
