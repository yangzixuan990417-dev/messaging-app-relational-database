-- Messaging App Relational Database Design
-- File: 04_views.sql
-- Purpose: Create SQL views for reusable message reporting

-- View 1: Show all messages with sender and conversation details
DROP VIEW IF EXISTS View_AllMessages;

CREATE VIEW View_AllMessages AS
SELECT
    M.chat_id,
    C.chat_type,
    COALESCE(G.group_name, 'Individual Chat') AS conversation_name,
    M.message_time,
    U.user_name AS sender_name,
    M.message_text,
    M.media_type,
    M.media_name
FROM Message M
JOIN AppUser U
    ON M.sender_phone = U.phone_number
JOIN Conversation C
    ON M.chat_id = C.chat_id
LEFT JOIN ChatGroup G
    ON C.group_id = G.group_id;


-- View 2: Show only messages that contain media attachments
DROP VIEW IF EXISTS View_MediaMessages;

CREATE VIEW View_MediaMessages AS
SELECT
    M.chat_id,
    COALESCE(G.group_name, 'Individual Chat') AS conversation_name,
    M.message_time,
    U.user_name AS sender_name,
    M.message_text,
    M.media_type,
    M.media_name
FROM Message M
JOIN AppUser U
    ON M.sender_phone = U.phone_number
JOIN Conversation C
    ON M.chat_id = C.chat_id
LEFT JOIN ChatGroup G
    ON C.group_id = G.group_id
WHERE M.media_type IS NOT NULL;


-- View 3: Summarise message activity by conversation
DROP VIEW IF EXISTS View_ConversationSummary;

CREATE VIEW View_ConversationSummary AS
SELECT
    C.chat_id,
    C.chat_type,
    COALESCE(G.group_name, 'Individual Chat') AS conversation_name,
    COUNT(M.message_time) AS total_messages,
    SUM(
        CASE
            WHEN M.media_type IS NOT NULL THEN 1
            ELSE 0
        END
    ) AS total_media_messages
FROM Conversation C
LEFT JOIN ChatGroup G
    ON C.group_id = G.group_id
LEFT JOIN Message M
    ON C.chat_id = M.chat_id
GROUP BY
    C.chat_id,
    C.chat_type,
    G.group_name;


-- Example usage of the views

SELECT *
FROM View_AllMessages
ORDER BY chat_id, message_time;

SELECT *
FROM View_MediaMessages
ORDER BY message_time;

SELECT *
FROM View_ConversationSummary
ORDER BY chat_id;
