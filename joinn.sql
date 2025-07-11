create database AIsol
use AIsol
-- Table 1: Servers 
CREATE TABLE Servers ( 
    server_id INT PRIMARY KEY, 
    server_name VARCHAR(50), 
    region VARCHAR(50) 
); 
INSERT INTO Servers VALUES 
(1, 'web-server-01', 'us-east'), 
(2, 'db-server-01', 'us-east'), 
(3, 'api-server-01', 'eu-west'), 
(4, 'cache-server-01', 'us-west'); 
-- Table 2: Alerts 
CREATE TABLE Alerts ( 
    alert_id INT PRIMARY KEY, 
    server_id INT, 
    alert_type VARCHAR(50), 
    severity VARCHAR(20) 
); 
INSERT INTO Alerts VALUES 
(101, 1, 'CPU Spike', 'High'), 
(102, 2, 'Disk Failure', 'Critical'), 
(103, 2, 'Memory Leak', 'Medium'), 
(104, 5, 'Network Latency', 'Low'); -- Invalid server_id (edge case) 
-- Table 3: AI Models 
CREATE TABLE AI_Models ( 
    model_id INT PRIMARY KEY, 
    model_name VARCHAR(50), 
    use_case VARCHAR(50) 
); 
INSERT INTO AI_Models VALUES 
(201, 'AnomalyDetector-v2', 'Alert Prediction'), 
(202, 'ResourceForecaster', 'Capacity Planning'), 
(203, 'LogParser-NLP', 'Log Analysis'); 
-- Table 4: ModelDeployments 
CREATE TABLE ModelDeployments ( 
    deployment_id INT PRIMARY KEY, 
    server_id INT, 
    model_id INT, 
    deployed_on DATE 
); 
 
INSERT INTO ModelDeployments VALUES 
(301, 1, 201, '2025-06-01'), 
(302, 2, 201, '2025-06-03'), 
(303, 2, 202, '2025-06-10'), 
(304, 3, 203, '2025-06-12');  

select * from Servers
select * from Alerts
select * from AI_Models
select * from ModelDeployments

--Task 1: INNER JOIN---
--List all alerts with the corresponding server name.
select server_name, alert_type
from Servers S INNER JOIN Alerts A
ON S.server_id = A.server_id

--Task 2: LEFT JOIN 
--List all servers and any alerts they might have received. 
select server_name, alert_type
from Servers S LEFT JOIN  Alerts A
ON S.server_id = A.server_id

--Task 3: RIGHT JOIN 
--Show all alerts and the server name that triggered them, including alerts without a matching server. 
select server_name, alert_type
from Servers S RIGHT JOIN  Alerts A
ON S.server_id = A.server_id

--Task 4: FULL OUTER JOIN 
--List all servers and alerts, including unmatched ones on both sides. 
select server_name, alert_type
from Servers S FULL OUTER JOIN  Alerts A
ON S.server_id = A.server_id

--Task 5: CROSS JOIN 
--Pair every AI model with every server (e.g., simulation of possible deployments). 
select server_name, model_name
from Servers S , AI_Models M

--Task 6: INNER JOIN with Filter 
--List all critical alerts with the server name. 
select server_name,alert_type, severity
from Servers S INNER JOIN  Alerts A
ON S.server_id = A.server_id
WHERE A.severity = 'Critical'

--Task 7: LEFT JOIN with NULL filter 
--Find servers that do not have any AI models deployed. 
select S.server_id, server_name
from Servers S LEFT JOIN ModelDeployments M  
ON S.server_id = M.server_id
WHERE M.server_id IS NULL

--Task 8: CROSS JOIN with WHERE 
--Simulate possible deployments for EU region servers only. 
select server_name, model_name
from Servers S CROSS JOIN AI_Models M
where  region LIKE 'eu-%'


