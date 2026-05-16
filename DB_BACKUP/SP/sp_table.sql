CREATE PROCEDURE [dbo].[sp_table]
    (
    @flag VARCHAR(50),
    @tableId UNIQUEIDENTIFIER = NULL,
    @tableName NVARCHAR(255) = NULL,
    @outletId UNIQUEIDENTIFIER = NULL,
    @sectionId UNIQUEIDENTIFIER = NULL,
    @capacity INT = NULL,
    @addonCapacity INT = NULL,
    @serial INT = NULL,
    @isActive BIT = 1,
    @loggedUser NVARCHAR(255) = NULL
)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY

        IF @flag = 'GETALL'
        BEGIN
        SELECT
            tableId,
            tableName,
            outletId,
            sectionId,
            capacity,
            addonCapacity,
            [serial],
            createdDate,
            createdBy,
            modifiedDate,
            modifiedBy,
            isActive
        FROM m_table
    END

        ELSE IF @flag = 'GETBYOUTLETID'
        BEGIN
        SELECT
            tableId,
            tableName,
            outletId,
            sectionId,
            capacity,
            addonCapacity,
            [serial],
            createdDate,
            createdBy,
            modifiedDate,
            modifiedBy,
            isActive
        FROM m_table
        WHERE outletId = @outletId
            AND isActive = 1
    END

        ELSE IF @flag = 'INSERT'
        BEGIN
        INSERT INTO m_table
            (
            tableId,
            tableName,
            outletId,
            sectionId,
            capacity,
            addonCapacity,
            [serial],
            createdDate,
            createdBy,
            modifiedDate,
            modifiedBy,
            isActive
            )
        VALUES
            (
                NEWID(),
                @tableName,
                @outletId,
                @sectionId,
                @capacity,
                @addonCapacity,
                @serial,
                GETDATE(),
                @loggedUser,
                GETDATE(),
                @loggedUser,
                @isActive
            )
    END

        ELSE IF @flag = 'UPDATE'
        BEGIN
        UPDATE m_table
            SET
                tableName = @tableName,
                outletId = @outletId,
                sectionId = @sectionId,
                capacity = @capacity,
                addonCapacity = @addonCapacity,
                [serial] = @serial,
                modifiedDate = GETDATE(),
                modifiedBy = @loggedUser,
                isActive = @isActive
            WHERE tableId = @tableId
    END

        ELSE IF @flag = 'DELETE'
        BEGIN
        UPDATE m_table
            SET
                isActive = 0,
                modifiedDate = GETDATE(),
                modifiedBy = @loggedUser
            WHERE tableId = @tableId
    END

    END TRY

    BEGIN CATCH
        SELECT
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_MESSAGE() AS ErrorMessage
    END CATCH

END
GO