TYPE=TRIGGERS
triggers='CREATE DEFINER=`root`@`localhost` TRIGGER Zone_Insert_Trigger AFTER INSERT ON Zones\nFOR EACH ROW\n  BEGIN\n    UPDATE Monitors SET ZoneCount=(SELECT COUNT(*) FROM Zones WHERE MonitorId=NEW.MonitorId) WHERE Id=NEW.MonitorID;\n  END' 'CREATE DEFINER=`root`@`localhost` TRIGGER Zone_Delete_Trigger AFTER DELETE ON Zones\nFOR EACH ROW\n  BEGIN\n    UPDATE Monitors SET ZoneCount=(SELECT COUNT(*) FROM Zones WHERE MonitorId=OLD.MonitorId) WHERE Id=OLD.MonitorID;\n  END'
sql_modes=1342177280 1342177280
definers='root@localhost' 'root@localhost'
client_cs_names='utf8' 'utf8'
connection_cl_names='utf8_general_ci' 'utf8_general_ci'
db_cl_names='utf8mb4_general_ci' 'utf8mb4_general_ci'
