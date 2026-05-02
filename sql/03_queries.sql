-- Messaging App Relational Database Design
-- File: 03_queries.sql
-- Purpose: Demonstrate SQL queries for message retrieval and reporting

-- Query 1: Show all messages with sender names and conversation types
SELECT
    M.chat_id,
    C.chat_type,
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
ORDER BY
    M.chat_id,
    M.message_time;


-- Query 2: Find all messages that contain media attachments
SELECT
    M.chat_id,
    M.message_time,
    U.user_name AS sender_name,
    M.message_text,
    M.media_type,
    M.media_name
FROM Message M
JOIN AppUser U
    ON M.sender_phone = U.phone_number
WHERE M.media_type IS NOT NULL
ORDER BY
    M.message_time;


-- Query 3: Show all messages from the Data Analytics Team group
SELECT
    M.chat_id,
    G.group_name,
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
JOIN ChatGroup G
    ON C.group_id = G.group_id
WHERE G.group_name = 'Data Analytics Team'
ORDER BY
    M.message_time;


-- Query 4: Count total messages and media messages by conversation
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
    G.group_name
ORDER BY
    C.chat_id;


-- Query 5: Show group members and their joined dates
SELECT
    G.group_name,
    U.user_name,
    GM.phone_number,
    GM.joined_date
FROM GroupMember GM
JOIN ChatGroup G
    ON GM.group_id = G.group_id
JOIN AppUser U
    ON GM.phone_number = U.phone_number
ORDER BY
    G.group_name,
    GM.joined_date,
    U.user_name;


-- Query 6: Show the latest message in each conversation
SELECT
    M.chat_id,
    C.chat_type,
    COALESCE(G.group_name, 'Individual Chat') AS conversation_name,
    M.message_time,
    U.user_name AS sender_name,
    M.message_text
FROM Message M
JOIN Conversation C
    ON M.chat_id = C.chat_id
LEFT JOIN ChatGroup G
    ON C.group_id = G.group_id
JOIN AppUser U
    ON M.sender_phone = U.phone_number
WHERE M.message_time = (
    SELECT MAX(M2.message_time)
    FROM Message M2
    WHERE M2.chat_id = M.chat_id
)
ORDER BY
    M.chat_id;
