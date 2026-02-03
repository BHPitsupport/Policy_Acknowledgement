# Dataverse Schema

## Tables

### Policy
- PolicyId: GUID (required)
- Name: Text (required)
- Code: Text
- Status: Choice (Draft/Active/Retired) (required)
- CurrentVersionId: Lookup (PolicyVersion)
- OwnerTeamId: Lookup (Team)
- CreatedOn: DateTime (system)
- ModifiedOn: DateTime (system)

### PolicyVersion
- PolicyVersionId: GUID (required)
- PolicyId: Lookup (Policy) (required)
- VersionNumber: Whole Number (required)
- PublishedDate: DateTime (required)
- ImmutableUrl: Text (required)
- FileHash: Text (required)
- FileName: Text (required)
- FileSizeBytes: Whole Number
- SupersededDate: DateTime
- CreatedOn: DateTime (system)

### Person
- PersonId: GUID (required)
- EntraObjectId: GUID (required)
- DisplayName: Text (required)
- UserPrincipalName: Text (required)
- Mail: Text
- Department: Text
- Active: Yes/No (required)
- CreatedOn: DateTime (system)

### AudienceRule
- AudienceRuleId: GUID (required)
- PolicyId: Lookup (Policy) (required)
- Name: Text (required)
- RuleType: Choice (EntraGroup/Attribute/Manual) (required)
- RuleValue: Text (required)
- Active: Yes/No (required)

### Assignment
- AssignmentId: GUID (required)
- PolicyVersionId: Lookup (PolicyVersion) (required)
- PersonId: Lookup (Person) (required)
- Status: Choice (Pending/Completed/Overdue) (required)
- DueDate: DateTime
- AssignedDate: DateTime (required)
- CompletedDate: DateTime
- AcknowledgementId: Lookup (Acknowledgement)

### Acknowledgement
- AcknowledgementId: GUID (required)
- AssignmentId: Lookup (Assignment) (required)
- PolicyVersionId: Lookup (PolicyVersion) (required)
- PersonId: Lookup (Person) (required)
- AcknowledgedTimestamp: DateTime (required)
- AcknowledgementSource: Choice (App/Email/Import) (required)
- FlowRunId: Text
- Notes: Text

### Exception
- ExceptionId: GUID (required)
- AssignmentId: Lookup (Assignment) (required)
- PersonId: Lookup (Person) (required)
- Reason: Text (required)
- ApprovedBy: Lookup (Person)
- ApprovedOn: DateTime
- Status: Choice (Requested/Approved/Rejected) (required)

### SystemLog
- SystemLogId: GUID (required)
- EventTime: DateTime (required)
- FlowName: Text (required)
- Severity: Choice (Info/Warning/Error/Critical) (required)
- Message: Text (required)
- FlowRunId: Text
- CorrelationId: Text

## Relationships
- Policy (1) to PolicyVersion (N)
- Policy (1) to AudienceRule (N)
- PolicyVersion (1) to Assignment (N)
- Person (1) to Assignment (N)
- Assignment (1) to Acknowledgement (0..1)
- Assignment (1) to Exception (0..N)
- Person (1) to Acknowledgement (N)
- PolicyVersion (1) to Acknowledgement (N)

## Alternate Keys
- Person: EntraObjectId

## Status Fields
- Policy.Status: Draft/Active/Retired
- Assignment.Status: Pending/Completed/Overdue

## Audit-Friendly Fields
- PolicyVersion.ImmutableUrl
- PolicyVersion.PublishedDate
- PolicyVersion.VersionNumber
- PolicyVersion.FileHash
- Acknowledgement.AcknowledgedTimestamp
- Acknowledgement.AcknowledgementSource
- Acknowledgement.FlowRunId
