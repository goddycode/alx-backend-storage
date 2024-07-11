-- This script creates a stored procedure ComputeAverageWeightedScoreForUsers
-- The ComputeAverageWeightedScoreForUsers procedure computes and stores the average weighted score for a student
DELIMITER $$

CREATE PROCEDURE ComputeAverageWeightedScoreForUsers()
BEGIN
	UPDATE users INNER JOIN corrections ON corrections.user_id = users.id SET average_score = (SELECT sum(score * weight) / sum(weight * 100) * 100 FROM corrections INNER JOIN projects ON corrections.project_id = projects.id WHERE users.id = corrections.user_id);
END $$

DELIMITER ;
