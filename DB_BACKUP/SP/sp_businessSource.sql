CREATE PROCEDURE [dbo].[sp_businessSource]
    (
    @flag VARCHAR(50),
    @businessSourceId UNIQUEIDENTIFIER = NULL,
    @businessSourceName NVARCHAR(100) = NULL,
    @channelId UNIQUEIDENTIFIER = NULL,
    @commisionPercentage DECIMAL(18,4) = NULL,
    @contactPersonName NVARCHAR(50) = NULL,
    @contactPersonPhoneNo NVARCHAR(50) = NULL,
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
            businessSourceId,
            businessSourceName,
            channelId,
            commisionPercentage,
            contactPersonName,
            contactPersonPhoneNo,
            createdDate,
            createdBy,
            modifiedDate,
            modifiedBy,
            isActive
        FROM m_businessSource
    END

        ELSE IF @flag = 'GETBYID'
        BEGIN
        SELECT
            businessSourceId,
            businessSourceName,
            channelId,
            commisionPercentage,
            contactPersonName,
            contactPersonPhoneNo,
            createdDate,
            createdBy,
            modifiedDate,
            modifiedBy,
            isActive
        FROM m_businessSource
        WHERE businessSourceId = @businessSourceId
    END

        ELSE IF @flag = 'INSERT'
        BEGIN

        IF EXISTS (SELECT *
        FROM m_businessSource
        WHERE businessSourceName = @businessSourceName AND channelId = @channelId)
BEGIN
            SELECT 'Business Source already exists' as message
            RETURN
        END

        INSERT INTO m_businessSource
            (
            businessSourceId,
            businessSourceName,
            channelId,
            commisionPercentage,
            contactPersonName,
            contactPersonPhoneNo,
            createdDate,
            createdBy,
            modifiedDate,
            modifiedBy,
            isActive
            )
        VALUES
            (
                NEWID(),
                @businessSourceName,
                @channelId,
                @commisionPercentage,
                @contactPersonName,
                @contactPersonPhoneNo,
                GETDATE(),
                @loggedUser,
                GETDATE(),
                @loggedUser,
                @isActive
            )
    END

        ELSE IF @flag = 'UPDATE'
        BEGIN

        IF EXISTS (SELECT *
        FROM m_businessSource
        WHERE businessSourceName=@businessSourceName AND channelId=@channelId
            AND businessSourceId<>@businessSourceId)
BEGIN
            SELECT 'Business Source already exists' as message
            RETURN
        END

        UPDATE m_businessSource
            SET
                businessSourceName = @businessSourceName,
                channelId = @channelId,
                commisionPercentage = @commisionPercentage,
                contactPersonName = @contactPersonName,
                contactPersonPhoneNo = @contactPersonPhoneNo,
                modifiedDate = GETDATE(),
                modifiedBy = @loggedUser,
                isActive = @isActive
            WHERE businessSourceId = @businessSourceId
    END

        ELSE IF @flag = 'DELETE'
        BEGIN
        UPDATE m_businessSource
            SET
                isActive = 0,
                modifiedDate = GETDATE(),
                modifiedBy = @loggedUser
            WHERE businessSourceId = @businessSourceId
    END

    END TRY

    BEGIN CATCH
        SELECT
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_MESSAGE() AS ErrorMessage
    END CATCH

END
GO