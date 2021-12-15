SELECT A.contest_id, A.hacker_id, A.Name, 
        ifnull(SUM(total_submissions),0) As total_submissions, 
        ifnull(SUM(total_accepted_submissions),0) AS total_accepted_submissions,
        ifnull(SUM(total_views),0) AS total_views,
        ifnull(SUM(total_unique_views),0) AS total_unique_views
FROM Contests AS A

LEFT JOIN Colleges AS B
    ON A.contest_id = B.contest_id 

LEFT JOIN Challenges AS C
    ON B.college_id = C.college_id 

LEFT JOIN (SELECT challenge_id, SUM(total_views) AS total_views, 
                  SUM(total_unique_views) AS total_unique_views
           FROM View_Stats
           GROUP BY challenge_id) AS D 
    ON C.challenge_id = D.challenge_id 
    
LEFT JOIN (SELECT challenge_id, SUM(total_submissions) AS total_submissions, 
                  SUM(total_accepted_submissions) AS total_accepted_submissions
           FROM Submission_Stats
           GROUP BY challenge_id) AS E
    ON C.challenge_id = E.challenge_id 
    
GROUP BY A.contest_id, A.hacker_id, A.Name
HAVING (total_submissions + total_accepted_submissions + total_views + total_unique_views) > 0

ORDER BY A.contest_id
;
