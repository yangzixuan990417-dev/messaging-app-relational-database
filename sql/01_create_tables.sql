-- Messaging App Relational Database Design
-- File: 01_create_tables.sql
-- Purpose: Create the relational database schema for a messaging application

PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS Message;
DROP TABLE IF EXISTS ConversationParticipant;
DROP TABLE IF EXISTS GroupMember;
DROP TABLE IF EXISTS Conversation;
DROP TABLE IF EXISTS ChatGroup;
DROP TABLE IF EXISTS AppUser;

CREATE TABLE AppUser (
    phone_number TEXT PRIMARY KEY,
    user_name TEXT NOT NULL
);

CREATE TABLE ChatGroup (
    group_id TEXT PRIMARY KEY,
    group_name TEXT NOT NULL
);

CREATE TABLE GroupMember (
    group_id TEXT NOT NULL,
    phone_number TEXT NOT NULL,
    joined_date TEXT,
    PRIMARY KEY (group_id, phone_number),
    FOREIGN KEY (group_id) REFERENCES ChatGroup(group_id),
    FOREIGN KEY (phone_number) REFERENCES AppUser(phone_number)
);

CREATE TABLE Conversation (
    chat_id TEXT PRIMARY KEY,
    chat_type TEXT NOT NULL CHECK (chat_type IN ('individual', 'group')),
    group_id TEXT,
    FOREIGN KEY (group_id) REFERENCES ChatGroup(group_id)
);

CREATE TABLE ConversationParticipant (
    chat_id TEXT NOT NULL,
    phone_number TEXT NOT NULL,
    participant_role TEXT,
    PRIMARY KEY (chat_id, phone_number),
    FOREIGN KEY (chat_id) REFERENCES Conversation(chat_id),
    FOREIGN KEY (phone_number) REFERENCES AppUser(phone_number)
);

CREATE TABLE Message (
    chat_id TEXT NOT NULL,
    message_time TEXT NOT NULL,
    sender_phone TEXT NOT NULL,
    message_text TEXT,
    media_type TEXT,
    media_name TEXT,
    PRIMARY KEY (chat_id, message_time),
    FOREIGN KEY (chat_id) REFERENCES Conversation(chat_id),
    FOREIGN KEY (sender_phone) REFERENCES AppUser(phone_number)
);
