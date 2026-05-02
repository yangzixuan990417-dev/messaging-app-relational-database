-- Messaging App Relational Database Design
-- File: 05_schema_updates.sql
-- Purpose: Demonstrate schema evolution and performance improvements

PRAGMA foreign_keys = ON;

-- Update 1: Add account status to users
-- This allows the system to track whether a user account is active, inactive, or suspended.
ALTER TABLE AppUser
ADD COLUMN account_status TEXT DEFAULT 'active'
CHECK (account_status IN ('active', 'inactive', 'suspended'));


-- Update 2: Add soft-delete support for messages
-- Instead of permanently deleting messages, the system can mark them as deleted.
ALTER TABLE Message
ADD COLUMN is_deleted INTEGER DEFAULT 0
CHECK (is_deleted IN (0, 1));


-- Update 3: Add a read receipt table
-- This records which users have read each message and when they read it.
CREATE TABLE MessageReadReceipt (
    chat_id TEXT NOT NULL,
    message_time TEXT NOT NULL,
    phone_number TEXT NOT NULL,
    read_time TEXT NOT NULL,
    PRIMARY KEY (chat_id, message_time, phone_number),
    FOREIGN KEY (chat_id, message_time) REFERENCES Message(chat_id, message_time),
    FOREIGN KEY (phone_number) REFERENCES AppUser(phone_number)
);


-- Update 4: Add a reaction table
-- This allows users to react to messages without changing the original Message table.
CREATE TABLE MessageReaction (
    chat_id TEXT NOT NULL,
    message_time TEXT NOT NULL,
    phone_number TEXT NOT NULL,
    reaction_type TEXT NOT NULL,
    reaction_time TEXT NOT NULL,
    PRIMARY KEY (chat_id, message_time, phone_number, reaction_type),
    FOREIGN KEY (chat_id, message_time) REFERENCES Message(chat_id, message_time),
    FOREIGN KEY (phone_number) REFERENCES AppUser(phone_number)
);


-- Update 5: Add indexes to improve query performance
-- These indexes support faster lookups by conversation, sender, and message time.
CREATE INDEX idx_message_chat_time
ON Message(chat_id, message_time);

CREATE INDEX idx_message_sender
ON Message(sender_phone);

CREATE INDEX idx_group_member_phone
ON GroupMember(phone_number);
