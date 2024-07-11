-- This script creates a view need_meeting
-- The need_meeting view lists all students that have a score under 80 (strict) and no last_meeting for more than 1 month
CREATE VIEW need_meeting AS SELECT name FROM students WHERE (score < 80) AND (last_meeting < DATE_SUB(now(), INTERVAL 1 MONTH) OR ISNULL(last_meeting));
