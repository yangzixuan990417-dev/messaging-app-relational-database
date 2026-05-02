# Business Rules

This project is based on a messaging application that supports individual conversations, group conversations, users, group membership, messages, and media attachments.

## Core Business Rules

1. Each user has a unique phone number.
2. A user can participate in multiple conversations.
3. A conversation can be either an individual chat or a group chat.
4. Each group has a unique group ID.
5. A group can contain multiple users.
6. A user can belong to multiple groups.
7. Each message belongs to one conversation.
8. Each message is sent by one user.
9. No two messages in the same conversation can have the same timestamp.
10. A message may contain text, media, or both.
11. Media information is optional because not every message includes an attachment.
12. Group membership stores the date when a user joined a group.

## Design Implications

These business rules were used to separate the original flat-file structure into multiple relational tables. The design reduces repeated data, improves data consistency, and supports structured SQL queries for retrieving conversations, media messages, and group membership information.

## Main Entities

The main entities in this database design are:

- AppUser
- ChatGroup
- GroupMember
- Conversation
- ConversationParticipant
- Message

## Why These Rules Matter

Without separating users, groups, conversations, and messages into different tables, the database would contain repeated user names, repeated group names, and inconsistent message records. This could lead to update anomalies, data redundancy, and poor data integrity.
