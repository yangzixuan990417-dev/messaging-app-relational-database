-- Messaging App Relational Database Design
-- File: 02_insert_sample_data.sql
-- Purpose: Insert sample data into the messaging application database

PRAGMA foreign_keys = ON;

-- Insert application users
INSERT INTO AppUser (phone_number, user_name)
VALUES
    ('+64210000001', 'Mia Chen'),
    ('+64210000002', 'Leo Zhang'),
    ('+64210000003', 'Ava Wang'),
    ('+64210000004', 'Noah Li'),
    ('+64210000005', 'Sophie Liu'),
    ('+64210000006', 'Ethan Zhao');

-- Insert chat groups
INSERT INTO ChatGroup (group_id, group_name)
VALUES
    ('G101', 'Data Analytics Team'),
    ('G102', 'Project Planning Group');

-- Insert conversations
INSERT INTO Conversation (chat_id, chat_type, group_id)
VALUES
    ('C1001', 'individual', NULL),
    ('C1002', 'group', 'G101'),
    ('C1003', 'group', 'G102');

-- Insert group members
INSERT INTO GroupMember (group_id, phone_number, joined_date)
VALUES
    ('G101', '+64210000001', '2025-03-01'),
    ('G101', '+64210000003', '2025-03-01'),
    ('G101', '+64210000004', '2025-03-02'),
    ('G102', '+64210000002', '2025-03-05'),
    ('G102', '+64210000005', '2025-03-05'),
    ('G102', '+64210000006', '2025-03-06');

-- Insert conversation participants
INSERT INTO ConversationParticipant (chat_id, phone_number, participant_role)
VALUES
    ('C1001', '+64210000001', 'sender'),
    ('C1001', '+64210000002', 'receiver'),

    ('C1002', '+64210000001', 'member'),
    ('C1002', '+64210000003', 'member'),
    ('C1002', '+64210000004', 'member'),

    ('C1003', '+64210000002', 'member'),
    ('C1003', '+64210000005', 'member'),
    ('C1003', '+64210000006', 'member');

-- Insert messages
INSERT INTO Message (chat_id, message_time, sender_phone, message_text, media_type, media_name)
VALUES
    ('C1001', '2025-04-10 09:15:00', '+64210000001', 'Hi Leo, have you reviewed the project brief?', NULL, NULL),
    ('C1001', '2025-04-10 09:17:30', '+64210000002', 'Yes, I will send you my notes later today.', NULL, NULL),

    ('C1002', '2025-04-11 10:00:00', '+64210000001', 'Good morning team, let us discuss the dashboard requirements.', NULL, NULL),
    ('C1002', '2025-04-11 10:05:20', '+64210000003', 'I have uploaded the draft dataset.', 'file', 'sample_dataset.csv'),
    ('C1002', '2025-04-11 10:08:45', '+64210000004', 'Great, I will check the column structure.', NULL, NULL),

    ('C1003', '2025-04-12 14:00:00', '+64210000002', 'Can everyone confirm the meeting agenda?', NULL, NULL),
    ('C1003', '2025-04-12 14:04:10', '+64210000005', 'I added the timeline diagram.', 'image', 'timeline_diagram.png'),
    ('C1003', '2025-04-12 14:07:35', '+64210000006', 'Looks good. I will prepare the summary notes.', NULL, NULL);
