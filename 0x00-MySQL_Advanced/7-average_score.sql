-- This script creates a ComputeAverageScoreForUser stored procedure
-- ComputeAverageScoreForUser computes and stores average score for a student
DELIMITER $$

CREATE PROCEDURE ComputeAverageScoreForUser(
	IN user_id VARCHAR(255)
)
BEGIN
	SELECT avg(score) FROM corrections WHERE user_id = corrections.user_id INTO @avg_score;
	UPDATE users SET average_score = @avg_score WHERE user_id = users.id;
END $$

DELIMITER ;
