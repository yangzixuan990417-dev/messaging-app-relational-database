# Normalisation Summary

This document explains how the messaging application database was transformed from a flat-file structure into a relational database design.

## Original Flat-File Problem

The original message data was stored in one large table. This table included user details, group details, conversation details, message content, media information, and timestamps.

This design can cause repeated data. For example, the same user name or group name may appear many times across different message records.

This can lead to several problems:

- Data redundancy
- Update anomalies
- Inconsistent records
- Difficulty maintaining message history
- Poor scalability as the number of messages increases

## What Normalisation Means

Normalisation is the process of organising data into separate but connected tables.

Instead of storing everything in one large table, related information is separated into smaller tables. This makes the database easier to update, maintain, and query.

In this project, the flat-file message data was separated into tables for users, groups, conversations, group membership, conversation participation, and messages.

## First Normal Form 1NF

In 1NF, each field contains a single value, and each row represents one message record.

A message can be identified by the combination of:

```text
chat_id + message_time
```

This is because no two messages in the same conversation should have the same timestamp.

However, the 1NF structure still contains repeated user names, group names, and conversation information.

## Second Normal Form 2NF

In 2NF, data that does not depend on the full message key is separated into its own table.

For example:

```text
sender_phone → user_name
group_id → group_name
chat_id → chat_type
```

This means:

- User details should be stored in the AppUser table.
- Group details should be stored in the ChatGroup table.
- Conversation details should be stored in the Conversation table.

This reduces repeated data in the Message table.

## Third Normal Form 3NF

In 3NF, indirect dependencies are removed.

For example:

```text
chat_id → group_id → group_name
```

This means the group name should not be repeated in every message record. Instead, the group name should be stored once in the ChatGroup table and connected through group_id.

The final database design separates the data into multiple connected tables.

## Final 3NF Tables

The final database includes the following tables:

### AppUser

Stores unique user information.

```text
phone_number
user_name
```

### ChatGroup

Stores group chat information.

```text
group_id
group_name
```

### GroupMember

Stores which users belong to which groups.

```text
group_id
phone_number
joined_date
```

### Conversation

Stores conversation-level information.

```text
chat_id
chat_type
group_id
```

### ConversationParticipant

Stores which users participate in which conversations.

```text
chat_id
phone_number
participant_role
```

### Message

Stores individual message records.

```text
chat_id
message_time
sender_phone
message_text
media_type
media_name
```

## Benefits of the Final Design

The normalised database design improves the system by:

- Reducing repeated data
- Improving data consistency
- Avoiding update anomalies
- Supporting both individual and group conversations
- Allowing users to participate in multiple conversations
- Allowing users to belong to multiple groups
- Supporting optional media attachments
- Making SQL queries easier to maintain

## Summary

The final design transforms repeated flat-file message data into a structured relational database. This improves data integrity and makes the messaging application easier to manage, query, and extend in the future.
