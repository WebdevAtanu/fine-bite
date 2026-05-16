CREATE PROCEDURE [dbo].[sp_department]
    (
    @flag VARCHAR(50),
    @departmentId UNIQUEIDENTIFIER = NULL,
    @departmentName NVARCHAR(100) = NULL,
    @shortCode NVARCHAR(50) = NULL,
    @channelId UNIQUEIDENTIFIER = NULL,
    @isActive BIT = 1,
    @loggedUser UNIQUEIDENTIFIER = NULL
)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY

        IF @flag = 'GETALL'
        BEGIN
        SELECT
            departmentId,
            departmentName,
            shortCode,
            channelId,
            createdDate,
            createdBy,
            modifiedDate,
            modifiedBy,
            isActive
        FROM m_department
    END

        ELSE IF @flag = 'GETBYID'
        BEGIN
        SELECT
            departmentId,
            departmentName,
            shortCode,
            channelId,
            createdDate,
            createdBy,
            modifiedDate,
            modifiedBy,
            isActive
        FROM m_department
        WHERE departmentId = @departmentId
    END

        ELSE IF @flag = 'INSERT'
        BEGIN
        -- Duplicate check (Name OR ShortCode within same channel)
        IF EXISTS (
                SELECT 1
        FROM m_department
        WHERE (departmentName = @departmentName
            OR shortCode = @shortCode)
            AND channelId = @channelId
            )
            BEGIN
            SELECT 'Department already exists' AS message
            RETURN
        END

        INSERT INTO m_department
            (
            departmentId,
            departmentName,
            shortCode,
            channelId,
            createdDate,
            createdBy,
            modifiedDate,
            modifiedBy,
            isActive
            )
        VALUES
            (
                NEWID(),
                @departmentName,
                @shortCode,
                @channelId,
                GETDATE(),
                @loggedUser,
                GETDATE(),
                @loggedUser,
                @isActive
            )
    END

        ELSE IF @flag = 'UPDATE'
        BEGIN
        -- Duplicate check excluding current record
        IF EXISTS (
                SELECT 1
        FROM m_department
        WHERE (departmentName = @departmentName
            OR shortCode = @shortCode)
            AND channelId = @channelId
            AND departmentId <> @departmentId
            )
            BEGIN
            SELECT 'Department already exists' AS message
            RETURN
        END

        UPDATE m_department
            SET
                departmentName = @departmentName,
                shortCode = @shortCode,
                channelId = @channelId,
                modifiedDate = GETDATE(),
                modifiedBy = @loggedUser,
                isActive = @isActive
            WHERE departmentId = @departmentId
    END

        ELSE IF @flag = 'DELETE'
        BEGIN
        UPDATE m_department
            SET
                isActive = 0,
                modifiedDate = GETDATE(),
                modifiedBy = @loggedUser
            WHERE departmentId = @departmentId
    END

    END TRY

    BEGIN CATCH
        SELECT
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_MESSAGE() AS ErrorMessage
    END CATCH

END
GO