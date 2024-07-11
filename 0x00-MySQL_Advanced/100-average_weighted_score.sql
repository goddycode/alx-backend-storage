-- This script creates a stored procedure ComputeAverageWeightedScoreForUser
-- The ComputeAverageWeightedScoreForUser procedure computes and stores the average weighted score for a student
DELIMITER $$

CREATE PROCEDURE ComputeAverageWeightedScoreForUser(
	IN user_id VARCHAR(255)
)
BEGIN
	SELECT sum(score * weight) / sum(weight * 100) * 100 FROM corrections LEFT JOIN projects ON corrections.project_id = projects.id WHERE user_id = corrections.user_id INTO @weighted_score;
	UPDATE users SET average_score = @weighted_score WHERE user_id = users.id;
END $$

DELIMITER ;
