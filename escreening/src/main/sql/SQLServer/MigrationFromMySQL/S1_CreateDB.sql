USE [SDC-PROD]
GO
 IF NOT EXISTS(SELECT * FROM sys.schemas WHERE [name] = N'dbo')      
     EXEC (N'CREATE SCHEMA dbo')                                   
 GO                                                               

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'assessment_appoint'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'assessment_appoint'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[assessment_appoint]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[assessment_appoint]
(
   [vet_assessment_id] int  NOT NULL,
   [appointment_date] datetime DEFAULT getdate()  NOT NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.assessment_appoint',
        N'SCHEMA', N'dbo',
        N'TABLE', N'assessment_appoint'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'assessment_formula'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'assessment_formula'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[assessment_formula]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[assessment_formula]
(
   [assessment_formula_id] int IDENTITY(2174, 1)  NOT NULL,
   [assessment_variable_id] int  NOT NULL,
   [display_order] int  NOT NULL,
   [formula_token] varchar(255)  NOT NULL,
   [user_defined] binary(1)  NOT NULL, -- bit  NOT NULL, CHANGE AFTER MIGRATIONS COMPLETE
   [date_created] datetime DEFAULT getdate()  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.assessment_formula',
        N'SCHEMA', N'dbo',
        N'TABLE', N'assessment_formula'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'assessment_status'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'assessment_status'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[assessment_status]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[assessment_status]
(
   [assessment_status_id] int  NOT NULL,
   [name] varchar(255)  NOT NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.assessment_status',
        N'SCHEMA', N'dbo',
        N'TABLE', N'assessment_status'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'assessment_var_children'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'assessment_var_children'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[assessment_var_children]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[assessment_var_children]
(
   [assessment_var_children_id] int IDENTITY(1156, 1)  NOT NULL,
   [variable_parent] int  NOT NULL,
   [variable_child] int  NOT NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.assessment_var_children',
        N'SCHEMA', N'dbo',
        N'TABLE', N'assessment_var_children'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'assessment_variable'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'assessment_variable'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[assessment_variable]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[assessment_variable]
(
   [assessment_variable_id] int IDENTITY(100000, 1)  NOT NULL,
   [assessment_variable_type_id] int  NOT NULL,
   [display_name] varchar(255)  NOT NULL,
   [description] varchar(1024) DEFAULT NULL  NULL,
   [measure_id] int DEFAULT NULL  NULL,
   [measure_answer_id] int DEFAULT NULL  NULL,
   [formula_template] varchar(max) DEFAULT NULL  NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.assessment_variable',
        N'SCHEMA', N'dbo',
        N'TABLE', N'assessment_variable'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'assessment_variable_column'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'assessment_variable_column'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[assessment_variable_column]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[assessment_variable_column]
(
   [assessment_variable_column_id] int IDENTITY(1, 1)  NOT NULL,
   [assessment_variable_id] int  NOT NULL,
   [column_num] int  NOT NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.assessment_variable_column',
        N'SCHEMA', N'dbo',
        N'TABLE', N'assessment_variable_column'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'assessment_variable_type'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'assessment_variable_type'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[assessment_variable_type]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[assessment_variable_type]
(
   [assessment_variable_type_id] int  NOT NULL,
   [name] varchar(255)  NOT NULL,
   [description] varchar(1024) DEFAULT NULL  NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.assessment_variable_type',
        N'SCHEMA', N'dbo',
        N'TABLE', N'assessment_variable_type'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'battery'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'battery'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[battery]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[battery]
(
   [battery_id] int IDENTITY(7, 1)  NOT NULL,
   [name] varchar(250) DEFAULT NULL  NULL,
   [description] varchar(1000) DEFAULT NULL  NULL,

   /*
   *   SSMA informational messages:
   *   M2SS0052: string literal was converted to NUMERIC literal
   */

   [is_disabled] smallint DEFAULT 0  NOT NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.battery',
        N'SCHEMA', N'dbo',
        N'TABLE', N'battery'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'battery_survey'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'battery_survey'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[battery_survey]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[battery_survey]
(
   [battery_survey_id] int IDENTITY(153, 1)  NOT NULL,
   [battery_id] int  NOT NULL,
   [survey_id] int  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.battery_survey',
        N'SCHEMA', N'dbo',
        N'TABLE', N'battery_survey'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'battery_template'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'battery_template'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[battery_template]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[battery_template]
(
   [battery_template_id] int IDENTITY(25, 1)  NOT NULL,
   [battery_id] int  NOT NULL,
   [template_id] int  NOT NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.battery_template',
        N'SCHEMA', N'dbo',
        N'TABLE', N'battery_template'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'calculation_type'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'calculation_type'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[calculation_type]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[calculation_type]
(
   [calculation_type_id] int  NOT NULL,
   [name] varchar(255)  NOT NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.calculation_type',
        N'SCHEMA', N'dbo',
        N'TABLE', N'calculation_type'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'clinic'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'clinic'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[clinic]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[clinic]
(
   [clinic_id] int IDENTITY(25, 1)  NOT NULL,
   [name] varchar(255)  NOT NULL,
   [vista_ien] varchar(255) DEFAULT NULL  NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.clinic',
        N'SCHEMA', N'dbo',
        N'TABLE', N'clinic'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'clinic_program'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'clinic_program'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[clinic_program]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[clinic_program]
(
   [clinic_program_id] int IDENTITY(25, 1)  NOT NULL,
   [clinic_id] int  NOT NULL,
   [program_id] int  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.clinic_program',
        N'SCHEMA', N'dbo',
        N'TABLE', N'clinic_program'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'clinic_survey'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'clinic_survey'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[clinic_survey]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[clinic_survey]
(
   [clinic_survey_id] int IDENTITY(1, 1)  NOT NULL,
   [clinic_id] int  NOT NULL,
   [survey_id] int  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.clinic_survey',
        N'SCHEMA', N'dbo',
        N'TABLE', N'clinic_survey'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'clinical_note'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'clinical_note'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[clinical_note]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[clinical_note]
(
   [clinical_note_id] int IDENTITY(130, 1)  NOT NULL,
   [vista_ien] varchar(250) DEFAULT NULL  NULL,
   [title] varchar(250) DEFAULT NULL  NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.clinical_note',
        N'SCHEMA', N'dbo',
        N'TABLE', N'clinical_note'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'clinical_reminder'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'clinical_reminder'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[clinical_reminder]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[clinical_reminder]
(
   [clinical_reminder_id] int IDENTITY(321, 1)  NOT NULL,
   [vista_ien] varchar(250) DEFAULT NULL  NULL,
   [name] varchar(250) DEFAULT NULL  NULL,
   [print_name] varchar(250) DEFAULT NULL  NULL,
   [clinical_reminder_class_code] varchar(250) DEFAULT NULL  NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.clinical_reminder',
        N'SCHEMA', N'dbo',
        N'TABLE', N'clinical_reminder'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'clinical_reminder_survey'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'clinical_reminder_survey'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[clinical_reminder_survey]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[clinical_reminder_survey]
(
   [clinical_reminder_survey_id] int IDENTITY(15, 1)  NOT NULL,
   [clinical_reminder_id] int  NOT NULL,
   [survey_id] int  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.clinical_reminder_survey',
        N'SCHEMA', N'dbo',
        N'TABLE', N'clinical_reminder_survey'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'consult'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'consult'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[consult]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[consult]
(
   [consult_id] int IDENTITY(2001, 1)  NOT NULL,
   [name] varchar(255)  NOT NULL,
   [vista_ien] varchar(255)  NOT NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.consult',
        N'SCHEMA', N'dbo',
        N'TABLE', N'consult'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'dashboard_alert'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'dashboard_alert'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[dashboard_alert]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[dashboard_alert]
(
   [dashboard_alert_id] int IDENTITY(10, 1)  NOT NULL,
   [name] varchar(255)  NOT NULL,
   [message] varchar(1000)  NOT NULL,
   [dashboard_alert_type_id] int  NOT NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.dashboard_alert',
        N'SCHEMA', N'dbo',
        N'TABLE', N'dashboard_alert'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'dashboard_alert_type'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'dashboard_alert_type'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[dashboard_alert_type]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[dashboard_alert_type]
(
   [dashboard_alert_type_id] int  NOT NULL,
   [name] varchar(255)  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.dashboard_alert_type',
        N'SCHEMA', N'dbo',
        N'TABLE', N'dashboard_alert_type'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'dialog_prompt'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'dialog_prompt'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[dialog_prompt]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[dialog_prompt]
(
   [dialog_prompt_id] int IDENTITY(17, 1)  NOT NULL,
   [name] varchar(255)  NOT NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.dialog_prompt',
        N'SCHEMA', N'dbo',
        N'TABLE', N'dialog_prompt'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'event'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'event'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[event]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[event]
(
   [event_id] int IDENTITY(8698, 1)  NOT NULL,
   [event_type_id] int  NOT NULL,
   [name] varchar(255)  NOT NULL,
   [related_object_id] int  NOT NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.event',
        N'SCHEMA', N'dbo',
        N'TABLE', N'event'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'event_type'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'event_type'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[event_type]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[event_type]
(
   [event_type_id] int  NOT NULL,
   [name] varchar(255)  NOT NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.event_type',
        N'SCHEMA', N'dbo',
        N'TABLE', N'event_type'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'export_log'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'export_log'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[export_log]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[export_log]
(
   [export_log_id] int IDENTITY(1, 1)  NOT NULL,
   [exported_by_user_id] int  NOT NULL,
   [clinician_user_id] int DEFAULT NULL  NULL,
   [created_by_user_id] int DEFAULT NULL  NULL,
   [export_type_id] int  NOT NULL,
   [assessment_start_filter] datetime DEFAULT NULL  NULL,
   [assessment_end_filter] datetime DEFAULT NULL  NULL,
   [program_id] int DEFAULT NULL  NULL,
   [veteran_id] int DEFAULT NULL  NULL,
   [comment] varchar(1024) DEFAULT NULL  NULL,
   [file_path] varchar(255)  NOT NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL,
   [export_zip] varbinary(max)  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.export_log',
        N'SCHEMA', N'dbo',
        N'TABLE', N'export_log'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'export_log_audit'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'export_log_audit'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[export_log_audit]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[export_log_audit]
(
   [export_log_audit_id] int IDENTITY(1, 1)  NOT NULL,
   [comment] varchar(100)  NOT NULL,
   [exported_by_user_id] int  NOT NULL,
   [export_log_id] int  NOT NULL,
   [date_updated] datetime  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.export_log_audit',
        N'SCHEMA', N'dbo',
        N'TABLE', N'export_log_audit'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'export_type'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'export_type'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[export_type]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[export_type]
(
   [export_type_id] int  NOT NULL,
   [name] varchar(255)  NOT NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.export_type',
        N'SCHEMA', N'dbo',
        N'TABLE', N'export_type'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'exportdata_filter_options'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'exportdata_filter_options'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[exportdata_filter_options]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[exportdata_filter_options]
(
   [exportdata_filter_options_id] int  NOT NULL,
   [name] varchar(255)  NOT NULL,
   [num_days] int  NOT NULL,
   [description] varchar(255) DEFAULT NULL  NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.exportdata_filter_options',
        N'SCHEMA', N'dbo',
        N'TABLE', N'exportdata_filter_options'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'health_factor'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'health_factor'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[health_factor]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[health_factor]
(
   [health_factor_id] int IDENTITY(276, 1)  NOT NULL,
   [name] varchar(255)  NOT NULL,
   [vista_ien] varchar(64) DEFAULT NULL  NULL,
   [clinical_reminder_id] int  NOT NULL,

   /*
   *   SSMA informational messages:
   *   M2SS0052: string literal was converted to NUMERIC literal
   */

   [is_historical] smallint DEFAULT 0  NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.health_factor',
        N'SCHEMA', N'dbo',
        N'TABLE', N'health_factor'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'health_factor_dialog_prompt'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'health_factor_dialog_prompt'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[health_factor_dialog_prompt]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[health_factor_dialog_prompt]
(
   [health_factor_dialog_prompt_id] int IDENTITY(1, 1)  NOT NULL,
   [health_factor_id] int  NOT NULL,
   [dialog_prompt_id] int  NOT NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.health_factor_dialog_prompt',
        N'SCHEMA', N'dbo',
        N'TABLE', N'health_factor_dialog_prompt'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'measure'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'measure'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[measure]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[measure]
(
   [measure_id] int IDENTITY(1458, 1)  NOT NULL,
   [measure_type_id] int  NOT NULL,
   [measure_text] varchar(2000)  NOT NULL,

   /*
   *   SSMA informational messages:
   *   M2SS0052: string literal was converted to NUMERIC literal
   */

   [is_required] smallint DEFAULT 0  NOT NULL,

   /*
   *   SSMA informational messages:
   *   M2SS0052: string literal was converted to NUMERIC literal
   */

   [is_patient_protected_info] smallint DEFAULT 0  NOT NULL,

   /*
   *   SSMA informational messages:
   *   M2SS0052: string literal was converted to NUMERIC literal
   */

   [is_mha] smallint DEFAULT 0  NOT NULL,

   /*
   *   SSMA informational messages:
   *   M2SS0052: string literal was converted to NUMERIC literal
   */

   [score_weight] float(24) DEFAULT 0  NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL,
   [parent_measure_id] int DEFAULT NULL  NULL,
   [display_order] int DEFAULT NULL  NULL,
   [vista_text] varchar(2000) DEFAULT NULL  NULL,
   [variable_name] varchar(64) DEFAULT NULL  NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.measure',
        N'SCHEMA', N'dbo',
        N'TABLE', N'measure'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'measure_answer'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'measure_answer'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[measure_answer]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[measure_answer]
(
   [measure_answer_id] int IDENTITY(8618, 1)  NOT NULL,
   [measure_id] int DEFAULT NULL  NULL,
   [export_name] varchar(250) DEFAULT NULL  NULL,
   [other_export_name] varchar(250) DEFAULT NULL  NULL,
   [answer_text] varchar(1000) DEFAULT NULL  NULL,
   [answer_type] varchar(250) DEFAULT NULL  NULL,
   [answer_value] int DEFAULT NULL  NULL,
   [calculation_type_id] int DEFAULT NULL  NULL,
   [calculation_value] varchar(250) DEFAULT NULL  NULL,
   [mha_value] varchar(250) DEFAULT NULL  NULL,

   /*
   *   SSMA informational messages:
   *   M2SS0052: string literal was converted to NUMERIC literal
   */

   [display_order] int DEFAULT 0  NULL,
   [vista_text] varchar(1000) DEFAULT NULL  NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.measure_answer',
        N'SCHEMA', N'dbo',
        N'TABLE', N'measure_answer'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'measure_answer_validation'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'measure_answer_validation'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[measure_answer_validation]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[measure_answer_validation]
(
   [measure_answer_validation_id] int IDENTITY(1, 1)  NOT NULL,
   [measure_answer_id] int  NOT NULL,
   [validation_id] int  NOT NULL,
   [boolean_value] int DEFAULT NULL  NULL,
   [number_value] int DEFAULT NULL  NULL,
   [text_value] varchar(1000) DEFAULT NULL  NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.measure_answer_validation',
        N'SCHEMA', N'dbo',
        N'TABLE', N'measure_answer_validation'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'measure_type'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'measure_type'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[measure_type]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[measure_type]
(
   [measure_type_id] int  NOT NULL,
   [name] varchar(255)  NOT NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.measure_type',
        N'SCHEMA', N'dbo',
        N'TABLE', N'measure_type'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'measure_validation'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'measure_validation'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[measure_validation]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[measure_validation]
(
   [measure_validation_id] int IDENTITY(46, 1)  NOT NULL,
   [measure_id] int  NOT NULL,
   [validation_id] int  NOT NULL,
   [boolean_value] int DEFAULT NULL  NULL,
   [number_value] int DEFAULT NULL  NULL,
   [text_value] varchar(1000) DEFAULT NULL  NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.measure_validation',
        N'SCHEMA', N'dbo',
        N'TABLE', N'measure_validation'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'note_title'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'note_title'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[note_title]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[note_title]
(
   [note_title_id] int IDENTITY(129, 1)  NOT NULL,
   [vista_ien] varchar(250) DEFAULT NULL  NULL,
   [name] varchar(250) DEFAULT NULL  NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.note_title',
        N'SCHEMA', N'dbo',
        N'TABLE', N'note_title'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'note_title_map'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'note_title_map'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[note_title_map]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[note_title_map]
(
   [note_title_map_id] int IDENTITY(11, 1)  NOT NULL,
   [note_title_id] int  NOT NULL,
   [program_id] int DEFAULT NULL  NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.note_title_map',
        N'SCHEMA', N'dbo',
        N'TABLE', N'note_title_map'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'person_type'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'person_type'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[person_type]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[person_type]
(
   [person_type_id] int  NOT NULL,
   [name] varchar(255)  NOT NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.person_type',
        N'SCHEMA', N'dbo',
        N'TABLE', N'person_type'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'program'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'program'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[program]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[program]
(
   [program_id] int IDENTITY(6, 1)  NOT NULL,
   [name] varchar(255)  NOT NULL,

   /*
   *   SSMA informational messages:
   *   M2SS0052: string literal was converted to NUMERIC literal
   */

   [is_disabled] smallint DEFAULT 0  NOT NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.program',
        N'SCHEMA', N'dbo',
        N'TABLE', N'program'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'program_battery'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'program_battery'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[program_battery]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[program_battery]
(
   [program_battery_id] int IDENTITY(8, 1)  NOT NULL,
   [program_id] int  NOT NULL,
   [battery_id] int  NOT NULL,
   [program_initials] varchar(15)  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.program_battery',
        N'SCHEMA', N'dbo',
        N'TABLE', N'program_battery'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'program_survey'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'program_survey'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[program_survey]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[program_survey]
(
   [program_survey_id] int IDENTITY(1, 1)  NOT NULL,
   [program_id] int  NOT NULL,
   [survey_id] int  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.program_survey',
        N'SCHEMA', N'dbo',
        N'TABLE', N'program_survey'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'role'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'role'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[role]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[role]
(
   [role_id] int  NOT NULL,
   [name] varchar(255)  NOT NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.role',
        N'SCHEMA', N'dbo',
        N'TABLE', N'role'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'rule'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'rule'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[rule]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[rule]
(
   [rule_id] int IDENTITY(7612, 1)  NOT NULL,
   [name] varchar(255)  NOT NULL,
   [expression] varchar(1000)  NOT NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL,
   [condition_json] varchar(max)  NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.rule',
        N'SCHEMA', N'dbo',
        N'TABLE', N'rule'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'rule_assessment_variable'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'rule_assessment_variable'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[rule_assessment_variable]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[rule_assessment_variable]
(
   [rule_assessment_variable_id] int IDENTITY(1373, 1)  NOT NULL,
   [rule_id] int  NOT NULL,
   [assessment_variable_id] int  NOT NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.rule_assessment_variable',
        N'SCHEMA', N'dbo',
        N'TABLE', N'rule_assessment_variable'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'rule_event'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'rule_event'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[rule_event]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[rule_event]
(
   [rule_event_id] int IDENTITY(164, 1)  NOT NULL,
   [rule_id] int  NOT NULL,
   [event_id] int  NOT NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.rule_event',
        N'SCHEMA', N'dbo',
        N'TABLE', N'rule_event'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'survey'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'survey'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[survey]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[survey]
(
   [survey_id] int IDENTITY(59, 1)  NOT NULL,
   [survey_section_id] int  NOT NULL,
   [name] varchar(255)  NOT NULL,
   [description] varchar(255) DEFAULT NULL  NULL,
   [version] int DEFAULT NULL  NULL,

   /*
   *   SSMA informational messages:
   *   M2SS0052: string literal was converted to NUMERIC literal
   */

   [has_mha] smallint DEFAULT 0  NOT NULL,
   [mha_test_name] varchar(255) DEFAULT NULL  NULL,
   [mha_result_group_ien] varchar(255) DEFAULT NULL  NULL,
   [vista_title] varchar(255) DEFAULT NULL  NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL,
   [display_order_for_section] int  NOT NULL,

   /*
   *   SSMA informational messages:
   *   M2SS0052: string literal was converted to NUMERIC literal
   */

   [is_published] smallint DEFAULT 0  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.survey',
        N'SCHEMA', N'dbo',
        N'TABLE', N'survey'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'survey_attempt'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'survey_attempt'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[survey_attempt]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[survey_attempt]
(
   [survey_attempt_id] int IDENTITY(1, 1)  NOT NULL,
   [veteran_assessment_survey_id] int  NOT NULL,
   [start_date] datetime DEFAULT NULL  NULL,
   [end_date] datetime DEFAULT NULL  NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.survey_attempt',
        N'SCHEMA', N'dbo',
        N'TABLE', N'survey_attempt'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'survey_measure_response'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'survey_measure_response'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[survey_measure_response]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[survey_measure_response]
(
   [survey_measure_response_id] int IDENTITY(1519, 1)  NOT NULL,
   [veteran_assessment_id] int  NOT NULL,
   [survey_id] int  NOT NULL,
   [measure_id] int  NOT NULL,
   [measure_answer_id] int  NOT NULL,
   [boolean_value] int DEFAULT NULL  NULL,
   [number_value] bigint DEFAULT NULL  NULL,
   [text_value] varchar(1000) DEFAULT NULL  NULL,
   [other_value] varchar(1000) DEFAULT NULL  NULL,
   [score] float(24) DEFAULT NULL  NULL,
   [tabular_row] int DEFAULT NULL  NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL,

   /*
   *   SSMA informational messages:
   *   M2SS0046: The Date value is Zero
   *   M2SS0231: Zero-date, zero-in-date and invalid dates to not null columns has been replaced with GetDate()/Constant date
   */

   [date_modified] datetime DEFAULT getdate()  NOT NULL,
   [copiedFromAssessment] int DEFAULT NULL  NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.survey_measure_response',
        N'SCHEMA', N'dbo',
        N'TABLE', N'survey_measure_response'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'survey_page'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'survey_page'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[survey_page]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[survey_page]
(
   [survey_page_id] int IDENTITY(181, 1)  NOT NULL,
   [survey_id] int  NOT NULL,
   [title] varchar(250) DEFAULT NULL  NULL,
   [description] varchar(250) DEFAULT NULL  NULL,
   [page_number] int  NOT NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.survey_page',
        N'SCHEMA', N'dbo',
        N'TABLE', N'survey_page'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'survey_page_measure'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'survey_page_measure'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[survey_page_measure]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[survey_page_measure]
(
   [survey_page_measure_id] int IDENTITY(5703, 1)  NOT NULL,
   [survey_page_id] int  NOT NULL,
   [measure_id] int  NOT NULL,

   /*
   *   SSMA informational messages:
   *   M2SS0052: string literal was converted to NUMERIC literal
   */

   [display_order] int DEFAULT 0  NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.survey_page_measure',
        N'SCHEMA', N'dbo',
        N'TABLE', N'survey_page_measure'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'survey_score_interval'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'survey_score_interval'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[survey_score_interval]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[survey_score_interval]
(
   [id] int IDENTITY(39, 1)  NOT NULL,
   [survey_id] int  NOT NULL,
   [min] varchar(10)  NOT NULL,
   [max] varchar(10)  NOT NULL,
   [meaning] varchar(200)  NOT NULL,

   /*
   *   SSMA informational messages:
   *   M2SS0052: string literal was converted to NUMERIC literal
   */

   [exception] int DEFAULT 0  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.survey_score_interval',
        N'SCHEMA', N'dbo',
        N'TABLE', N'survey_score_interval'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'survey_section'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'survey_section'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[survey_section]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[survey_section]
(
   [survey_section_id] int IDENTITY(12, 1)  NOT NULL,
   [name] varchar(255)  NOT NULL,
   [description] varchar(255) DEFAULT NULL  NULL,
   [display_order] int DEFAULT NULL  NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.survey_section',
        N'SCHEMA', N'dbo',
        N'TABLE', N'survey_section'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'survey_template'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'survey_template'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[survey_template]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[survey_template]
(
   [survey_template_id] int IDENTITY(93, 1)  NOT NULL,
   [survey_id] int  NOT NULL,
   [template_id] int  NOT NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.survey_template',
        N'SCHEMA', N'dbo',
        N'TABLE', N'survey_template'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'system_property'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'system_property'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[system_property]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[system_property]
(
   [system_property_id] int IDENTITY(2, 1)  NOT NULL,
   [name] varchar(255)  NOT NULL,
   [boolean_value] int DEFAULT NULL  NULL,
   [number_value] int DEFAULT NULL  NULL,
   [text_value] varchar(1000) DEFAULT NULL  NULL,
   [description] varchar(1000) DEFAULT NULL  NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.system_property',
        N'SCHEMA', N'dbo',
        N'TABLE', N'system_property'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'template'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'template'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[template]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[template]
(
   [template_id] int IDENTITY(3711, 1)  NOT NULL,
   [template_type_id] int  NOT NULL,
   [name] varchar(255)  NOT NULL,
   [description] varchar(1024) DEFAULT NULL  NULL,
   [template_file] varchar(max)  NOT NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL,

   /*
   *   SSMA informational messages:
   *   M2SS0052: string literal was converted to NUMERIC literal
   */

   [is_graphical] smallint DEFAULT 0  NOT NULL,
   [json_file] varchar(max)  NULL,
   [date_modified] datetime DEFAULT NULL  NULL,
   [graph_params] varchar(max)  NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.template',
        N'SCHEMA', N'dbo',
        N'TABLE', N'template'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'template_type'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'template_type'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[template_type]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[template_type]
(
   [template_type_id] int  NOT NULL,
   [name] varchar(255)  NOT NULL,
   [description] varchar(1024) DEFAULT NULL  NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.template_type',
        N'SCHEMA', N'dbo',
        N'TABLE', N'template_type'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'user'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'user'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[user]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[user]
(
   [user_id] int IDENTITY(15, 1)  NOT NULL,
   [role_id] int  NOT NULL,
   [user_status_id] int  NOT NULL,
   [login_id] varchar(255)  NOT NULL,
   [password] varchar(255) DEFAULT NULL  NULL,
   [first_name] varchar(255) DEFAULT NULL  NULL,
   [middle_name] varchar(255) DEFAULT NULL  NULL,
   [last_name] varchar(255) DEFAULT NULL  NULL,
   [email_address] varchar(255) DEFAULT NULL  NULL,
   [email_address2] varchar(255) DEFAULT NULL  NULL,
   [phone_number] varchar(255) DEFAULT NULL  NULL,
   [phone_number_ext] varchar(255) DEFAULT NULL  NULL,
   [phone_number2] varchar(255) DEFAULT NULL  NULL,
   [phone_number2_ext] varchar(255) DEFAULT NULL  NULL,
   [vista_duz] varchar(255) DEFAULT NULL  NULL,
   [vista_vpid] varchar(255) DEFAULT NULL  NULL,
   [vista_division] varchar(255) DEFAULT NULL  NULL,

   /*
   *   SSMA informational messages:
   *   M2SS0052: string literal was converted to NUMERIC literal
   */

   [cprs_verified] smallint DEFAULT 0  NOT NULL,
   [date_password_changed] datetime DEFAULT NULL  NULL,
   [last_login_date] datetime DEFAULT NULL  NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.`user`',
        N'SCHEMA', N'dbo',
        N'TABLE', N'user'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'user_clinic'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'user_clinic'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[user_clinic]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[user_clinic]
(
   [user_clinic_id] int IDENTITY(1, 1)  NOT NULL,
   [user_id] int  NOT NULL,
   [clinic_id] int  NOT NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.user_clinic',
        N'SCHEMA', N'dbo',
        N'TABLE', N'user_clinic'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'user_program'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'user_program'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[user_program]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[user_program]
(
   [user_program_id] int IDENTITY(16, 1)  NOT NULL,
   [user_id] int  NOT NULL,
   [program_id] int  NOT NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.user_program',
        N'SCHEMA', N'dbo',
        N'TABLE', N'user_program'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'user_status'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'user_status'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[user_status]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[user_status]
(
   [user_status_id] int IDENTITY(4, 1)  NOT NULL,
   [name] varchar(255)  NOT NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.user_status',
        N'SCHEMA', N'dbo',
        N'TABLE', N'user_status'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'validation'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'validation'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[validation]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[validation]
(
   [validation_id] int  NOT NULL,
   [code] varchar(255)  NOT NULL,
   [description] varchar(255)  NOT NULL,
   [data_type] varchar(255)  NOT NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.validation',
        N'SCHEMA', N'dbo',
        N'TABLE', N'validation'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'variable_template'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'variable_template'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[variable_template]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[variable_template]
(
   [variable_template_id] int IDENTITY(22178, 1)  NOT NULL,
   [assessment_variable_id] int  NOT NULL,
   [template_id] int  NOT NULL,
   [override_display_value] varchar(1024) DEFAULT NULL  NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.variable_template',
        N'SCHEMA', N'dbo',
        N'TABLE', N'variable_template'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'veteran'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'veteran'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[veteran]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[veteran]
(
   [veteran_id] int IDENTITY(50, 1)  NOT NULL,
   [first_name] varchar(255) DEFAULT NULL  NULL,
   [middle_name] varchar(255) DEFAULT NULL  NULL,
   [last_name] varchar(255)  NOT NULL,
   [suffix] varchar(255) DEFAULT NULL  NULL,
   [ssn_last_four] varchar(4)  NOT NULL,
   [birth_date] date DEFAULT NULL  NULL,
   [email] varchar(50) DEFAULT NULL  NULL,
   [phone] varchar(50) DEFAULT NULL  NULL,
   [office_phone] varchar(50) DEFAULT NULL  NULL,
   [cell_phone] varchar(50) DEFAULT NULL  NULL,
   [best_time_to_call] varchar(50) DEFAULT NULL  NULL,
   [best_time_to_call_other] varchar(50) DEFAULT NULL  NULL,
   [gender] varchar(10) DEFAULT NULL  NULL,
   [vista_local_pid] varchar(16) DEFAULT NULL  NULL,
   [guid] varchar(36)  NOT NULL,
   [veteran_ien] varchar(255) DEFAULT NULL  NULL,
   [vista_first_name] varchar(255) DEFAULT NULL  NULL,
   [vista_middle_name] varchar(255) DEFAULT NULL  NULL,
   [date_refreshed_from_vista] datetime DEFAULT NULL  NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL,

   /*
   *   SSMA informational messages:
   *   M2SS0052: string literal was converted to NUMERIC literal
   */

   [is_sensitive] smallint DEFAULT 0  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.veteran',
        N'SCHEMA', N'dbo',
        N'TABLE', N'veteran'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'veteran_assessment'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'veteran_assessment'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[veteran_assessment]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[veteran_assessment]
(
   [veteran_assessment_id] int IDENTITY(58, 1)  NOT NULL,
   [veteran_id] int  NOT NULL,
   [clinician_id] int DEFAULT NULL  NULL,
   [clinic_id] int DEFAULT NULL  NULL,
   [program_id] int DEFAULT NULL  NULL,
   [assessment_status_id] int  NOT NULL,
   [note_title_id] int DEFAULT NULL  NULL,
   [battery_id] int DEFAULT NULL  NULL,
   [access_mode] int DEFAULT NULL  NULL,

   /*
   *   SSMA informational messages:
   *   M2SS0052: string literal was converted to NUMERIC literal
   */

   [duration] int DEFAULT 0  NULL,

   /*
   *   SSMA informational messages:
   *   M2SS0052: string literal was converted to NUMERIC literal
   */

   [percent_complete] int DEFAULT 0  NULL,
   [created_by_user_id] int  NOT NULL,
   [signed_by_user_id] int DEFAULT NULL  NULL,
   [date_completed] datetime DEFAULT NULL  NULL,
   [date_updated] datetime DEFAULT getdate()  NOT NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL,
   [date_archived] datetime DEFAULT NULL  NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.veteran_assessment',
        N'SCHEMA', N'dbo',
        N'TABLE', N'veteran_assessment'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'veteran_assessment_action'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'veteran_assessment_action'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[veteran_assessment_action]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[veteran_assessment_action]
(
   [veteran_assessment_action_id] int IDENTITY(1, 1)  NOT NULL,
   [name] varchar(255)  NOT NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.veteran_assessment_action',
        N'SCHEMA', N'dbo',
        N'TABLE', N'veteran_assessment_action'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'veteran_assessment_audit_log'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'veteran_assessment_audit_log'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[veteran_assessment_audit_log]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[veteran_assessment_audit_log]
(
   [veteran_assessment_audit_log_id] int IDENTITY(8, 1)  NOT NULL,
   [veteran_assessment_id] int  NOT NULL,
   [person_id] int  NOT NULL,
   [person_last_name] varchar(255)  NOT NULL,
   [person_first_name] varchar(255) DEFAULT NULL  NULL,
   [person_type_id] int  NOT NULL,
   [assessment_status_id] int  NOT NULL,
   [veteran_assessment_event_id] int  NOT NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.veteran_assessment_audit_log',
        N'SCHEMA', N'dbo',
        N'TABLE', N'veteran_assessment_audit_log'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'veteran_assessment_consult'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'veteran_assessment_consult'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[veteran_assessment_consult]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[veteran_assessment_consult]
(
   [veteran_assessment_consult_id] int IDENTITY(1, 1)  NOT NULL,
   [veteran_assessment_id] int  NOT NULL,
   [consult_id] int  NOT NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.veteran_assessment_consult',
        N'SCHEMA', N'dbo',
        N'TABLE', N'veteran_assessment_consult'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'veteran_assessment_dashboard_alert'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'veteran_assessment_dashboard_alert'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[veteran_assessment_dashboard_alert]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[veteran_assessment_dashboard_alert]
(
   [veteran_assessment_dashboard_alert_id] int IDENTITY(21, 1)  NOT NULL,
   [veteran_assessment_id] int  NOT NULL,
   [dashboard_alert_id] int  NOT NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.veteran_assessment_dashboard_alert',
        N'SCHEMA', N'dbo',
        N'TABLE', N'veteran_assessment_dashboard_alert'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'veteran_assessment_event'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'veteran_assessment_event'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[veteran_assessment_event]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[veteran_assessment_event]
(
   [veteran_assessment_event_id] int  NOT NULL,
   [name] varchar(255)  NOT NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.veteran_assessment_event',
        N'SCHEMA', N'dbo',
        N'TABLE', N'veteran_assessment_event'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'veteran_assessment_health_factor'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'veteran_assessment_health_factor'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[veteran_assessment_health_factor]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[veteran_assessment_health_factor]
(
   [veteran_assessment_health_factor_id] int IDENTITY(2, 1)  NOT NULL,
   [veteran_assessment_id] int  NOT NULL,
   [health_factor_id] int  NOT NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.veteran_assessment_health_factor',
        N'SCHEMA', N'dbo',
        N'TABLE', N'veteran_assessment_health_factor'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'veteran_assessment_log'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'veteran_assessment_log'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[veteran_assessment_log]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[veteran_assessment_log]
(
   [veteran_assessment_log_id] int IDENTITY(1, 1)  NOT NULL,
   [veteran_assessment_id] int  NOT NULL,
   [veteran_id] int  NOT NULL,
   [veteran_asessment_survey_id] int DEFAULT NULL  NULL,
   [survey_id] int DEFAULT NULL  NULL,
   [survey_page_id] int DEFAULT NULL  NULL,
   [veteran_assessment_action_id] int  NOT NULL,
   [measure_id] int DEFAULT NULL  NULL,
   [message] varchar(2000)  NOT NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.veteran_assessment_log',
        N'SCHEMA', N'dbo',
        N'TABLE', N'veteran_assessment_log'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'veteran_assessment_measure_visibility'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'veteran_assessment_measure_visibility'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[veteran_assessment_measure_visibility]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[veteran_assessment_measure_visibility]
(
   [veteran_assessment_measure_visibility_id] int IDENTITY(1, 1)  NOT NULL,
   [veteran_assessment_id] int  NOT NULL,
   [measure_id] int  NOT NULL,

   /*
   *   SSMA informational messages:
   *   M2SS0052: string literal was converted to NUMERIC literal
   */

   [is_visible] smallint DEFAULT 0  NOT NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.veteran_assessment_measure_visibility',
        N'SCHEMA', N'dbo',
        N'TABLE', N'veteran_assessment_measure_visibility'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'veteran_assessment_note'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'veteran_assessment_note'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[veteran_assessment_note]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[veteran_assessment_note]
(
   [veteran_assessment_note_id] int IDENTITY(1, 1)  NOT NULL,
   [veteran_assessment_id] int  NOT NULL,
   [clinical_note_id] int  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.veteran_assessment_note',
        N'SCHEMA', N'dbo',
        N'TABLE', N'veteran_assessment_note'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'veteran_assessment_question_presence'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'veteran_assessment_question_presence'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[veteran_assessment_question_presence]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[veteran_assessment_question_presence]
(
   [veteran_assessment_id] int DEFAULT NULL  NULL,
   [measure_id] int DEFAULT NULL  NULL,
   [skipped] int DEFAULT NULL  NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.veteran_assessment_question_presence',
        N'SCHEMA', N'dbo',
        N'TABLE', N'veteran_assessment_question_presence'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'veteran_assessment_survey'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'veteran_assessment_survey'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[veteran_assessment_survey]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[veteran_assessment_survey]
(
   [veteran_assessment_survey_id] int IDENTITY(111, 1)  NOT NULL,
   [veteran_assessment_id] int  NOT NULL,
   [survey_id] int  NOT NULL,

   /*
   *   SSMA informational messages:
   *   M2SS0052: string literal was converted to NUMERIC literal
   */

   [total_question_count] int DEFAULT 0  NULL,

   /*
   *   SSMA informational messages:
   *   M2SS0052: string literal was converted to NUMERIC literal
   */

   [total_response_count] int DEFAULT 0  NULL,
   [mha_result] varchar(1000) DEFAULT NULL  NULL,
   [date_created] datetime DEFAULT getdate()  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.veteran_assessment_survey',
        N'SCHEMA', N'dbo',
        N'TABLE', N'veteran_assessment_survey'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'veteran_assessment_survey_score'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'veteran_assessment_survey_score'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[veteran_assessment_survey_score]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[veteran_assessment_survey_score]
(
   [assessment_survey_score_id] int IDENTITY(1, 1)  NOT NULL,
   [veteran_assessment_id] int  NOT NULL,
   [survey_id] int  NOT NULL,
   [av_name] varchar(255)  NOT NULL,
   [survey_score] int  NOT NULL,
   [veteran_id] int  NOT NULL,
   [clinic_id] int  NOT NULL,
   [screen_number] int DEFAULT NULL  NULL,
   [date_completed] datetime DEFAULT NULL  NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'`sdc-prod`.veteran_assessment_survey_score',
        N'SCHEMA', N'dbo',
        N'TABLE', N'veteran_assessment_survey_score'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_assessment_appoint_vet_assessment_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[assessment_appoint] DROP CONSTRAINT [PK_assessment_appoint_vet_assessment_id]
 GO



ALTER TABLE [dbo].[assessment_appoint]
 ADD CONSTRAINT [PK_assessment_appoint_vet_assessment_id]
 PRIMARY KEY 
   CLUSTERED ([vet_assessment_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_assessment_formula_assessment_formula_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[assessment_formula] DROP CONSTRAINT [PK_assessment_formula_assessment_formula_id]
 GO



ALTER TABLE [dbo].[assessment_formula]
 ADD CONSTRAINT [PK_assessment_formula_assessment_formula_id]
 PRIMARY KEY 
   CLUSTERED ([assessment_formula_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_assessment_status_assessment_status_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[assessment_status] DROP CONSTRAINT [PK_assessment_status_assessment_status_id]
 GO



ALTER TABLE [dbo].[assessment_status]
 ADD CONSTRAINT [PK_assessment_status_assessment_status_id]
 PRIMARY KEY 
   CLUSTERED ([assessment_status_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_assessment_var_children_assessment_var_children_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[assessment_var_children] DROP CONSTRAINT [PK_assessment_var_children_assessment_var_children_id]
 GO



ALTER TABLE [dbo].[assessment_var_children]
 ADD CONSTRAINT [PK_assessment_var_children_assessment_var_children_id]
 PRIMARY KEY 
   CLUSTERED ([assessment_var_children_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_assessment_variable_assessment_variable_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[assessment_variable] DROP CONSTRAINT [PK_assessment_variable_assessment_variable_id]
 GO



ALTER TABLE [dbo].[assessment_variable]
 ADD CONSTRAINT [PK_assessment_variable_assessment_variable_id]
 PRIMARY KEY 
   CLUSTERED ([assessment_variable_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_assessment_variable_column_assessment_variable_column_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[assessment_variable_column] DROP CONSTRAINT [PK_assessment_variable_column_assessment_variable_column_id]
 GO



ALTER TABLE [dbo].[assessment_variable_column]
 ADD CONSTRAINT [PK_assessment_variable_column_assessment_variable_column_id]
 PRIMARY KEY 
   CLUSTERED ([assessment_variable_column_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_assessment_variable_type_assessment_variable_type_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[assessment_variable_type] DROP CONSTRAINT [PK_assessment_variable_type_assessment_variable_type_id]
 GO



ALTER TABLE [dbo].[assessment_variable_type]
 ADD CONSTRAINT [PK_assessment_variable_type_assessment_variable_type_id]
 PRIMARY KEY 
   CLUSTERED ([assessment_variable_type_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_battery_battery_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[battery] DROP CONSTRAINT [PK_battery_battery_id]
 GO



ALTER TABLE [dbo].[battery]
 ADD CONSTRAINT [PK_battery_battery_id]
 PRIMARY KEY 
   CLUSTERED ([battery_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_battery_survey_battery_survey_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[battery_survey] DROP CONSTRAINT [PK_battery_survey_battery_survey_id]
 GO



ALTER TABLE [dbo].[battery_survey]
 ADD CONSTRAINT [PK_battery_survey_battery_survey_id]
 PRIMARY KEY 
   CLUSTERED ([battery_survey_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_battery_template_battery_template_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[battery_template] DROP CONSTRAINT [PK_battery_template_battery_template_id]
 GO



ALTER TABLE [dbo].[battery_template]
 ADD CONSTRAINT [PK_battery_template_battery_template_id]
 PRIMARY KEY 
   CLUSTERED ([battery_template_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_calculation_type_calculation_type_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[calculation_type] DROP CONSTRAINT [PK_calculation_type_calculation_type_id]
 GO



ALTER TABLE [dbo].[calculation_type]
 ADD CONSTRAINT [PK_calculation_type_calculation_type_id]
 PRIMARY KEY 
   CLUSTERED ([calculation_type_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_clinic_clinic_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[clinic] DROP CONSTRAINT [PK_clinic_clinic_id]
 GO



ALTER TABLE [dbo].[clinic]
 ADD CONSTRAINT [PK_clinic_clinic_id]
 PRIMARY KEY 
   CLUSTERED ([clinic_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_clinic_program_clinic_program_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[clinic_program] DROP CONSTRAINT [PK_clinic_program_clinic_program_id]
 GO



ALTER TABLE [dbo].[clinic_program]
 ADD CONSTRAINT [PK_clinic_program_clinic_program_id]
 PRIMARY KEY 
   CLUSTERED ([clinic_program_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_clinic_survey_clinic_survey_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[clinic_survey] DROP CONSTRAINT [PK_clinic_survey_clinic_survey_id]
 GO



ALTER TABLE [dbo].[clinic_survey]
 ADD CONSTRAINT [PK_clinic_survey_clinic_survey_id]
 PRIMARY KEY 
   CLUSTERED ([clinic_survey_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_clinical_note_clinical_note_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[clinical_note] DROP CONSTRAINT [PK_clinical_note_clinical_note_id]
 GO



ALTER TABLE [dbo].[clinical_note]
 ADD CONSTRAINT [PK_clinical_note_clinical_note_id]
 PRIMARY KEY 
   CLUSTERED ([clinical_note_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_clinical_reminder_clinical_reminder_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[clinical_reminder] DROP CONSTRAINT [PK_clinical_reminder_clinical_reminder_id]
 GO



ALTER TABLE [dbo].[clinical_reminder]
 ADD CONSTRAINT [PK_clinical_reminder_clinical_reminder_id]
 PRIMARY KEY 
   CLUSTERED ([clinical_reminder_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_clinical_reminder_survey_clinical_reminder_survey_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[clinical_reminder_survey] DROP CONSTRAINT [PK_clinical_reminder_survey_clinical_reminder_survey_id]
 GO



ALTER TABLE [dbo].[clinical_reminder_survey]
 ADD CONSTRAINT [PK_clinical_reminder_survey_clinical_reminder_survey_id]
 PRIMARY KEY 
   CLUSTERED ([clinical_reminder_survey_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_consult_consult_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[consult] DROP CONSTRAINT [PK_consult_consult_id]
 GO



ALTER TABLE [dbo].[consult]
 ADD CONSTRAINT [PK_consult_consult_id]
 PRIMARY KEY 
   CLUSTERED ([consult_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_dashboard_alert_dashboard_alert_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[dashboard_alert] DROP CONSTRAINT [PK_dashboard_alert_dashboard_alert_id]
 GO



ALTER TABLE [dbo].[dashboard_alert]
 ADD CONSTRAINT [PK_dashboard_alert_dashboard_alert_id]
 PRIMARY KEY 
   CLUSTERED ([dashboard_alert_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_dashboard_alert_type_dashboard_alert_type_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[dashboard_alert_type] DROP CONSTRAINT [PK_dashboard_alert_type_dashboard_alert_type_id]
 GO



ALTER TABLE [dbo].[dashboard_alert_type]
 ADD CONSTRAINT [PK_dashboard_alert_type_dashboard_alert_type_id]
 PRIMARY KEY 
   CLUSTERED ([dashboard_alert_type_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_dialog_prompt_dialog_prompt_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[dialog_prompt] DROP CONSTRAINT [PK_dialog_prompt_dialog_prompt_id]
 GO



ALTER TABLE [dbo].[dialog_prompt]
 ADD CONSTRAINT [PK_dialog_prompt_dialog_prompt_id]
 PRIMARY KEY 
   CLUSTERED ([dialog_prompt_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_event_event_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[event] DROP CONSTRAINT [PK_event_event_id]
 GO



ALTER TABLE [dbo].[event]
 ADD CONSTRAINT [PK_event_event_id]
 PRIMARY KEY 
   CLUSTERED ([event_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_event_type_event_type_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[event_type] DROP CONSTRAINT [PK_event_type_event_type_id]
 GO



ALTER TABLE [dbo].[event_type]
 ADD CONSTRAINT [PK_event_type_event_type_id]
 PRIMARY KEY 
   CLUSTERED ([event_type_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_export_log_export_log_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[export_log] DROP CONSTRAINT [PK_export_log_export_log_id]
 GO



ALTER TABLE [dbo].[export_log]
 ADD CONSTRAINT [PK_export_log_export_log_id]
 PRIMARY KEY 
   CLUSTERED ([export_log_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_export_log_audit_export_log_audit_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[export_log_audit] DROP CONSTRAINT [PK_export_log_audit_export_log_audit_id]
 GO



ALTER TABLE [dbo].[export_log_audit]
 ADD CONSTRAINT [PK_export_log_audit_export_log_audit_id]
 PRIMARY KEY 
   CLUSTERED ([export_log_audit_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_export_type_export_type_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[export_type] DROP CONSTRAINT [PK_export_type_export_type_id]
 GO



ALTER TABLE [dbo].[export_type]
 ADD CONSTRAINT [PK_export_type_export_type_id]
 PRIMARY KEY 
   CLUSTERED ([export_type_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_exportdata_filter_options_exportdata_filter_options_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[exportdata_filter_options] DROP CONSTRAINT [PK_exportdata_filter_options_exportdata_filter_options_id]
 GO



ALTER TABLE [dbo].[exportdata_filter_options]
 ADD CONSTRAINT [PK_exportdata_filter_options_exportdata_filter_options_id]
 PRIMARY KEY 
   CLUSTERED ([exportdata_filter_options_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_health_factor_health_factor_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[health_factor] DROP CONSTRAINT [PK_health_factor_health_factor_id]
 GO



ALTER TABLE [dbo].[health_factor]
 ADD CONSTRAINT [PK_health_factor_health_factor_id]
 PRIMARY KEY 
   CLUSTERED ([health_factor_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_health_factor_dialog_prompt_health_factor_dialog_prompt_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[health_factor_dialog_prompt] DROP CONSTRAINT [PK_health_factor_dialog_prompt_health_factor_dialog_prompt_id]
 GO



ALTER TABLE [dbo].[health_factor_dialog_prompt]
 ADD CONSTRAINT [PK_health_factor_dialog_prompt_health_factor_dialog_prompt_id]
 PRIMARY KEY 
   CLUSTERED ([health_factor_dialog_prompt_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_measure_measure_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[measure] DROP CONSTRAINT [PK_measure_measure_id]
 GO



ALTER TABLE [dbo].[measure]
 ADD CONSTRAINT [PK_measure_measure_id]
 PRIMARY KEY 
   CLUSTERED ([measure_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_measure_answer_measure_answer_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[measure_answer] DROP CONSTRAINT [PK_measure_answer_measure_answer_id]
 GO



ALTER TABLE [dbo].[measure_answer]
 ADD CONSTRAINT [PK_measure_answer_measure_answer_id]
 PRIMARY KEY 
   CLUSTERED ([measure_answer_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_measure_answer_validation_measure_answer_validation_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[measure_answer_validation] DROP CONSTRAINT [PK_measure_answer_validation_measure_answer_validation_id]
 GO



ALTER TABLE [dbo].[measure_answer_validation]
 ADD CONSTRAINT [PK_measure_answer_validation_measure_answer_validation_id]
 PRIMARY KEY 
   CLUSTERED ([measure_answer_validation_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_measure_type_measure_type_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[measure_type] DROP CONSTRAINT [PK_measure_type_measure_type_id]
 GO



ALTER TABLE [dbo].[measure_type]
 ADD CONSTRAINT [PK_measure_type_measure_type_id]
 PRIMARY KEY 
   CLUSTERED ([measure_type_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_measure_validation_measure_validation_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[measure_validation] DROP CONSTRAINT [PK_measure_validation_measure_validation_id]
 GO



ALTER TABLE [dbo].[measure_validation]
 ADD CONSTRAINT [PK_measure_validation_measure_validation_id]
 PRIMARY KEY 
   CLUSTERED ([measure_validation_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_note_title_note_title_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[note_title] DROP CONSTRAINT [PK_note_title_note_title_id]
 GO



ALTER TABLE [dbo].[note_title]
 ADD CONSTRAINT [PK_note_title_note_title_id]
 PRIMARY KEY 
   CLUSTERED ([note_title_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_note_title_map_note_title_map_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[note_title_map] DROP CONSTRAINT [PK_note_title_map_note_title_map_id]
 GO



ALTER TABLE [dbo].[note_title_map]
 ADD CONSTRAINT [PK_note_title_map_note_title_map_id]
 PRIMARY KEY 
   CLUSTERED ([note_title_map_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_person_type_person_type_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[person_type] DROP CONSTRAINT [PK_person_type_person_type_id]
 GO



ALTER TABLE [dbo].[person_type]
 ADD CONSTRAINT [PK_person_type_person_type_id]
 PRIMARY KEY 
   CLUSTERED ([person_type_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_program_program_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[program] DROP CONSTRAINT [PK_program_program_id]
 GO



ALTER TABLE [dbo].[program]
 ADD CONSTRAINT [PK_program_program_id]
 PRIMARY KEY 
   CLUSTERED ([program_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_program_battery_program_battery_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[program_battery] DROP CONSTRAINT [PK_program_battery_program_battery_id]
 GO



ALTER TABLE [dbo].[program_battery]
 ADD CONSTRAINT [PK_program_battery_program_battery_id]
 PRIMARY KEY 
   CLUSTERED ([program_battery_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_program_survey_program_survey_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[program_survey] DROP CONSTRAINT [PK_program_survey_program_survey_id]
 GO



ALTER TABLE [dbo].[program_survey]
 ADD CONSTRAINT [PK_program_survey_program_survey_id]
 PRIMARY KEY 
   CLUSTERED ([program_survey_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_role_role_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[role] DROP CONSTRAINT [PK_role_role_id]
 GO



ALTER TABLE [dbo].[role]
 ADD CONSTRAINT [PK_role_role_id]
 PRIMARY KEY 
   CLUSTERED ([role_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_rule_rule_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[rule] DROP CONSTRAINT [PK_rule_rule_id]
 GO



ALTER TABLE [dbo].[rule]
 ADD CONSTRAINT [PK_rule_rule_id]
 PRIMARY KEY 
   CLUSTERED ([rule_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_rule_assessment_variable_rule_assessment_variable_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[rule_assessment_variable] DROP CONSTRAINT [PK_rule_assessment_variable_rule_assessment_variable_id]
 GO



ALTER TABLE [dbo].[rule_assessment_variable]
 ADD CONSTRAINT [PK_rule_assessment_variable_rule_assessment_variable_id]
 PRIMARY KEY 
   CLUSTERED ([rule_assessment_variable_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_rule_event_rule_event_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[rule_event] DROP CONSTRAINT [PK_rule_event_rule_event_id]
 GO



ALTER TABLE [dbo].[rule_event]
 ADD CONSTRAINT [PK_rule_event_rule_event_id]
 PRIMARY KEY 
   CLUSTERED ([rule_event_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_survey_survey_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[survey] DROP CONSTRAINT [PK_survey_survey_id]
 GO



ALTER TABLE [dbo].[survey]
 ADD CONSTRAINT [PK_survey_survey_id]
 PRIMARY KEY 
   CLUSTERED ([survey_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_survey_attempt_survey_attempt_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[survey_attempt] DROP CONSTRAINT [PK_survey_attempt_survey_attempt_id]
 GO



ALTER TABLE [dbo].[survey_attempt]
 ADD CONSTRAINT [PK_survey_attempt_survey_attempt_id]
 PRIMARY KEY 
   CLUSTERED ([survey_attempt_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_survey_measure_response_survey_measure_response_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[survey_measure_response] DROP CONSTRAINT [PK_survey_measure_response_survey_measure_response_id]
 GO



ALTER TABLE [dbo].[survey_measure_response]
 ADD CONSTRAINT [PK_survey_measure_response_survey_measure_response_id]
 PRIMARY KEY 
   CLUSTERED ([survey_measure_response_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_survey_page_survey_page_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[survey_page] DROP CONSTRAINT [PK_survey_page_survey_page_id]
 GO



ALTER TABLE [dbo].[survey_page]
 ADD CONSTRAINT [PK_survey_page_survey_page_id]
 PRIMARY KEY 
   CLUSTERED ([survey_page_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_survey_page_measure_survey_page_measure_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[survey_page_measure] DROP CONSTRAINT [PK_survey_page_measure_survey_page_measure_id]
 GO



ALTER TABLE [dbo].[survey_page_measure]
 ADD CONSTRAINT [PK_survey_page_measure_survey_page_measure_id]
 PRIMARY KEY 
   CLUSTERED ([survey_page_measure_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_survey_score_interval_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[survey_score_interval] DROP CONSTRAINT [PK_survey_score_interval_id]
 GO



ALTER TABLE [dbo].[survey_score_interval]
 ADD CONSTRAINT [PK_survey_score_interval_id]
 PRIMARY KEY 
   CLUSTERED ([id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_survey_section_survey_section_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[survey_section] DROP CONSTRAINT [PK_survey_section_survey_section_id]
 GO



ALTER TABLE [dbo].[survey_section]
 ADD CONSTRAINT [PK_survey_section_survey_section_id]
 PRIMARY KEY 
   CLUSTERED ([survey_section_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_survey_template_survey_template_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[survey_template] DROP CONSTRAINT [PK_survey_template_survey_template_id]
 GO



ALTER TABLE [dbo].[survey_template]
 ADD CONSTRAINT [PK_survey_template_survey_template_id]
 PRIMARY KEY 
   CLUSTERED ([survey_template_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_system_property_system_property_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[system_property] DROP CONSTRAINT [PK_system_property_system_property_id]
 GO



ALTER TABLE [dbo].[system_property]
 ADD CONSTRAINT [PK_system_property_system_property_id]
 PRIMARY KEY 
   CLUSTERED ([system_property_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_template_template_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[template] DROP CONSTRAINT [PK_template_template_id]
 GO



ALTER TABLE [dbo].[template]
 ADD CONSTRAINT [PK_template_template_id]
 PRIMARY KEY 
   CLUSTERED ([template_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_template_type_template_type_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[template_type] DROP CONSTRAINT [PK_template_type_template_type_id]
 GO



ALTER TABLE [dbo].[template_type]
 ADD CONSTRAINT [PK_template_type_template_type_id]
 PRIMARY KEY 
   CLUSTERED ([template_type_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_user_user_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[user] DROP CONSTRAINT [PK_user_user_id]
 GO



ALTER TABLE [dbo].[user]
 ADD CONSTRAINT [PK_user_user_id]
 PRIMARY KEY 
   CLUSTERED ([user_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_user_clinic_user_clinic_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[user_clinic] DROP CONSTRAINT [PK_user_clinic_user_clinic_id]
 GO



ALTER TABLE [dbo].[user_clinic]
 ADD CONSTRAINT [PK_user_clinic_user_clinic_id]
 PRIMARY KEY 
   CLUSTERED ([user_clinic_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_user_program_user_program_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[user_program] DROP CONSTRAINT [PK_user_program_user_program_id]
 GO



ALTER TABLE [dbo].[user_program]
 ADD CONSTRAINT [PK_user_program_user_program_id]
 PRIMARY KEY 
   CLUSTERED ([user_program_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_user_status_user_status_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[user_status] DROP CONSTRAINT [PK_user_status_user_status_id]
 GO



ALTER TABLE [dbo].[user_status]
 ADD CONSTRAINT [PK_user_status_user_status_id]
 PRIMARY KEY 
   CLUSTERED ([user_status_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_validation_validation_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[validation] DROP CONSTRAINT [PK_validation_validation_id]
 GO



ALTER TABLE [dbo].[validation]
 ADD CONSTRAINT [PK_validation_validation_id]
 PRIMARY KEY 
   CLUSTERED ([validation_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_variable_template_variable_template_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[variable_template] DROP CONSTRAINT [PK_variable_template_variable_template_id]
 GO



ALTER TABLE [dbo].[variable_template]
 ADD CONSTRAINT [PK_variable_template_variable_template_id]
 PRIMARY KEY 
   CLUSTERED ([variable_template_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_veteran_veteran_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[veteran] DROP CONSTRAINT [PK_veteran_veteran_id]
 GO



ALTER TABLE [dbo].[veteran]
 ADD CONSTRAINT [PK_veteran_veteran_id]
 PRIMARY KEY 
   CLUSTERED ([veteran_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_veteran_assessment_veteran_assessment_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[veteran_assessment] DROP CONSTRAINT [PK_veteran_assessment_veteran_assessment_id]
 GO



ALTER TABLE [dbo].[veteran_assessment]
 ADD CONSTRAINT [PK_veteran_assessment_veteran_assessment_id]
 PRIMARY KEY 
   CLUSTERED ([veteran_assessment_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_veteran_assessment_action_veteran_assessment_action_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[veteran_assessment_action] DROP CONSTRAINT [PK_veteran_assessment_action_veteran_assessment_action_id]
 GO



ALTER TABLE [dbo].[veteran_assessment_action]
 ADD CONSTRAINT [PK_veteran_assessment_action_veteran_assessment_action_id]
 PRIMARY KEY 
   CLUSTERED ([veteran_assessment_action_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_veteran_assessment_audit_log_veteran_assessment_audit_log_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[veteran_assessment_audit_log] DROP CONSTRAINT [PK_veteran_assessment_audit_log_veteran_assessment_audit_log_id]
 GO



ALTER TABLE [dbo].[veteran_assessment_audit_log]
 ADD CONSTRAINT [PK_veteran_assessment_audit_log_veteran_assessment_audit_log_id]
 PRIMARY KEY 
   CLUSTERED ([veteran_assessment_audit_log_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_veteran_assessment_consult_veteran_assessment_consult_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[veteran_assessment_consult] DROP CONSTRAINT [PK_veteran_assessment_consult_veteran_assessment_consult_id]
 GO



ALTER TABLE [dbo].[veteran_assessment_consult]
 ADD CONSTRAINT [PK_veteran_assessment_consult_veteran_assessment_consult_id]
 PRIMARY KEY 
   CLUSTERED ([veteran_assessment_consult_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_veteran_assessment_dashboard_alert_veteran_assessment_dashboard_alert_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[veteran_assessment_dashboard_alert] DROP CONSTRAINT [PK_veteran_assessment_dashboard_alert_veteran_assessment_dashboard_alert_id]
 GO



ALTER TABLE [dbo].[veteran_assessment_dashboard_alert]
 ADD CONSTRAINT [PK_veteran_assessment_dashboard_alert_veteran_assessment_dashboard_alert_id]
 PRIMARY KEY 
   CLUSTERED ([veteran_assessment_dashboard_alert_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_veteran_assessment_event_veteran_assessment_event_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[veteran_assessment_event] DROP CONSTRAINT [PK_veteran_assessment_event_veteran_assessment_event_id]
 GO



ALTER TABLE [dbo].[veteran_assessment_event]
 ADD CONSTRAINT [PK_veteran_assessment_event_veteran_assessment_event_id]
 PRIMARY KEY 
   CLUSTERED ([veteran_assessment_event_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_veteran_assessment_health_factor_veteran_assessment_health_factor_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[veteran_assessment_health_factor] DROP CONSTRAINT [PK_veteran_assessment_health_factor_veteran_assessment_health_factor_id]
 GO



ALTER TABLE [dbo].[veteran_assessment_health_factor]
 ADD CONSTRAINT [PK_veteran_assessment_health_factor_veteran_assessment_health_factor_id]
 PRIMARY KEY 
   CLUSTERED ([veteran_assessment_health_factor_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_veteran_assessment_log_veteran_assessment_log_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[veteran_assessment_log] DROP CONSTRAINT [PK_veteran_assessment_log_veteran_assessment_log_id]
 GO



ALTER TABLE [dbo].[veteran_assessment_log]
 ADD CONSTRAINT [PK_veteran_assessment_log_veteran_assessment_log_id]
 PRIMARY KEY 
   CLUSTERED ([veteran_assessment_log_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_veteran_assessment_measure_visibility_veteran_assessment_measure_visibility_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[veteran_assessment_measure_visibility] DROP CONSTRAINT [PK_veteran_assessment_measure_visibility_veteran_assessment_measure_visibility_id]
 GO



ALTER TABLE [dbo].[veteran_assessment_measure_visibility]
 ADD CONSTRAINT [PK_veteran_assessment_measure_visibility_veteran_assessment_measure_visibility_id]
 PRIMARY KEY 
   CLUSTERED ([veteran_assessment_measure_visibility_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_veteran_assessment_note_veteran_assessment_note_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[veteran_assessment_note] DROP CONSTRAINT [PK_veteran_assessment_note_veteran_assessment_note_id]
 GO



ALTER TABLE [dbo].[veteran_assessment_note]
 ADD CONSTRAINT [PK_veteran_assessment_note_veteran_assessment_note_id]
 PRIMARY KEY 
   CLUSTERED ([veteran_assessment_note_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_veteran_assessment_survey_veteran_assessment_survey_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[veteran_assessment_survey] DROP CONSTRAINT [PK_veteran_assessment_survey_veteran_assessment_survey_id]
 GO



ALTER TABLE [dbo].[veteran_assessment_survey]
 ADD CONSTRAINT [PK_veteran_assessment_survey_veteran_assessment_survey_id]
 PRIMARY KEY 
   CLUSTERED ([veteran_assessment_survey_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_veteran_assessment_survey_score_assessment_survey_score_id'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[veteran_assessment_survey_score] DROP CONSTRAINT [PK_veteran_assessment_survey_score_assessment_survey_score_id]
 GO



ALTER TABLE [dbo].[veteran_assessment_survey_score]
 ADD CONSTRAINT [PK_veteran_assessment_survey_score_assessment_survey_score_id]
 PRIMARY KEY 
   CLUSTERED ([assessment_survey_score_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'ux_assessment_var_children_parent'  AND sc.name=N'dbo'  AND type in (N'UQ'))
ALTER TABLE [dbo].[assessment_var_children] DROP CONSTRAINT [ux_assessment_var_children_parent]
 GO



ALTER TABLE [dbo].[assessment_var_children]
 ADD CONSTRAINT [ux_assessment_var_children_parent]
 UNIQUE 
   NONCLUSTERED ([variable_parent] ASC, [variable_child] ASC)

GO





USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'ux_event_type_ref_obj'  AND sc.name=N'dbo'  AND type in (N'UQ'))
ALTER TABLE [dbo].[event] DROP CONSTRAINT [ux_event_type_ref_obj]
 GO



ALTER TABLE [dbo].[event]
 ADD CONSTRAINT [ux_event_type_ref_obj]
 UNIQUE 
   NONCLUSTERED ([event_type_id] ASC, [related_object_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'ux_rule_variable'  AND sc.name=N'dbo'  AND type in (N'UQ'))
ALTER TABLE [dbo].[rule_assessment_variable] DROP CONSTRAINT [ux_rule_variable]
 GO



ALTER TABLE [dbo].[rule_assessment_variable]
 ADD CONSTRAINT [ux_rule_variable]
 UNIQUE 
   NONCLUSTERED ([rule_id] ASC, [assessment_variable_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'ux_rule_event'  AND sc.name=N'dbo'  AND type in (N'UQ'))
ALTER TABLE [dbo].[rule_event] DROP CONSTRAINT [ux_rule_event]
 GO



ALTER TABLE [dbo].[rule_event]
 ADD CONSTRAINT [ux_rule_event]
 UNIQUE 
   NONCLUSTERED ([rule_id] ASC, [event_id] ASC)

GO

USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'ux_login_id'  AND sc.name=N'dbo'  AND type in (N'UQ'))
ALTER TABLE [dbo].[user] DROP CONSTRAINT [ux_login_id]
 GO



ALTER TABLE [dbo].[user]
 ADD CONSTRAINT [ux_login_id]
 UNIQUE 
   NONCLUSTERED ([login_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'ux_variable_template'  AND sc.name=N'dbo'  AND type in (N'UQ'))
ALTER TABLE [dbo].[variable_template] DROP CONSTRAINT [ux_variable_template]
 GO



ALTER TABLE [dbo].[variable_template]
 ADD CONSTRAINT [ux_variable_template]
 UNIQUE 
   NONCLUSTERED ([assessment_variable_id] ASC, [template_id] ASC)

GO

USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'ux_assessment_consult'  AND sc.name=N'dbo'  AND type in (N'UQ'))
ALTER TABLE [dbo].[veteran_assessment_consult] DROP CONSTRAINT [ux_assessment_consult]
 GO



ALTER TABLE [dbo].[veteran_assessment_consult]
 ADD CONSTRAINT [ux_assessment_consult]
 UNIQUE 
   NONCLUSTERED ([veteran_assessment_id] ASC, [consult_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'ux_assessment_dashboard_alert'  AND sc.name=N'dbo'  AND type in (N'UQ'))
ALTER TABLE [dbo].[veteran_assessment_dashboard_alert] DROP CONSTRAINT [ux_assessment_dashboard_alert]
 GO



ALTER TABLE [dbo].[veteran_assessment_dashboard_alert]
 ADD CONSTRAINT [ux_assessment_dashboard_alert]
 UNIQUE 
   NONCLUSTERED ([veteran_assessment_id] ASC, [dashboard_alert_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'ux_assessment_health_factor'  AND sc.name=N'dbo'  AND type in (N'UQ'))
ALTER TABLE [dbo].[veteran_assessment_health_factor] DROP CONSTRAINT [ux_assessment_health_factor]
 GO



ALTER TABLE [dbo].[veteran_assessment_health_factor]
 ADD CONSTRAINT [ux_assessment_health_factor]
 UNIQUE 
   NONCLUSTERED ([veteran_assessment_id] ASC, [health_factor_id] ASC)

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'ux_assessment_measure_visibility'  AND sc.name=N'dbo'  AND type in (N'UQ'))
ALTER TABLE [dbo].[veteran_assessment_measure_visibility] DROP CONSTRAINT [ux_assessment_measure_visibility]
 GO



ALTER TABLE [dbo].[veteran_assessment_measure_visibility]
 ADD CONSTRAINT [ux_assessment_measure_visibility]
 UNIQUE 
   NONCLUSTERED ([veteran_assessment_id] ASC, [measure_id] ASC)

GO


USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'veteran_assessment_audit_log'  AND sc.name = N'dbo'  AND si.name = N'fk_assessment_status_id' AND so.type in (N'U'))
   DROP INDEX [dbo].[veteran_assessment_audit_log].[fk_assessment_status_id] 
GO
CREATE NONCLUSTERED INDEX [fk_assessment_status_id] ON [dbo].[veteran_assessment_audit_log]
(
   [assessment_status_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'assessment_formula'  AND sc.name = N'dbo'  AND si.name = N'fk_assessment_var_id_idx' AND so.type in (N'U'))
   DROP INDEX [dbo].[assessment_formula].[fk_assessment_var_id_idx] 
GO
CREATE NONCLUSTERED INDEX [fk_assessment_var_id_idx] ON [dbo].[assessment_formula]
(
   [assessment_variable_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'assessment_var_children'  AND sc.name = N'dbo'  AND si.name = N'fk_assessment_variable_child' AND so.type in (N'U'))
   DROP INDEX [dbo].[assessment_var_children].[fk_assessment_variable_child] 
GO
CREATE NONCLUSTERED INDEX [fk_assessment_variable_child] ON [dbo].[assessment_var_children]
(
   [variable_child] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'assessment_variable_column'  AND sc.name = N'dbo'  AND si.name = N'fk_assessment_variable_column_av' AND so.type in (N'U'))
   DROP INDEX [dbo].[assessment_variable_column].[fk_assessment_variable_column_av] 
GO
CREATE NONCLUSTERED INDEX [fk_assessment_variable_column_av] ON [dbo].[assessment_variable_column]
(
   [assessment_variable_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'assessment_variable'  AND sc.name = N'dbo'  AND si.name = N'fk_assessment_variable_type' AND so.type in (N'U'))
   DROP INDEX [dbo].[assessment_variable].[fk_assessment_variable_type] 
GO
CREATE NONCLUSTERED INDEX [fk_assessment_variable_type] ON [dbo].[assessment_variable]
(
   [assessment_variable_type_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'measure_answer'  AND sc.name = N'dbo'  AND si.name = N'fk_calculation_type' AND so.type in (N'U'))
   DROP INDEX [dbo].[measure_answer].[fk_calculation_type] 
GO
CREATE NONCLUSTERED INDEX [fk_calculation_type] ON [dbo].[measure_answer]
(
   [calculation_type_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'export_log_audit'  AND sc.name = N'dbo'  AND si.name = N'fk_export_log_audit_id_idx' AND so.type in (N'U'))
   DROP INDEX [dbo].[export_log_audit].[fk_export_log_audit_id_idx] 
GO
CREATE NONCLUSTERED INDEX [fk_export_log_audit_id_idx] ON [dbo].[export_log_audit]
(
   [export_log_audit_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'export_log_audit'  AND sc.name = N'dbo'  AND si.name = N'fk_export_log_id_idx' AND so.type in (N'U'))
   DROP INDEX [dbo].[export_log_audit].[fk_export_log_id_idx] 
GO
CREATE NONCLUSTERED INDEX [fk_export_log_id_idx] ON [dbo].[export_log_audit]
(
   [export_log_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'export_log'  AND sc.name = N'dbo'  AND si.name = N'fk_export_type_el' AND so.type in (N'U'))
   DROP INDEX [dbo].[export_log].[fk_export_type_el] 
GO
CREATE NONCLUSTERED INDEX [fk_export_type_el] ON [dbo].[export_log]
(
   [export_type_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'export_log_audit'  AND sc.name = N'dbo'  AND si.name = N'fk_exported_by_user_id' AND so.type in (N'U'))
   DROP INDEX [dbo].[export_log_audit].[fk_exported_by_user_id] 
GO
CREATE NONCLUSTERED INDEX [fk_exported_by_user_id] ON [dbo].[export_log_audit]
(
   [exported_by_user_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'measure_answer_validation'  AND sc.name = N'dbo'  AND si.name = N'fk_measure_answer_validation_measure' AND so.type in (N'U'))
   DROP INDEX [dbo].[measure_answer_validation].[fk_measure_answer_validation_measure] 
GO
CREATE NONCLUSTERED INDEX [fk_measure_answer_validation_measure] ON [dbo].[measure_answer_validation]
(
   [measure_answer_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'measure_answer_validation'  AND sc.name = N'dbo'  AND si.name = N'fk_measure_answer_validation_validation' AND so.type in (N'U'))
   DROP INDEX [dbo].[measure_answer_validation].[fk_measure_answer_validation_validation] 
GO
CREATE NONCLUSTERED INDEX [fk_measure_answer_validation_validation] ON [dbo].[measure_answer_validation]
(
   [validation_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'measure_validation'  AND sc.name = N'dbo'  AND si.name = N'fk_measure_validation_measure' AND so.type in (N'U'))
   DROP INDEX [dbo].[measure_validation].[fk_measure_validation_measure] 
GO
CREATE NONCLUSTERED INDEX [fk_measure_validation_measure] ON [dbo].[measure_validation]
(
   [measure_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'measure_validation'  AND sc.name = N'dbo'  AND si.name = N'fk_measure_validation_validation' AND so.type in (N'U'))
   DROP INDEX [dbo].[measure_validation].[fk_measure_validation_validation] 
GO
CREATE NONCLUSTERED INDEX [fk_measure_validation_validation] ON [dbo].[measure_validation]
(
   [validation_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'veteran_assessment_audit_log'  AND sc.name = N'dbo'  AND si.name = N'fk_person_type_id' AND so.type in (N'U'))
   DROP INDEX [dbo].[veteran_assessment_audit_log].[fk_person_type_id] 
GO
CREATE NONCLUSTERED INDEX [fk_person_type_id] ON [dbo].[veteran_assessment_audit_log]
(
   [person_type_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'program_battery'  AND sc.name = N'dbo'  AND si.name = N'fk_program_battery_battery' AND so.type in (N'U'))
   DROP INDEX [dbo].[program_battery].[fk_program_battery_battery] 
GO
CREATE NONCLUSTERED INDEX [fk_program_battery_battery] ON [dbo].[program_battery]
(
   [battery_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'program_battery'  AND sc.name = N'dbo'  AND si.name = N'fk_program_battery_program' AND so.type in (N'U'))
   DROP INDEX [dbo].[program_battery].[fk_program_battery_program] 
GO
CREATE NONCLUSTERED INDEX [fk_program_battery_program] ON [dbo].[program_battery]
(
   [program_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'export_log'  AND sc.name = N'dbo'  AND si.name = N'fk_program_el' AND so.type in (N'U'))
   DROP INDEX [dbo].[export_log].[fk_program_el] 
GO
CREATE NONCLUSTERED INDEX [fk_program_el] ON [dbo].[export_log]
(
   [program_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'survey_measure_response'  AND sc.name = N'dbo'  AND si.name = N'fk_survey_meas_resp_va_copy' AND so.type in (N'U'))
   DROP INDEX [dbo].[survey_measure_response].[fk_survey_meas_resp_va_copy] 
GO
CREATE NONCLUSTERED INDEX [fk_survey_meas_resp_va_copy] ON [dbo].[survey_measure_response]
(
   [copiedFromAssessment] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'survey_page'  AND sc.name = N'dbo'  AND si.name = N'fk_survey_page_survey' AND so.type in (N'U'))
   DROP INDEX [dbo].[survey_page].[fk_survey_page_survey] 
GO
CREATE NONCLUSTERED INDEX [fk_survey_page_survey] ON [dbo].[survey_page]
(
   [survey_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'variable_template'  AND sc.name = N'dbo'  AND si.name = N'fk_template' AND so.type in (N'U'))
   DROP INDEX [dbo].[variable_template].[fk_template] 
GO
CREATE NONCLUSTERED INDEX [fk_template] ON [dbo].[variable_template]
(
   [template_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'template'  AND sc.name = N'dbo'  AND si.name = N'fk_template_type' AND so.type in (N'U'))
   DROP INDEX [dbo].[template].[fk_template_type] 
GO
CREATE NONCLUSTERED INDEX [fk_template_type] ON [dbo].[template]
(
   [template_type_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'export_log'  AND sc.name = N'dbo'  AND si.name = N'fk_user_el1' AND so.type in (N'U'))
   DROP INDEX [dbo].[export_log].[fk_user_el1] 
GO
CREATE NONCLUSTERED INDEX [fk_user_el1] ON [dbo].[export_log]
(
   [exported_by_user_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'export_log'  AND sc.name = N'dbo'  AND si.name = N'fk_user_el2' AND so.type in (N'U'))
   DROP INDEX [dbo].[export_log].[fk_user_el2] 
GO
CREATE NONCLUSTERED INDEX [fk_user_el2] ON [dbo].[export_log]
(
   [clinician_user_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'export_log'  AND sc.name = N'dbo'  AND si.name = N'fk_user_el3' AND so.type in (N'U'))
   DROP INDEX [dbo].[export_log].[fk_user_el3] 
GO
CREATE NONCLUSTERED INDEX [fk_user_el3] ON [dbo].[export_log]
(
   [created_by_user_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'veteran_assessment'  AND sc.name = N'dbo'  AND si.name = N'fk_veteran_assess_signed_by' AND so.type in (N'U'))
   DROP INDEX [dbo].[veteran_assessment].[fk_veteran_assess_signed_by] 
GO
CREATE NONCLUSTERED INDEX [fk_veteran_assess_signed_by] ON [dbo].[veteran_assessment]
(
   [signed_by_user_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'veteran_assessment_log'  AND sc.name = N'dbo'  AND si.name = N'fk_veteran_assessment_action' AND so.type in (N'U'))
   DROP INDEX [dbo].[veteran_assessment_log].[fk_veteran_assessment_action] 
GO
CREATE NONCLUSTERED INDEX [fk_veteran_assessment_action] ON [dbo].[veteran_assessment_log]
(
   [veteran_assessment_action_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'veteran_assessment_audit_log'  AND sc.name = N'dbo'  AND si.name = N'fk_veteran_assessment_event_id' AND so.type in (N'U'))
   DROP INDEX [dbo].[veteran_assessment_audit_log].[fk_veteran_assessment_event_id] 
GO
CREATE NONCLUSTERED INDEX [fk_veteran_assessment_event_id] ON [dbo].[veteran_assessment_audit_log]
(
   [veteran_assessment_event_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'export_log'  AND sc.name = N'dbo'  AND si.name = N'fk_veteran_el' AND so.type in (N'U'))
   DROP INDEX [dbo].[export_log].[fk_veteran_el] 
GO
CREATE NONCLUSTERED INDEX [fk_veteran_el] ON [dbo].[export_log]
(
   [veteran_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'assessment_formula'  AND sc.name = N'dbo'  AND si.name = N'idx_ass_id_displ_order' AND so.type in (N'U'))
   DROP INDEX [dbo].[assessment_formula].[idx_ass_id_displ_order] 
GO
CREATE NONCLUSTERED INDEX [idx_ass_id_displ_order] ON [dbo].[assessment_formula]
(
   [assessment_variable_id] ASC,
   [display_order] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'event'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_action_action_type' AND so.type in (N'U'))
   DROP INDEX [dbo].[event].[idx_fk_action_action_type] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_action_action_type] ON [dbo].[event]
(
   [event_type_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'veteran_assessment'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_archive_date' AND so.type in (N'U'))
   DROP INDEX [dbo].[veteran_assessment].[idx_fk_archive_date] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_archive_date] ON [dbo].[veteran_assessment]
(
   [assessment_status_id] ASC,
   [date_archived] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'battery_template'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_battery_template_battery' AND so.type in (N'U'))
   DROP INDEX [dbo].[battery_template].[idx_fk_battery_template_battery] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_battery_template_battery] ON [dbo].[battery_template]
(
   [battery_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'battery_template'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_battery_template_template' AND so.type in (N'U'))
   DROP INDEX [dbo].[battery_template].[idx_fk_battery_template_template] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_battery_template_template] ON [dbo].[battery_template]
(
   [template_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'battery_survey'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_bttry_srvy_bttry' AND so.type in (N'U'))
   DROP INDEX [dbo].[battery_survey].[idx_fk_bttry_srvy_bttry] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_bttry_srvy_bttry] ON [dbo].[battery_survey]
(
   [battery_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'clinic_program'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_clnc_prgm_clnc' AND so.type in (N'U'))
   DROP INDEX [dbo].[clinic_program].[idx_fk_clnc_prgm_clnc] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_clnc_prgm_clnc] ON [dbo].[clinic_program]
(
   [clinic_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'clinic_program'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_clnc_prgm_prgm' AND so.type in (N'U'))
   DROP INDEX [dbo].[clinic_program].[idx_fk_clnc_prgm_prgm] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_clnc_prgm_prgm] ON [dbo].[clinic_program]
(
   [program_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'clinic_survey'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_clnc_srvy_clnc' AND so.type in (N'U'))
   DROP INDEX [dbo].[clinic_survey].[idx_fk_clnc_srvy_clnc] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_clnc_srvy_clnc] ON [dbo].[clinic_survey]
(
   [clinic_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'clinic_survey'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_clnc_srvy_srvy' AND so.type in (N'U'))
   DROP INDEX [dbo].[clinic_survey].[idx_fk_clnc_srvy_srvy] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_clnc_srvy_srvy] ON [dbo].[clinic_survey]
(
   [survey_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'clinical_reminder_survey'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_clncl_rmndr_srvy_clncl' AND so.type in (N'U'))
   DROP INDEX [dbo].[clinical_reminder_survey].[idx_fk_clncl_rmndr_srvy_clncl] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_clncl_rmndr_srvy_clncl] ON [dbo].[clinical_reminder_survey]
(
   [clinical_reminder_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'clinical_reminder_survey'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_clncl_rmndr_srvy_srvy' AND so.type in (N'U'))
   DROP INDEX [dbo].[clinical_reminder_survey].[idx_fk_clncl_rmndr_srvy_srvy] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_clncl_rmndr_srvy_srvy] ON [dbo].[clinical_reminder_survey]
(
   [survey_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'dashboard_alert'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_dashboard_alert_type' AND so.type in (N'U'))
   DROP INDEX [dbo].[dashboard_alert].[idx_fk_dashboard_alert_type] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_dashboard_alert_type] ON [dbo].[dashboard_alert]
(
   [dashboard_alert_type_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'battery_survey'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_fk_bttry_srvy_srvy' AND so.type in (N'U'))
   DROP INDEX [dbo].[battery_survey].[idx_fk_fk_bttry_srvy_srvy] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_fk_bttry_srvy_srvy] ON [dbo].[battery_survey]
(
   [survey_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'health_factor'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_health_factor_reminder' AND so.type in (N'U'))
   DROP INDEX [dbo].[health_factor].[idx_fk_health_factor_reminder] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_health_factor_reminder] ON [dbo].[health_factor]
(
   [clinical_reminder_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'health_factor_dialog_prompt'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_hlth_fctr_dlg_prmpt_dp' AND so.type in (N'U'))
   DROP INDEX [dbo].[health_factor_dialog_prompt].[idx_fk_hlth_fctr_dlg_prmpt_dp] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_hlth_fctr_dlg_prmpt_dp] ON [dbo].[health_factor_dialog_prompt]
(
   [dialog_prompt_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'health_factor_dialog_prompt'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_hlth_fctr_dlg_prmpt_hf' AND so.type in (N'U'))
   DROP INDEX [dbo].[health_factor_dialog_prompt].[idx_fk_hlth_fctr_dlg_prmpt_hf] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_hlth_fctr_dlg_prmpt_hf] ON [dbo].[health_factor_dialog_prompt]
(
   [health_factor_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'measure_answer'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_measure_answer_meas' AND so.type in (N'U'))
   DROP INDEX [dbo].[measure_answer].[idx_fk_measure_answer_meas] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_measure_answer_meas] ON [dbo].[measure_answer]
(
   [measure_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'measure'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_measure_measure_type' AND so.type in (N'U'))
   DROP INDEX [dbo].[measure].[idx_fk_measure_measure_type] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_measure_measure_type] ON [dbo].[measure]
(
   [measure_type_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'measure'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_measure_parent' AND so.type in (N'U'))
   DROP INDEX [dbo].[measure].[idx_fk_measure_parent] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_measure_parent] ON [dbo].[measure]
(
   [parent_measure_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'note_title_map'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_note_title_map_nt' AND so.type in (N'U'))
   DROP INDEX [dbo].[note_title_map].[idx_fk_note_title_map_nt] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_note_title_map_nt] ON [dbo].[note_title_map]
(
   [note_title_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'note_title_map'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_note_title_map_prgm' AND so.type in (N'U'))
   DROP INDEX [dbo].[note_title_map].[idx_fk_note_title_map_prgm] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_note_title_map_prgm] ON [dbo].[note_title_map]
(
   [program_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'program_survey'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_prgm_srvy_prgm' AND so.type in (N'U'))
   DROP INDEX [dbo].[program_survey].[idx_fk_prgm_srvy_prgm] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_prgm_srvy_prgm] ON [dbo].[program_survey]
(
   [program_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'program_survey'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_prgm_srvy_srvy' AND so.type in (N'U'))
   DROP INDEX [dbo].[program_survey].[idx_fk_prgm_srvy_srvy] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_prgm_srvy_srvy] ON [dbo].[program_survey]
(
   [survey_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'rule_assessment_variable'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_rule_assessment_variable_rule' AND so.type in (N'U'))
   DROP INDEX [dbo].[rule_assessment_variable].[idx_fk_rule_assessment_variable_rule] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_rule_assessment_variable_rule] ON [dbo].[rule_assessment_variable]
(
   [rule_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'rule_assessment_variable'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_rule_assessment_variable_variable' AND so.type in (N'U'))
   DROP INDEX [dbo].[rule_assessment_variable].[idx_fk_rule_assessment_variable_variable] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_rule_assessment_variable_variable] ON [dbo].[rule_assessment_variable]
(
   [assessment_variable_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'rule_event'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_rule_event_event' AND so.type in (N'U'))
   DROP INDEX [dbo].[rule_event].[idx_fk_rule_event_event] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_rule_event_event] ON [dbo].[rule_event]
(
   [event_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'rule_event'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_rule_event_rule' AND so.type in (N'U'))
   DROP INDEX [dbo].[rule_event].[idx_fk_rule_event_rule] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_rule_event_rule] ON [dbo].[rule_event]
(
   [rule_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'survey_attempt'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_survey_attempt_vas' AND so.type in (N'U'))
   DROP INDEX [dbo].[survey_attempt].[idx_fk_survey_attempt_vas] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_survey_attempt_vas] ON [dbo].[survey_attempt]
(
   [veteran_assessment_survey_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'survey_measure_response'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_survey_meas_resp_va' AND so.type in (N'U'))
   DROP INDEX [dbo].[survey_measure_response].[idx_fk_survey_meas_resp_va] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_survey_meas_resp_va] ON [dbo].[survey_measure_response]
(
   [veteran_assessment_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'survey_measure_response'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_survey_meas_resp_vm' AND so.type in (N'U'))
   DROP INDEX [dbo].[survey_measure_response].[idx_fk_survey_meas_resp_vm] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_survey_meas_resp_vm] ON [dbo].[survey_measure_response]
(
   [measure_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'survey_measure_response'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_survey_meas_resp_vma' AND so.type in (N'U'))
   DROP INDEX [dbo].[survey_measure_response].[idx_fk_survey_meas_resp_vma] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_survey_meas_resp_vma] ON [dbo].[survey_measure_response]
(
   [measure_answer_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'survey_measure_response'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_survey_meas_resp_vs' AND so.type in (N'U'))
   DROP INDEX [dbo].[survey_measure_response].[idx_fk_survey_meas_resp_vs] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_survey_meas_resp_vs] ON [dbo].[survey_measure_response]
(
   [survey_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'survey_page_measure'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_survey_page_measure_m' AND so.type in (N'U'))
   DROP INDEX [dbo].[survey_page_measure].[idx_fk_survey_page_measure_m] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_survey_page_measure_m] ON [dbo].[survey_page_measure]
(
   [measure_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'survey_page_measure'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_survey_page_measure_sp' AND so.type in (N'U'))
   DROP INDEX [dbo].[survey_page_measure].[idx_fk_survey_page_measure_sp] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_survey_page_measure_sp] ON [dbo].[survey_page_measure]
(
   [survey_page_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'survey_page'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_survey_page_survey' AND so.type in (N'U'))
   DROP INDEX [dbo].[survey_page].[idx_fk_survey_page_survey] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_survey_page_survey] ON [dbo].[survey_page]
(
   [survey_page_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'survey'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_survey_survey_section' AND so.type in (N'U'))
   DROP INDEX [dbo].[survey].[idx_fk_survey_survey_section] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_survey_survey_section] ON [dbo].[survey]
(
   [survey_section_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'survey_template'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_survey_template_survey' AND so.type in (N'U'))
   DROP INDEX [dbo].[survey_template].[idx_fk_survey_template_survey] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_survey_template_survey] ON [dbo].[survey_template]
(
   [survey_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'survey_template'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_survey_template_template' AND so.type in (N'U'))
   DROP INDEX [dbo].[survey_template].[idx_fk_survey_template_template] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_survey_template_template] ON [dbo].[survey_template]
(
   [template_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'user_clinic'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_user_clinic_clinic' AND so.type in (N'U'))
   DROP INDEX [dbo].[user_clinic].[idx_fk_user_clinic_clinic] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_user_clinic_clinic] ON [dbo].[user_clinic]
(
   [clinic_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'user_clinic'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_user_clinic_user' AND so.type in (N'U'))
   DROP INDEX [dbo].[user_clinic].[idx_fk_user_clinic_user] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_user_clinic_user] ON [dbo].[user_clinic]
(
   [user_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'user_program'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_user_program_program' AND so.type in (N'U'))
   DROP INDEX [dbo].[user_program].[idx_fk_user_program_program] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_user_program_program] ON [dbo].[user_program]
(
   [program_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'user_program'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_user_program_user' AND so.type in (N'U'))
   DROP INDEX [dbo].[user_program].[idx_fk_user_program_user] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_user_program_user] ON [dbo].[user_program]
(
   [user_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'user'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_user_role' AND so.type in (N'U'))
   DROP INDEX [dbo].[user].[idx_fk_user_role] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_user_role] ON [dbo].[user]
(
   [role_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'user'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_user_status' AND so.type in (N'U'))
   DROP INDEX [dbo].[user].[idx_fk_user_status] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_user_status] ON [dbo].[user]
(
   [user_status_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'veteran_assessment_note'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_va_note_cn' AND so.type in (N'U'))
   DROP INDEX [dbo].[veteran_assessment_note].[idx_fk_va_note_cn] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_va_note_cn] ON [dbo].[veteran_assessment_note]
(
   [clinical_note_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'veteran_assessment_note'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_va_note_va' AND so.type in (N'U'))
   DROP INDEX [dbo].[veteran_assessment_note].[idx_fk_va_note_va] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_va_note_va] ON [dbo].[veteran_assessment_note]
(
   [veteran_assessment_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'veteran_assessment'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_veteran_assess_battery' AND so.type in (N'U'))
   DROP INDEX [dbo].[veteran_assessment].[idx_fk_veteran_assess_battery] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_veteran_assess_battery] ON [dbo].[veteran_assessment]
(
   [battery_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'veteran_assessment'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_veteran_assess_clinic' AND so.type in (N'U'))
   DROP INDEX [dbo].[veteran_assessment].[idx_fk_veteran_assess_clinic] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_veteran_assess_clinic] ON [dbo].[veteran_assessment]
(
   [clinic_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'veteran_assessment'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_veteran_assess_clinician' AND so.type in (N'U'))
   DROP INDEX [dbo].[veteran_assessment].[idx_fk_veteran_assess_clinician] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_veteran_assess_clinician] ON [dbo].[veteran_assessment]
(
   [clinician_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'veteran_assessment'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_veteran_assess_creator' AND so.type in (N'U'))
   DROP INDEX [dbo].[veteran_assessment].[idx_fk_veteran_assess_creator] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_veteran_assess_creator] ON [dbo].[veteran_assessment]
(
   [created_by_user_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'veteran_assessment'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_veteran_assess_note_t' AND so.type in (N'U'))
   DROP INDEX [dbo].[veteran_assessment].[idx_fk_veteran_assess_note_t] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_veteran_assess_note_t] ON [dbo].[veteran_assessment]
(
   [note_title_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'veteran_assessment'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_veteran_assess_prgm' AND so.type in (N'U'))
   DROP INDEX [dbo].[veteran_assessment].[idx_fk_veteran_assess_prgm] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_veteran_assess_prgm] ON [dbo].[veteran_assessment]
(
   [program_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'veteran_assessment'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_veteran_assess_status' AND so.type in (N'U'))
   DROP INDEX [dbo].[veteran_assessment].[idx_fk_veteran_assess_status] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_veteran_assess_status] ON [dbo].[veteran_assessment]
(
   [assessment_status_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'veteran_assessment_survey'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_veteran_assess_survey_pa' AND so.type in (N'U'))
   DROP INDEX [dbo].[veteran_assessment_survey].[idx_fk_veteran_assess_survey_pa] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_veteran_assess_survey_pa] ON [dbo].[veteran_assessment_survey]
(
   [veteran_assessment_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'veteran_assessment_survey'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_veteran_assess_survey_surv' AND so.type in (N'U'))
   DROP INDEX [dbo].[veteran_assessment_survey].[idx_fk_veteran_assess_survey_surv] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_veteran_assess_survey_surv] ON [dbo].[veteran_assessment_survey]
(
   [survey_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'veteran_assessment'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_veteran_assess_veteran' AND so.type in (N'U'))
   DROP INDEX [dbo].[veteran_assessment].[idx_fk_veteran_assess_veteran] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_veteran_assess_veteran] ON [dbo].[veteran_assessment]
(
   [veteran_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'veteran_assessment_dashboard_alert'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_veteran_assessment_dashboard_alert_alert' AND so.type in (N'U'))
   DROP INDEX [dbo].[veteran_assessment_dashboard_alert].[idx_fk_veteran_assessment_dashboard_alert_alert] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_veteran_assessment_dashboard_alert_alert] ON [dbo].[veteran_assessment_dashboard_alert]
(
   [dashboard_alert_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'veteran_assessment_dashboard_alert'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_veteran_assessment_dashboard_alert_assessment' AND so.type in (N'U'))
   DROP INDEX [dbo].[veteran_assessment_dashboard_alert].[idx_fk_veteran_assessment_dashboard_alert_assessment] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_veteran_assessment_dashboard_alert_assessment] ON [dbo].[veteran_assessment_dashboard_alert]
(
   [veteran_assessment_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'veteran_assessment_health_factor'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_veteran_assessment_health_factor_assessment' AND so.type in (N'U'))
   DROP INDEX [dbo].[veteran_assessment_health_factor].[idx_fk_veteran_assessment_health_factor_assessment] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_veteran_assessment_health_factor_assessment] ON [dbo].[veteran_assessment_health_factor]
(
   [veteran_assessment_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'veteran_assessment_consult'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_veteran_assessment_health_factor_assessment' AND so.type in (N'U'))
   DROP INDEX [dbo].[veteran_assessment_consult].[idx_fk_veteran_assessment_health_factor_assessment] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_veteran_assessment_health_factor_assessment] ON [dbo].[veteran_assessment_consult]
(
   [consult_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'veteran_assessment_health_factor'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_veteran_assessment_health_factor_health_factor' AND so.type in (N'U'))
   DROP INDEX [dbo].[veteran_assessment_health_factor].[idx_fk_veteran_assessment_health_factor_health_factor] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_veteran_assessment_health_factor_health_factor] ON [dbo].[veteran_assessment_health_factor]
(
   [health_factor_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'veteran_assessment_consult'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_veteran_assessment_health_factor_health_factor' AND so.type in (N'U'))
   DROP INDEX [dbo].[veteran_assessment_consult].[idx_fk_veteran_assessment_health_factor_health_factor] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_veteran_assessment_health_factor_health_factor] ON [dbo].[veteran_assessment_consult]
(
   [veteran_assessment_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'veteran_assessment_measure_visibility'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_veteran_assessment_measure_visibility_assessment' AND so.type in (N'U'))
   DROP INDEX [dbo].[veteran_assessment_measure_visibility].[idx_fk_veteran_assessment_measure_visibility_assessment] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_veteran_assessment_measure_visibility_assessment] ON [dbo].[veteran_assessment_measure_visibility]
(
   [veteran_assessment_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF  EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'veteran_assessment_measure_visibility'  AND sc.name = N'dbo'  AND si.name = N'idx_fk_veteran_assessment_measure_visibility_measure' AND so.type in (N'U'))
   DROP INDEX [dbo].[veteran_assessment_measure_visibility].[idx_fk_veteran_assessment_measure_visibility_measure] 
GO
CREATE NONCLUSTERED INDEX [idx_fk_veteran_assessment_measure_visibility_measure] ON [dbo].[veteran_assessment_measure_visibility]
(
   [measure_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_assessment_var_id'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[assessment_formula] DROP CONSTRAINT [fk_assessment_var_id]
 GO



ALTER TABLE [dbo].[assessment_formula]
 ADD CONSTRAINT [fk_assessment_var_id]
 FOREIGN KEY 
   ([assessment_variable_id])
 REFERENCES 
   [SDC-PROD].[dbo].[assessment_variable]     ([assessment_variable_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO


USE [SDC-PROD]
GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_assessment_variable_parent'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[assessment_var_children] DROP CONSTRAINT [fk_assessment_variable_parent]
 GO



ALTER TABLE [dbo].[assessment_var_children]
 ADD CONSTRAINT [fk_assessment_variable_parent]
 FOREIGN KEY 
   ([variable_parent])
 REFERENCES 
   [SDC-PROD].[dbo].[assessment_variable]     ([assessment_variable_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_assessment_variable_type'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[assessment_variable] DROP CONSTRAINT [fk_assessment_variable_type]
 GO



ALTER TABLE [dbo].[assessment_variable]
 ADD CONSTRAINT [fk_assessment_variable_type]
 FOREIGN KEY 
   ([assessment_variable_type_id])
 REFERENCES 
   [SDC-PROD].[dbo].[assessment_variable_type]     ([assessment_variable_type_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_measure'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[assessment_variable] DROP CONSTRAINT [fk_measure]
 GO



ALTER TABLE [dbo].[assessment_variable]
 ADD CONSTRAINT [fk_measure]
 FOREIGN KEY 
   ([measure_id])
 REFERENCES 
   [SDC-PROD].[dbo].[measure]     ([measure_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_measure_answer'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[assessment_variable] DROP CONSTRAINT [fk_measure_answer]
 GO



ALTER TABLE [dbo].[assessment_variable]
 ADD CONSTRAINT [fk_measure_answer]
 FOREIGN KEY 
   ([measure_answer_id])
 REFERENCES 
   [SDC-PROD].[dbo].[measure_answer]     ([measure_answer_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_assessment_variable_column_av'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[assessment_variable_column] DROP CONSTRAINT [fk_assessment_variable_column_av]
 GO



ALTER TABLE [dbo].[assessment_variable_column]
 ADD CONSTRAINT [fk_assessment_variable_column_av]
 FOREIGN KEY 
   ([assessment_variable_id])
 REFERENCES 
   [SDC-PROD].[dbo].[assessment_variable]     ([assessment_variable_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_bttry_srvy_bttry'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[battery_survey] DROP CONSTRAINT [fk_bttry_srvy_bttry]
 GO



ALTER TABLE [dbo].[battery_survey]
 ADD CONSTRAINT [fk_bttry_srvy_bttry]
 FOREIGN KEY 
   ([battery_id])
 REFERENCES 
   [SDC-PROD].[dbo].[battery]     ([battery_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_bttry_srvy_srvy'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[battery_survey] DROP CONSTRAINT [fk_bttry_srvy_srvy]
 GO



ALTER TABLE [dbo].[battery_survey]
 ADD CONSTRAINT [fk_bttry_srvy_srvy]
 FOREIGN KEY 
   ([survey_id])
 REFERENCES 
   [SDC-PROD].[dbo].[survey]     ([survey_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_battery_template_battery'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[battery_template] DROP CONSTRAINT [fk_battery_template_battery]
 GO



ALTER TABLE [dbo].[battery_template]
 ADD CONSTRAINT [fk_battery_template_battery]
 FOREIGN KEY 
   ([battery_id])
 REFERENCES 
   [SDC-PROD].[dbo].[battery]     ([battery_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_battery_template_template'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[battery_template] DROP CONSTRAINT [fk_battery_template_template]
 GO



ALTER TABLE [dbo].[battery_template]
 ADD CONSTRAINT [fk_battery_template_template]
 FOREIGN KEY 
   ([template_id])
 REFERENCES 
   [SDC-PROD].[dbo].[template]     ([template_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_clnc_prgm_clnc'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[clinic_program] DROP CONSTRAINT [fk_clnc_prgm_clnc]
 GO



ALTER TABLE [dbo].[clinic_program]
 ADD CONSTRAINT [fk_clnc_prgm_clnc]
 FOREIGN KEY 
   ([clinic_id])
 REFERENCES 
   [SDC-PROD].[dbo].[clinic]     ([clinic_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_clnc_prgm_prgm'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[clinic_program] DROP CONSTRAINT [fk_clnc_prgm_prgm]
 GO



ALTER TABLE [dbo].[clinic_program]
 ADD CONSTRAINT [fk_clnc_prgm_prgm]
 FOREIGN KEY 
   ([program_id])
 REFERENCES 
   [SDC-PROD].[dbo].[program]     ([program_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_clnc_srvy_clnc'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[clinic_survey] DROP CONSTRAINT [fk_clnc_srvy_clnc]
 GO



ALTER TABLE [dbo].[clinic_survey]
 ADD CONSTRAINT [fk_clnc_srvy_clnc]
 FOREIGN KEY 
   ([clinic_id])
 REFERENCES 
   [SDC-PROD].[dbo].[clinic]     ([clinic_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_clnc_srvy_srvy'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[clinic_survey] DROP CONSTRAINT [fk_clnc_srvy_srvy]
 GO



ALTER TABLE [dbo].[clinic_survey]
 ADD CONSTRAINT [fk_clnc_srvy_srvy]
 FOREIGN KEY 
   ([survey_id])
 REFERENCES 
   [SDC-PROD].[dbo].[survey]     ([survey_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_clncl_rmndr_srvy_clncl'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[clinical_reminder_survey] DROP CONSTRAINT [fk_clncl_rmndr_srvy_clncl]
 GO



ALTER TABLE [dbo].[clinical_reminder_survey]
 ADD CONSTRAINT [fk_clncl_rmndr_srvy_clncl]
 FOREIGN KEY 
   ([clinical_reminder_id])
 REFERENCES 
   [SDC-PROD].[dbo].[clinical_reminder]     ([clinical_reminder_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_clncl_rmndr_srvy_srvy'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[clinical_reminder_survey] DROP CONSTRAINT [fk_clncl_rmndr_srvy_srvy]
 GO



ALTER TABLE [dbo].[clinical_reminder_survey]
 ADD CONSTRAINT [fk_clncl_rmndr_srvy_srvy]
 FOREIGN KEY 
   ([survey_id])
 REFERENCES 
   [SDC-PROD].[dbo].[survey]     ([survey_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_dashboard_alert_type'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[dashboard_alert] DROP CONSTRAINT [fk_dashboard_alert_type]
 GO



ALTER TABLE [dbo].[dashboard_alert]
 ADD CONSTRAINT [fk_dashboard_alert_type]
 FOREIGN KEY 
   ([dashboard_alert_type_id])
 REFERENCES 
   [SDC-PROD].[dbo].[dashboard_alert_type]     ([dashboard_alert_type_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_action_action_type'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[event] DROP CONSTRAINT [fk_action_action_type]
 GO



ALTER TABLE [dbo].[event]
 ADD CONSTRAINT [fk_action_action_type]
 FOREIGN KEY 
   ([event_type_id])
 REFERENCES 
   [SDC-PROD].[dbo].[event_type]     ([event_type_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO


USE [SDC-PROD]
GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_program_el'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[export_log] DROP CONSTRAINT [fk_program_el]
 GO



ALTER TABLE [dbo].[export_log]
 ADD CONSTRAINT [fk_program_el]
 FOREIGN KEY 
   ([program_id])
 REFERENCES 
   [SDC-PROD].[dbo].[program]     ([program_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_user_el1'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[export_log] DROP CONSTRAINT [fk_user_el1]
 GO



ALTER TABLE [dbo].[export_log]
 ADD CONSTRAINT [fk_user_el1]
 FOREIGN KEY 
   ([exported_by_user_id])
 REFERENCES 
   [SDC-PROD].[dbo].[user]     ([user_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_user_el2'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[export_log] DROP CONSTRAINT [fk_user_el2]
 GO



ALTER TABLE [dbo].[export_log]
 ADD CONSTRAINT [fk_user_el2]
 FOREIGN KEY 
   ([clinician_user_id])
 REFERENCES 
   [SDC-PROD].[dbo].[user]     ([user_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_user_el3'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[export_log] DROP CONSTRAINT [fk_user_el3]
 GO



ALTER TABLE [dbo].[export_log]
 ADD CONSTRAINT [fk_user_el3]
 FOREIGN KEY 
   ([created_by_user_id])
 REFERENCES 
   [SDC-PROD].[dbo].[user]     ([user_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_veteran_el'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[export_log] DROP CONSTRAINT [fk_veteran_el]
 GO



ALTER TABLE [dbo].[export_log]
 ADD CONSTRAINT [fk_veteran_el]
 FOREIGN KEY 
   ([veteran_id])
 REFERENCES 
   [SDC-PROD].[dbo].[veteran]     ([veteran_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_export_log_id'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[export_log_audit] DROP CONSTRAINT [fk_export_log_id]
 GO



ALTER TABLE [dbo].[export_log_audit]
 ADD CONSTRAINT [fk_export_log_id]
 FOREIGN KEY 
   ([export_log_id])
 REFERENCES 
   [SDC-PROD].[dbo].[export_log]     ([export_log_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_exported_by_user_id'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[export_log_audit] DROP CONSTRAINT [fk_exported_by_user_id]
 GO



ALTER TABLE [dbo].[export_log_audit]
 ADD CONSTRAINT [fk_exported_by_user_id]
 FOREIGN KEY 
   ([exported_by_user_id])
 REFERENCES 
   [SDC-PROD].[dbo].[user]     ([user_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_health_factor_reminder'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[health_factor] DROP CONSTRAINT [fk_health_factor_reminder]
 GO



ALTER TABLE [dbo].[health_factor]
 ADD CONSTRAINT [fk_health_factor_reminder]
 FOREIGN KEY 
   ([clinical_reminder_id])
 REFERENCES 
   [SDC-PROD].[dbo].[clinical_reminder]     ([clinical_reminder_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_hlth_fctr_dlg_prmpt_dp'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[health_factor_dialog_prompt] DROP CONSTRAINT [fk_hlth_fctr_dlg_prmpt_dp]
 GO



ALTER TABLE [dbo].[health_factor_dialog_prompt]
 ADD CONSTRAINT [fk_hlth_fctr_dlg_prmpt_dp]
 FOREIGN KEY 
   ([dialog_prompt_id])
 REFERENCES 
   [SDC-PROD].[dbo].[dialog_prompt]     ([dialog_prompt_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_hlth_fctr_dlg_prmpt_hf'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[health_factor_dialog_prompt] DROP CONSTRAINT [fk_hlth_fctr_dlg_prmpt_hf]
 GO



ALTER TABLE [dbo].[health_factor_dialog_prompt]
 ADD CONSTRAINT [fk_hlth_fctr_dlg_prmpt_hf]
 FOREIGN KEY 
   ([health_factor_id])
 REFERENCES 
   [SDC-PROD].[dbo].[health_factor]     ([health_factor_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_measure_measure_type'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[measure] DROP CONSTRAINT [fk_measure_measure_type]
 GO



ALTER TABLE [dbo].[measure]
 ADD CONSTRAINT [fk_measure_measure_type]
 FOREIGN KEY 
   ([measure_type_id])
 REFERENCES 
   [SDC-PROD].[dbo].[measure_type]     ([measure_type_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO




USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_calculation_type'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[measure_answer] DROP CONSTRAINT [fk_calculation_type]
 GO



ALTER TABLE [dbo].[measure_answer]
 ADD CONSTRAINT [fk_calculation_type]
 FOREIGN KEY 
   ([calculation_type_id])
 REFERENCES 
   [SDC-PROD].[dbo].[calculation_type]     ([calculation_type_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_measure_answer_measure'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[measure_answer] DROP CONSTRAINT [fk_measure_answer_measure]
 GO



ALTER TABLE [dbo].[measure_answer]
 ADD CONSTRAINT [fk_measure_answer_measure]
 FOREIGN KEY 
   ([measure_id])
 REFERENCES 
   [SDC-PROD].[dbo].[measure]     ([measure_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_measure_answer_validation_measure'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[measure_answer_validation] DROP CONSTRAINT [fk_measure_answer_validation_measure]
 GO



ALTER TABLE [dbo].[measure_answer_validation]
 ADD CONSTRAINT [fk_measure_answer_validation_measure]
 FOREIGN KEY 
   ([measure_answer_id])
 REFERENCES 
   [SDC-PROD].[dbo].[measure_answer]     ([measure_answer_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_measure_answer_validation_validation'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[measure_answer_validation] DROP CONSTRAINT [fk_measure_answer_validation_validation]
 GO



ALTER TABLE [dbo].[measure_answer_validation]
 ADD CONSTRAINT [fk_measure_answer_validation_validation]
 FOREIGN KEY 
   ([validation_id])
 REFERENCES 
   [SDC-PROD].[dbo].[validation]     ([validation_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_measure_validation_measure'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[measure_validation] DROP CONSTRAINT [fk_measure_validation_measure]
 GO



ALTER TABLE [dbo].[measure_validation]
 ADD CONSTRAINT [fk_measure_validation_measure]
 FOREIGN KEY 
   ([measure_id])
 REFERENCES 
   [SDC-PROD].[dbo].[measure]     ([measure_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_measure_validation_validation'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[measure_validation] DROP CONSTRAINT [fk_measure_validation_validation]
 GO



ALTER TABLE [dbo].[measure_validation]
 ADD CONSTRAINT [fk_measure_validation_validation]
 FOREIGN KEY 
   ([validation_id])
 REFERENCES 
   [SDC-PROD].[dbo].[validation]     ([validation_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_note_title_map_nt'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[note_title_map] DROP CONSTRAINT [fk_note_title_map_nt]
 GO



ALTER TABLE [dbo].[note_title_map]
 ADD CONSTRAINT [fk_note_title_map_nt]
 FOREIGN KEY 
   ([note_title_id])
 REFERENCES 
   [SDC-PROD].[dbo].[note_title]     ([note_title_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_note_title_map_prgm'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[note_title_map] DROP CONSTRAINT [fk_note_title_map_prgm]
 GO



ALTER TABLE [dbo].[note_title_map]
 ADD CONSTRAINT [fk_note_title_map_prgm]
 FOREIGN KEY 
   ([program_id])
 REFERENCES 
   [SDC-PROD].[dbo].[program]     ([program_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_program_battery_battery'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[program_battery] DROP CONSTRAINT [fk_program_battery_battery]
 GO



ALTER TABLE [dbo].[program_battery]
 ADD CONSTRAINT [fk_program_battery_battery]
 FOREIGN KEY 
   ([battery_id])
 REFERENCES 
   [SDC-PROD].[dbo].[battery]     ([battery_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_program_battery_program'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[program_battery] DROP CONSTRAINT [fk_program_battery_program]
 GO



ALTER TABLE [dbo].[program_battery]
 ADD CONSTRAINT [fk_program_battery_program]
 FOREIGN KEY 
   ([program_id])
 REFERENCES 
   [SDC-PROD].[dbo].[program]     ([program_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_prgm_srvy_prgm'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[program_survey] DROP CONSTRAINT [fk_prgm_srvy_prgm]
 GO



ALTER TABLE [dbo].[program_survey]
 ADD CONSTRAINT [fk_prgm_srvy_prgm]
 FOREIGN KEY 
   ([program_id])
 REFERENCES 
   [SDC-PROD].[dbo].[program]     ([program_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_prgm_srvy_srvy'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[program_survey] DROP CONSTRAINT [fk_prgm_srvy_srvy]
 GO



ALTER TABLE [dbo].[program_survey]
 ADD CONSTRAINT [fk_prgm_srvy_srvy]
 FOREIGN KEY 
   ([survey_id])
 REFERENCES 
   [SDC-PROD].[dbo].[survey]     ([survey_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_rule_assessment_variable_rule'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[rule_assessment_variable] DROP CONSTRAINT [fk_rule_assessment_variable_rule]
 GO



ALTER TABLE [dbo].[rule_assessment_variable]
 ADD CONSTRAINT [fk_rule_assessment_variable_rule]
 FOREIGN KEY 
   ([rule_id])
 REFERENCES 
   [SDC-PROD].[dbo].[rule]     ([rule_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_rule_assessment_variable_variable'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[rule_assessment_variable] DROP CONSTRAINT [fk_rule_assessment_variable_variable]
 GO



ALTER TABLE [dbo].[rule_assessment_variable]
 ADD CONSTRAINT [fk_rule_assessment_variable_variable]
 FOREIGN KEY 
   ([assessment_variable_id])
 REFERENCES 
   [SDC-PROD].[dbo].[assessment_variable]     ([assessment_variable_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO


USE [SDC-PROD]
GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_rule_event_rule'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[rule_event] DROP CONSTRAINT [fk_rule_event_rule]
 GO



ALTER TABLE [dbo].[rule_event]
 ADD CONSTRAINT [fk_rule_event_rule]
 FOREIGN KEY 
   ([rule_id])
 REFERENCES 
   [SDC-PROD].[dbo].[rule]     ([rule_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_survey_survey_section'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[survey] DROP CONSTRAINT [fk_survey_survey_section]
 GO



ALTER TABLE [dbo].[survey]
 ADD CONSTRAINT [fk_survey_survey_section]
 FOREIGN KEY 
   ([survey_section_id])
 REFERENCES 
   [SDC-PROD].[dbo].[survey_section]     ([survey_section_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_survey_attempt_vas'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[survey_attempt] DROP CONSTRAINT [fk_survey_attempt_vas]
 GO



ALTER TABLE [dbo].[survey_attempt]
 ADD CONSTRAINT [fk_survey_attempt_vas]
 FOREIGN KEY 
   ([veteran_assessment_survey_id])
 REFERENCES 
   [SDC-PROD].[dbo].[veteran_assessment_survey]     ([veteran_assessment_survey_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_survey_meas_resp_va'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[survey_measure_response] DROP CONSTRAINT [fk_survey_meas_resp_va]
 GO



ALTER TABLE [dbo].[survey_measure_response]
 ADD CONSTRAINT [fk_survey_meas_resp_va]
 FOREIGN KEY 
   ([veteran_assessment_id])
 REFERENCES 
   [SDC-PROD].[dbo].[veteran_assessment]     ([veteran_assessment_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_survey_meas_resp_va_copy'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[survey_measure_response] DROP CONSTRAINT [fk_survey_meas_resp_va_copy]
 GO



ALTER TABLE [dbo].[survey_measure_response]
 ADD CONSTRAINT [fk_survey_meas_resp_va_copy]
 FOREIGN KEY 
   ([copiedFromAssessment])
 REFERENCES 
   [SDC-PROD].[dbo].[veteran_assessment]     ([veteran_assessment_id])
    ON DELETE SET NULL
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_survey_meas_resp_vs'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[survey_measure_response] DROP CONSTRAINT [fk_survey_meas_resp_vs]
 GO



ALTER TABLE [dbo].[survey_measure_response]
 ADD CONSTRAINT [fk_survey_meas_resp_vs]
 FOREIGN KEY 
   ([survey_id])
 REFERENCES 
   [SDC-PROD].[dbo].[survey]     ([survey_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_survey_page_survey'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[survey_page] DROP CONSTRAINT [fk_survey_page_survey]
 GO



ALTER TABLE [dbo].[survey_page]
 ADD CONSTRAINT [fk_survey_page_survey]
 FOREIGN KEY 
   ([survey_id])
 REFERENCES 
   [SDC-PROD].[dbo].[survey]     ([survey_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_survey_page_measure_m'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[survey_page_measure] DROP CONSTRAINT [fk_survey_page_measure_m]
 GO



ALTER TABLE [dbo].[survey_page_measure]
 ADD CONSTRAINT [fk_survey_page_measure_m]
 FOREIGN KEY 
   ([measure_id])
 REFERENCES 
   [SDC-PROD].[dbo].[measure]     ([measure_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_survey_page_measure_sp'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[survey_page_measure] DROP CONSTRAINT [fk_survey_page_measure_sp]
 GO



ALTER TABLE [dbo].[survey_page_measure]
 ADD CONSTRAINT [fk_survey_page_measure_sp]
 FOREIGN KEY 
   ([survey_page_id])
 REFERENCES 
   [SDC-PROD].[dbo].[survey_page]     ([survey_page_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_survey_template_survey'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[survey_template] DROP CONSTRAINT [fk_survey_template_survey]
 GO



ALTER TABLE [dbo].[survey_template]
 ADD CONSTRAINT [fk_survey_template_survey]
 FOREIGN KEY 
   ([survey_id])
 REFERENCES 
   [SDC-PROD].[dbo].[survey]     ([survey_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_survey_template_template'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[survey_template] DROP CONSTRAINT [fk_survey_template_template]
 GO



ALTER TABLE [dbo].[survey_template]
 ADD CONSTRAINT [fk_survey_template_template]
 FOREIGN KEY 
   ([template_id])
 REFERENCES 
   [SDC-PROD].[dbo].[template]     ([template_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_template_type'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[template] DROP CONSTRAINT [fk_template_type]
 GO



ALTER TABLE [dbo].[template]
 ADD CONSTRAINT [fk_template_type]
 FOREIGN KEY 
   ([template_type_id])
 REFERENCES 
   [SDC-PROD].[dbo].[template_type]     ([template_type_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_user_role'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[user] DROP CONSTRAINT [fk_user_role]
 GO



ALTER TABLE [dbo].[user]
 ADD CONSTRAINT [fk_user_role]
 FOREIGN KEY 
   ([role_id])
 REFERENCES 
   [SDC-PROD].[dbo].[role]     ([role_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_user_status'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[user] DROP CONSTRAINT [fk_user_status]
 GO



ALTER TABLE [dbo].[user]
 ADD CONSTRAINT [fk_user_status]
 FOREIGN KEY 
   ([user_status_id])
 REFERENCES 
   [SDC-PROD].[dbo].[user_status]     ([user_status_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_user_clinic_clinic'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[user_clinic] DROP CONSTRAINT [fk_user_clinic_clinic]
 GO



ALTER TABLE [dbo].[user_clinic]
 ADD CONSTRAINT [fk_user_clinic_clinic]
 FOREIGN KEY 
   ([clinic_id])
 REFERENCES 
   [SDC-PROD].[dbo].[clinic]     ([clinic_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_user_clinic_user'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[user_clinic] DROP CONSTRAINT [fk_user_clinic_user]
 GO



ALTER TABLE [dbo].[user_clinic]
 ADD CONSTRAINT [fk_user_clinic_user]
 FOREIGN KEY 
   ([user_id])
 REFERENCES 
   [SDC-PROD].[dbo].[user]     ([user_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_user_program_program'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[user_program] DROP CONSTRAINT [fk_user_program_program]
 GO



ALTER TABLE [dbo].[user_program]
 ADD CONSTRAINT [fk_user_program_program]
 FOREIGN KEY 
   ([program_id])
 REFERENCES 
   [SDC-PROD].[dbo].[program]     ([program_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_user_program_user'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[user_program] DROP CONSTRAINT [fk_user_program_user]
 GO



ALTER TABLE [dbo].[user_program]
 ADD CONSTRAINT [fk_user_program_user]
 FOREIGN KEY 
   ([user_id])
 REFERENCES 
   [SDC-PROD].[dbo].[user]     ([user_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO


USE [SDC-PROD]
GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_template'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[variable_template] DROP CONSTRAINT [fk_template]
 GO



ALTER TABLE [dbo].[variable_template]
 ADD CONSTRAINT [fk_template]
 FOREIGN KEY 
   ([template_id])
 REFERENCES 
   [SDC-PROD].[dbo].[template]     ([template_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_veteran_assess_battery'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[veteran_assessment] DROP CONSTRAINT [fk_veteran_assess_battery]
 GO



ALTER TABLE [dbo].[veteran_assessment]
 ADD CONSTRAINT [fk_veteran_assess_battery]
 FOREIGN KEY 
   ([battery_id])
 REFERENCES 
   [SDC-PROD].[dbo].[battery]     ([battery_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_veteran_assess_clinic'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[veteran_assessment] DROP CONSTRAINT [fk_veteran_assess_clinic]
 GO



ALTER TABLE [dbo].[veteran_assessment]
 ADD CONSTRAINT [fk_veteran_assess_clinic]
 FOREIGN KEY 
   ([clinic_id])
 REFERENCES 
   [SDC-PROD].[dbo].[clinic]     ([clinic_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_veteran_assess_clinician'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[veteran_assessment] DROP CONSTRAINT [fk_veteran_assess_clinician]
 GO



ALTER TABLE [dbo].[veteran_assessment]
 ADD CONSTRAINT [fk_veteran_assess_clinician]
 FOREIGN KEY 
   ([clinician_id])
 REFERENCES 
   [SDC-PROD].[dbo].[user]     ([user_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_veteran_assess_created_by'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[veteran_assessment] DROP CONSTRAINT [fk_veteran_assess_created_by]
 GO



ALTER TABLE [dbo].[veteran_assessment]
 ADD CONSTRAINT [fk_veteran_assess_created_by]
 FOREIGN KEY 
   ([created_by_user_id])
 REFERENCES 
   [SDC-PROD].[dbo].[user]     ([user_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_veteran_assess_note_title'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[veteran_assessment] DROP CONSTRAINT [fk_veteran_assess_note_title]
 GO



ALTER TABLE [dbo].[veteran_assessment]
 ADD CONSTRAINT [fk_veteran_assess_note_title]
 FOREIGN KEY 
   ([note_title_id])
 REFERENCES 
   [SDC-PROD].[dbo].[note_title]     ([note_title_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_veteran_assess_prgm'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[veteran_assessment] DROP CONSTRAINT [fk_veteran_assess_prgm]
 GO



ALTER TABLE [dbo].[veteran_assessment]
 ADD CONSTRAINT [fk_veteran_assess_prgm]
 FOREIGN KEY 
   ([program_id])
 REFERENCES 
   [SDC-PROD].[dbo].[program]     ([program_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_veteran_assess_signed_by'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[veteran_assessment] DROP CONSTRAINT [fk_veteran_assess_signed_by]
 GO



ALTER TABLE [dbo].[veteran_assessment]
 ADD CONSTRAINT [fk_veteran_assess_signed_by]
 FOREIGN KEY 
   ([signed_by_user_id])
 REFERENCES 
   [SDC-PROD].[dbo].[user]     ([user_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_veteran_assess_status'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[veteran_assessment] DROP CONSTRAINT [fk_veteran_assess_status]
 GO



ALTER TABLE [dbo].[veteran_assessment]
 ADD CONSTRAINT [fk_veteran_assess_status]
 FOREIGN KEY 
   ([assessment_status_id])
 REFERENCES 
   [SDC-PROD].[dbo].[assessment_status]     ([assessment_status_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_veteran_assess_veteran'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[veteran_assessment] DROP CONSTRAINT [fk_veteran_assess_veteran]
 GO



ALTER TABLE [dbo].[veteran_assessment]
 ADD CONSTRAINT [fk_veteran_assess_veteran]
 FOREIGN KEY 
   ([veteran_id])
 REFERENCES 
   [SDC-PROD].[dbo].[veteran]     ([veteran_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_assessment_status_id'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[veteran_assessment_audit_log] DROP CONSTRAINT [fk_assessment_status_id]
 GO



ALTER TABLE [dbo].[veteran_assessment_audit_log]
 ADD CONSTRAINT [fk_assessment_status_id]
 FOREIGN KEY 
   ([assessment_status_id])
 REFERENCES 
   [SDC-PROD].[dbo].[assessment_status]     ([assessment_status_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_person_type_id'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[veteran_assessment_audit_log] DROP CONSTRAINT [fk_person_type_id]
 GO



ALTER TABLE [dbo].[veteran_assessment_audit_log]
 ADD CONSTRAINT [fk_person_type_id]
 FOREIGN KEY 
   ([person_type_id])
 REFERENCES 
   [SDC-PROD].[dbo].[person_type]     ([person_type_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_veteran_assessment_event_id'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[veteran_assessment_audit_log] DROP CONSTRAINT [fk_veteran_assessment_event_id]
 GO



ALTER TABLE [dbo].[veteran_assessment_audit_log]
 ADD CONSTRAINT [fk_veteran_assessment_event_id]
 FOREIGN KEY 
   ([veteran_assessment_event_id])
 REFERENCES 
   [SDC-PROD].[dbo].[veteran_assessment_event]     ([veteran_assessment_event_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_veteran_assessment_consult_assessment'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[veteran_assessment_consult] DROP CONSTRAINT [fk_veteran_assessment_consult_assessment]
 GO



ALTER TABLE [dbo].[veteran_assessment_consult]
 ADD CONSTRAINT [fk_veteran_assessment_consult_assessment]
 FOREIGN KEY 
   ([veteran_assessment_id])
 REFERENCES 
   [SDC-PROD].[dbo].[veteran_assessment]     ([veteran_assessment_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_veteran_assessment_consult_consult'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[veteran_assessment_consult] DROP CONSTRAINT [fk_veteran_assessment_consult_consult]
 GO



ALTER TABLE [dbo].[veteran_assessment_consult]
 ADD CONSTRAINT [fk_veteran_assessment_consult_consult]
 FOREIGN KEY 
   ([consult_id])
 REFERENCES 
   [SDC-PROD].[dbo].[consult]     ([consult_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_veteran_assessment_dashboard_alert_alert'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[veteran_assessment_dashboard_alert] DROP CONSTRAINT [fk_veteran_assessment_dashboard_alert_alert]
 GO



ALTER TABLE [dbo].[veteran_assessment_dashboard_alert]
 ADD CONSTRAINT [fk_veteran_assessment_dashboard_alert_alert]
 FOREIGN KEY 
   ([dashboard_alert_id])
 REFERENCES 
   [SDC-PROD].[dbo].[dashboard_alert]     ([dashboard_alert_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_veteran_assessment_dashboard_alert_assessment'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[veteran_assessment_dashboard_alert] DROP CONSTRAINT [fk_veteran_assessment_dashboard_alert_assessment]
 GO



ALTER TABLE [dbo].[veteran_assessment_dashboard_alert]
 ADD CONSTRAINT [fk_veteran_assessment_dashboard_alert_assessment]
 FOREIGN KEY 
   ([veteran_assessment_id])
 REFERENCES 
   [SDC-PROD].[dbo].[veteran_assessment]     ([veteran_assessment_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_veteran_assessment_health_factor_assessment'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[veteran_assessment_health_factor] DROP CONSTRAINT [fk_veteran_assessment_health_factor_assessment]
 GO



ALTER TABLE [dbo].[veteran_assessment_health_factor]
 ADD CONSTRAINT [fk_veteran_assessment_health_factor_assessment]
 FOREIGN KEY 
   ([veteran_assessment_id])
 REFERENCES 
   [SDC-PROD].[dbo].[veteran_assessment]     ([veteran_assessment_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_veteran_assessment_health_factor_health_factor'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[veteran_assessment_health_factor] DROP CONSTRAINT [fk_veteran_assessment_health_factor_health_factor]
 GO



ALTER TABLE [dbo].[veteran_assessment_health_factor]
 ADD CONSTRAINT [fk_veteran_assessment_health_factor_health_factor]
 FOREIGN KEY 
   ([health_factor_id])
 REFERENCES 
   [SDC-PROD].[dbo].[health_factor]     ([health_factor_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_veteran_assessment_action'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[veteran_assessment_log] DROP CONSTRAINT [fk_veteran_assessment_action]
 GO



ALTER TABLE [dbo].[veteran_assessment_log]
 ADD CONSTRAINT [fk_veteran_assessment_action]
 FOREIGN KEY 
   ([veteran_assessment_action_id])
 REFERENCES 
   [SDC-PROD].[dbo].[veteran_assessment_action]     ([veteran_assessment_action_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_veteran_assessment_measure_visibility_assessment'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[veteran_assessment_measure_visibility] DROP CONSTRAINT [fk_veteran_assessment_measure_visibility_assessment]
 GO



ALTER TABLE [dbo].[veteran_assessment_measure_visibility]
 ADD CONSTRAINT [fk_veteran_assessment_measure_visibility_assessment]
 FOREIGN KEY 
   ([veteran_assessment_id])
 REFERENCES 
   [SDC-PROD].[dbo].[veteran_assessment]     ([veteran_assessment_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_veteran_assessment_measure_visibility_measure'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[veteran_assessment_measure_visibility] DROP CONSTRAINT [fk_veteran_assessment_measure_visibility_measure]
 GO



ALTER TABLE [dbo].[veteran_assessment_measure_visibility]
 ADD CONSTRAINT [fk_veteran_assessment_measure_visibility_measure]
 FOREIGN KEY 
   ([measure_id])
 REFERENCES 
   [SDC-PROD].[dbo].[measure]     ([measure_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO


USE [SDC-PROD]
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_va_note_cn'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[veteran_assessment_note] DROP CONSTRAINT [fk_va_note_cn]
 GO



ALTER TABLE [dbo].[veteran_assessment_note]
 ADD CONSTRAINT [fk_va_note_cn]
 FOREIGN KEY 
   ([clinical_note_id])
 REFERENCES 
   [SDC-PROD].[dbo].[clinical_note]     ([clinical_note_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_va_note_va'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[veteran_assessment_note] DROP CONSTRAINT [fk_va_note_va]
 GO



ALTER TABLE [dbo].[veteran_assessment_note]
 ADD CONSTRAINT [fk_va_note_va]
 FOREIGN KEY 
   ([veteran_assessment_id])
 REFERENCES 
   [SDC-PROD].[dbo].[veteran_assessment]     ([veteran_assessment_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO


USE [SDC-PROD]
GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'fk_veteran_assess_survey_surv'  AND sc.name=N'dbo'  AND type in (N'F'))
ALTER TABLE [dbo].[veteran_assessment_survey] DROP CONSTRAINT [fk_veteran_assess_survey_surv]
 GO



ALTER TABLE [dbo].[veteran_assessment_survey]
 ADD CONSTRAINT [fk_veteran_assess_survey_surv]
 FOREIGN KEY 
   ([survey_id])
 REFERENCES 
   [SDC-PROD].[dbo].[survey]     ([survey_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO
