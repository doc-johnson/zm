TYPE=TRIGGERS
triggers='CREATE DEFINER=`root`@`localhost` TRIGGER Events_Day_delete_trigger BEFORE DELETE ON Events_Day\nFOR EACH ROW BEGIN\n  UPDATE Monitors SET\n  DayEvents = GREATEST(COALESCE(DayEvents,1)-1,0),\n  DayEventDiskSpace=GREATEST(COALESCE(DayEventDiskSpace,0)-COALESCE(OLD.DiskSpace,0),0)\n  WHERE Id=OLD.MonitorId;\nEND' 'CREATE DEFINER=`root`@`localhost` TRIGGER Events_Day_update_trigger AFTER UPDATE ON Events_Day\nFOR EACH ROW\n  BEGIN\n    declare diff BIGINT default 0;\n\n    set diff = COALESCE(NEW.DiskSpace,0) - COALESCE(OLD.DiskSpace,0);\n    IF ( diff ) THEN\n      IF ( NEW.MonitorID != OLD.MonitorID ) THEN\n        UPDATE Monitors SET DayEventDiskSpace=GREATEST(COALESCE(DayEventDiskSpace,0)-COALESCE(OLD.DiskSpace,0),0) WHERE Monitors.Id=OLD.MonitorId;\n        UPDATE Monitors SET DayEventDiskSpace=COALESCE(DayEventDiskSpace,0)+COALESCE(NEW.DiskSpace,0) WHERE Monitors.Id=NEW.MonitorId;\n      ELSE\n        UPDATE Monitors SET DayEventDiskSpace=GREATEST(COALESCE(DayEventDiskSpace,0)+diff,0) WHERE Monitors.Id=NEW.MonitorId;\n      END IF;\n    END IF;\n  END'
sql_modes=1342177280 1342177280
definers='root@localhost' 'root@localhost'
client_cs_names='utf8' 'utf8'
connection_cl_names='utf8_general_ci' 'utf8_general_ci'
db_cl_names='utf8mb4_general_ci' 'utf8mb4_general_ci'
